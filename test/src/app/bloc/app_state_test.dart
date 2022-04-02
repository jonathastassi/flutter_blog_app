import 'package:flutter_blog_app/src/app/bloc/app_state.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_app/src/features/auth/domain/entities/user_logged_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppState', () {
    final authenticatedState = AuthenticatedState(
      userLoggedEntity: const UserLoggedEntity(
        user: UserEntity(id: 'id', name: 'name', email: 'email'),
        authorization: 'authorization',
      ),
    );

    test('UnauthenticatedState should have 0 props', () {
      final state = UnauthenticatedState();

      expect(state.props.length, equals(0));
    });

    test('AuthenticatedState should create appState setting userLogged', () {
      expect(authenticatedState.userLoggedEntity.user.name, 'name');
    });

    test('AuthenticatedState should have 1 props', () {
      expect(authenticatedState.props.length, equals(1));
    });
  });
}
