import 'package:api_test/repository/model.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-type': 'application/json; charset=UTF-8'
      }
    ),
  );

  ApiClient._internal();
  static final _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  Future<Response> getData(String endpoint) async {
    return await dio.get(endpoint);
  }

  Future<Response> postData(String endpoint, ApiModel body) async {
    return await dio.post(endpoint, data: body);
  }

  Future<Response> putData(String endpoint, Map<String, dynamic> body) async {
    return await dio.put(endpoint, data: body);
  }

  Future<Response> deleteData(String endpoint) async {
    return await dio.delete(endpoint);
  }
}




