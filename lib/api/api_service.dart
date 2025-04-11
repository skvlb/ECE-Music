import 'package:dio/dio.dart';
import 'api_client.dart';

class ApiService {
  static final Dio _dio = Dio();

  static final ApiClient apiClient = ApiClient(
    _dio,
    baseUrl: 'https://theaudiodb.com/api/v1/json/523532/',
  );
}
