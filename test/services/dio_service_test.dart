import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/services/dio_service.dart';

class _FakeDio extends Fake implements Dio {}

void main() {
  group('DioService', () {
    test('uses default base url', () {
      final service = DioService();
      expect(service.baseUrl, 'http://localhost:8080');
    });

    test('respects injected base url', () {
      final service = DioService(baseUrl: 'https://api.example.com');
      expect(service.baseUrl, 'https://api.example.com');
    });

    test('accepts injected dio instance', () {
      final dio = _FakeDio();
      final service = DioService(dio: dio, baseUrl: 'https://api.example.com');
      expect(service.baseUrl, 'https://api.example.com');
    });
  });
}
