

import 'package:api_test/repository/model.dart';
import 'package:api_test/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class ApiController extends StateNotifier <List<ApiModel>> {
  ApiController(this._repo): super ([]);
  final Repository _repo;
  
  Future<void> fetchData(BuildContext context) async {
    try {
      state = await _repo.fetchData();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}

final controllerProvider = StateNotifierProvider<ApiController, List<ApiModel>>((ref)=>ApiController(ref.read(repositoryProvider)));