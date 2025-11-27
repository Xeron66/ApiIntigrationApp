
import 'package:api_test/repository/model.dart';
import 'package:api_test/utils/dio_helper.dart';
import 'package:api_test/utils/hive_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Repository {
  
  final ApiClient _client = ApiClient();
  Repository();

  // Fetch: Cache First Strategy
  Future<List<ApiModel>> fetchData() async {
    try {
      // 1. Try to get from Hive
      final cached = await HiveHelper.get('posts');

      if (cached != null && cached is List && cached.isNotEmpty) {
        return cached.map((e) {
          // 1. Cast the item to a generic Map
          // 2. Create a NEW Map<String, dynamic> from it
          final cleanMap = Map<String, dynamic>.from(e as Map);
          
          // 3. Pass that clean map to your model
          return ApiModel.fromJson(cleanMap);
        }).toList();
      }

      // 2. If no cache, fetch from API
      final response = await _client.getData('/posts'); // relative path if baseUrl is set

      if (response.statusCode == 200) {
        final List data = response.data;
        
        final apiList = data.map((e) => ApiModel.fromJson(e)).toList();

        // 3. Save to Hive for next time
        await HiveHelper.save(
          'posts',
          apiList.map((e) => e.toJson()).toList(),
        );

        return apiList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow; // Pass error to controller
    }
  }

  // create
  Future<bool> createData(int userId, String title, String body) async {

    ApiModel model = ApiModel(
      userId: userId,
      title: title,
      body: body
    );

    final response = await _client.postData('posts', model);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed! Code:${response.statusCode}, Error: $response');
    }
  }

  // Future<bool> updateData() async {

  // }
}

final repositoryProvider = Provider((ref)=>Repository());