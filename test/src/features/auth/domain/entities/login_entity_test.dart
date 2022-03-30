import 'package:flutter_blog_app/src/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginEntity', () {
    const entity = LoginEntity(
      email: 'someEmail',
      password: 'somePassword',
    );

    test('Should be created', () {
      expect(entity.email, 'someEmail');
      expect(entity.password, 'somePassword');
    });

    test('Should have 2 props', () {
      expect(entity.props.length, 2);
    });
  });
}
