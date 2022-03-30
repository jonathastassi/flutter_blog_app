import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEntity', () {
    const entity = UserEntity(
      id: 'someId',
      email: 'someEmail',
      name: 'someName',
    );

    test('Should be created', () {
      expect(entity.id, 'someId');
      expect(entity.email, 'someEmail');
      expect(entity.name, 'someName');
    });

    test('Should have 1 props', () {
      expect(entity.props.length, 1);
    });
  });
}
