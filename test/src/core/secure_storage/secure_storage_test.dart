import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter_blog_app/src/core/secure_storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('SecureStorageImpl', () {
    late SecureStorage secureStorage;
    late FlutterSecureStorage mockFlutterSecureStorage;

    setUp(() {
      mockFlutterSecureStorage = MockFlutterSecureStorage();
      secureStorage = SecureStorageImpl(
        flutterSecureStorage: mockFlutterSecureStorage,
      );
    });

    group('read', () {
      test('Should call read from flutterSecureStorage', () async {
        when(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => 'someValue');

        final value = await secureStorage.read('someKey');
        verify(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
            .called(1);
        expect(value, 'someValue');
      });

      test('On error, show rethrow expcetion', () async {
        when(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
            .thenThrow(PlatformException(code: 'code'));

        expect(() => secureStorage.read('someKey'),
            throwsA(isA<PlatformException>()));
        verify(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
            .called(1);
      });
    });

    group('store', () {
      test('Should call write from flutterSecureStorage', () async {
        when(
          () => mockFlutterSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => Void);

        await secureStorage.store('someKey', 'someValue');
        verify(
          () => mockFlutterSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).called(1);
      });

      test('On error, show rethrow expcetion', () async {
        when(
          () => mockFlutterSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenThrow(PlatformException(code: 'code'));

        expect(() => secureStorage.store('someKey', 'someValue'),
            throwsA(isA<PlatformException>()));
        verify(
          () => mockFlutterSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).called(1);
      });
    });

    group('delete', () {
      test('Should call delete from flutterSecureStorage', () async {
        when(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
            .thenAnswer((_) async => Void);

        await secureStorage.delete('someKey');
        verify(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
            .called(1);
      });

      test('On error, show rethrow expcetion', () async {
        when(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
            .thenThrow(PlatformException(code: 'code'));

        expect(() => secureStorage.delete('someKey'),
            throwsA(isA<PlatformException>()));
        verify(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
            .called(1);
      });
    });
  });
}
