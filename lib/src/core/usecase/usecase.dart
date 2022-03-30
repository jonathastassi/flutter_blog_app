import 'package:dartz/dartz.dart';
import 'package:flutter_blog_app/src/core/errors/failures.dart';

abstract class Usecase<TOut, TIn> {
  Future<Either<Failure, TOut>> call(TIn params);
}

class NoParams {}
