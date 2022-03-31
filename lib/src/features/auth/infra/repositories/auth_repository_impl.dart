import 'dart:convert';

import 'package:flutter_blog_app/src/core/constants/contants.dart';
import 'package:flutter_blog_app/src/core/secure_storage/secure_storage.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_blog_app/src/features/auth/infra/datasources/auth_api.dart';
import 'package:flutter_blog_app/src/features/auth/infra/models/user_logged_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required SecureStorage secureStorage,
    required AuthApi authApi,
  })  : _secureStorage = secureStorage,
        _authApi = authApi;

  final SecureStorage _secureStorage;
  final AuthApi _authApi;

  @override
  Future<Either<Failure, UserLoggedEntity>> getUserLogged() async {
    try {
      final userLogged =
          await _secureStorage.read(Constants.keyUserLoggedStored);
      if (userLogged == null) {
        return Left(UserNotFound());
      }

      final userLoggedJson = json.decode(userLogged);

      final entity = UserLoggedModel.fromJson(userLoggedJson);

      return Right(entity);
    } catch (_) {
      return Left(UserNotFound());
    }
  }

  @override
  Future<Either<Failure, UserLoggedEntity>> login(
      LoginEntity loginEntity) async {
    try {
      final response = await _authApi.login(
        email: loginEntity.email,
        password: loginEntity.password,
      );

      if (response == null) {
        return Left(UserNotFound());
      }

      return Right(response);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await _secureStorage.delete(Constants.keyUserLoggedStored));
    } catch (_) {
      return Left(ErrorOnLocalStorage());
    }
  }

  @override
  Future<Either<Failure, UserLoggedEntity>> register(
      RegisterEntity registerEntity) async {
    try {
      final response = await _authApi.register(
        name: registerEntity.name,
        email: registerEntity.email,
        password: registerEntity.password,
      );

      return Right(response);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserLogged(
      UserLoggedEntity userLoggedEntity) async {
    try {
      final userLogged = UserLoggedModel(
        user: userLoggedEntity.user,
        authorization: userLoggedEntity.authorization,
      );
      final userLoggedJson = json.encode(userLogged.toJson());

      return Right(await _secureStorage.store(
          Constants.keyUserLoggedStored, userLoggedJson));
    } catch (_) {
      return Left(ErrorOnSaveLocalStorage());
    }
  }
}
