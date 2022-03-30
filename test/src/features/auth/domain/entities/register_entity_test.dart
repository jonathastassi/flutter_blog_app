import 'package:flutter_blog_app/src/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterEntity', () {
    const entity = RegisterEntity(
      email: 'someEmail',
      name: 'someName',
      password: 'somePassword',
    );

    test('Should be created', () {
      expect(entity.email, 'someEmail');
      expect(entity.name, 'someName');
      expect(entity.password, 'somePassword');
    });

    test('Should have 3 props', () {
      expect(entity.props.length, 3);
    });
  });
}
