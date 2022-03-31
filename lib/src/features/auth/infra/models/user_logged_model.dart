import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_blog_app/src/features/auth/infra/models/user_model.dart';

class UserLoggedModel extends UserLoggedEntity {
  const UserLoggedModel({
    required UserModel user,
    required String authorization,
  }) : super(
          user: user,
          authorization: authorization,
        );

  factory UserLoggedModel.fromJson(Map<String, dynamic> json) {
    return UserLoggedModel(
      user: UserModel.fromJson(json['user']),
      authorization: json['authorization'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
    ).toJson();
    data['authorization'] = authorization;
    return data;
  }
}
