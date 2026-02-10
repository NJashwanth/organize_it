import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/core/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('taskCollection is stable', () {
      expect(AppConstants.taskCollection, 'tasks');
    });
  });
}
