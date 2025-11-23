
import 'dart:convert';

import 'package:api_test/repository/model.dart';
import 'package:api_test/utils/http_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Repository {
  final HttpHelper _helper = HttpHelper();

  Repository();

  Future<List<ApiModel>> fetchData() async {
    final response = await _helper.getRequest('posts');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body);
      // print(jsonList);
      if (jsonList is List) {
        return jsonList.map((json) => ApiModel.fromJson(json)).toList();
      } else {
        return [];
      }

    } else {
      throw Exception('Error!');
    }
  }
}

final repositoryProvider = Provider((ref)=>Repository());