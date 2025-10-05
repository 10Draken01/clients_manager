import 'dart:convert';

import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';
import 'package:clients_manager/features/login/data/models/response_login_model.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/request_login_d_t_o.dart';

class LoginService {
  final HttpService httpService;

  LoginService({required this.httpService});

  Future<ResponseLoginModel> login(RequestLoginDTO request) async {
    try {
      final response = await httpService.post(
        ApiData.login,
        body: {'email': request.email, 'password': request.password},
        tokenName: ApiData.tokenApiClients
      );

      final jsonData = jsonDecode(response.body);

      return ResponseLoginModel.fromJson(jsonData);
    } catch (e) {
      return ResponseLoginModel(success: false, message: e.toString());
    }
  }
}
