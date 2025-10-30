import 'dart:convert';

import 'package:clients_manager/core/services/network/http_service.dart';
import 'package:clients_manager/core/services/network/values_objects/api_data.dart';
import 'package:clients_manager/features/register/data/models/register_response_model.dart';
import 'package:clients_manager/features/register/domain/data_transfer_objects/request_register_d_t_o.dart';

class RegisterService {
  final HttpService httpService;

  RegisterService({required this.httpService});

  Future<RegisterResponseModel> register(RequestRegisterDTO request) async {
    try {
      final response = await httpService.post(
        ApiData.register,
        body: {
          'username': request.username,
          'email': request.email, 
          'password': request.password
        }
      );

      final jsonData = jsonDecode(response.body);

      return RegisterResponseModel.fromJson(jsonData);
    } catch (e) {
      return RegisterResponseModel(success: false, message: e.toString());
    }
  }
}
