import 'package:flutter_blog_app/src/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure', () {
    test('Validate props', () {
      final failure = ServerFailure();

      expect(failure.props, []);
    });

    test('ServerFailure should be a failure', () {
      expect(ServerFailure(), isA<Failure>());
    });

    test('NoConnectionFailure should be a failure', () {
      expect(NoConnectionFailure(), isA<Failure>());
    });
  });
}
