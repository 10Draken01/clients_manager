import 'dart:convert';

import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';
import 'package:clients_manager/features/login/data/models/login_response_model.dart';
import 'package:clients_manager/features/login/domain/entities/login_request.dart';

class LoginService {
  final HttpService httpService;

  LoginService({required this.httpService});

  Future<LoginResponseModel> login(LoginRequest request) async {
    try {
      final response = await httpService.post(
        ApiData.login,
        body: {'email': request.email, 'password': request.password},
        tokenName: ApiData.tokenApiClients
      );

      final jsonData = jsonDecode(response.body);

      return LoginResponseModel.fromJson(jsonData);
    } catch (e) {
      return LoginResponseModel(success: false, message: e.toString());
    }
  }
}
