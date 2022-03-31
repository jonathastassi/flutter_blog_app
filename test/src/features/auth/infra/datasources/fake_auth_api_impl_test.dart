import 'package:faker/faker.dart';
import 'package:flutter_blog_app/src/features/auth/infra/datasources/fake_auth_api_impl.dart';
import 'package:flutter_blog_app/src/features/auth/infra/models/user_logged_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFaker extends Mock implements Faker {}

void main() {
  group('AuthApiImpl', () {
    late FakeAuthApiImpl authApiImpl;

    setUp(() {
      authApiImpl = FakeAuthApiImpl();
    });

    group('login', () {
      test('When receive a valid credentials, should return a UserLoggedModel',
          () async {
        final userLoggedModel = await authApiImpl.login(
          email: 'emailvalido@gmail.com',
          password: '12345678',
        );

        expect(userLoggedModel.runtimeType, UserLoggedModel);
        expect(userLoggedModel!.user.email, 'emailvalido@gmail.com');
      });
    });

    group('register', () {
      test('When receive a valid credentials, should return a UserLoggedModel',
          () async {
        final userLoggedModel = await authApiImpl.register(
          name: 'someName',
          email: 'emailvalido@gmail.com',
          password: '12345678',
        );

        expect(userLoggedModel.runtimeType, UserLoggedModel);
        expect(userLoggedModel.user.name, 'someName');
      });
    });
  });
}
