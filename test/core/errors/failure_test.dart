import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/core/errors/failure.dart';

void main() {
  group('Failure', () {
    test('ServerFailure is a Failure with message', () {
      const failure = ServerFailure('boom');
      expect(failure, isA<Failure>());
      expect(failure.message, 'boom');
    });
  });
}
