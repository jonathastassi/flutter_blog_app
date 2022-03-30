import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEntity', () {
    const entity = UserLoggedEntity(
      user: UserEntity(
        id: 'someId',
        email: 'someEmail',
        name: 'someName',
      ),
      authorization: 'someAuthorization',
    );

    test('Should be created', () {
      expect(entity.user.id, 'someId');
      expect(entity.user.email, 'someEmail');
      expect(entity.user.name, 'someName');
      expect(entity.authorization, 'someAuthorization');
    });

    test('Should have 2 props', () {
      expect(entity.props.length, 2);
    });
  });
}
