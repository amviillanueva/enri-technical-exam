import 'dart:convert';

import 'package:flutter_tech_exam/common/api_endpoints.dart';
import 'package:flutter_tech_exam/web/contracts/user_contract.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class UserService {
  Future<List<UserContract>> getUsers();
}

@LazySingleton(as: UserService)
class UserServiceImpl implements UserService {
  final http.Client httpClient = http.Client();

  Future<Map<String, String>> _getHeaders() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
  }

  @override
  Future<List<UserContract>> getUsers() async {
    return Future<List<UserContract>>.delayed(const Duration(seconds: 3),
        () async {
      final http.Response response = await httpClient.get(
        Uri.parse('${ApiEndpoints.baseUrl}/${ApiEndpoints.getUser}'),
        headers: await _getHeaders(),
      );
      final dynamic json = jsonDecode(response.body);

      return List<UserContract>.from(
        (json as List).map<UserContract>(
              (dynamic shipment) =>
              UserContract.fromJson(shipment as Map<String, dynamic>),
        ),
      );
    });
  }
}
