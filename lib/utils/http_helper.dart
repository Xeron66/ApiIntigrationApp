import 'package:http/http.dart' as http;

class HttpHelper {
  // Replace this with your actual API Base URL
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Performs a GET request.
  /// [endpoint] is the path after the base URL (e.g., 'posts' or 'users/1')
  /// Using _instance as one instance for all other repos
  /// basically reducing the memory use as it doesnt create more than one instance!
  HttpHelper._internal();
  static final _instance = HttpHelper._internal();
  factory HttpHelper() => _instance;

  Future<http.Response> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return response; 
  }

  // /// (Optional) Helper for POST requests if you need it later
  // static Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body) async {
  //   try {
  //     final Uri uri = Uri.parse('$_baseUrl/$endpoint');
      
  //     final response = await http.post(
  //       uri,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(body),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return jsonDecode(response.body);
  //     } else {
  //       throw Exception('Failed to post data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error occurred: $e');
  //   }
  // }
}