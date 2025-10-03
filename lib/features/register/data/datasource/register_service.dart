import 'dart:convert';

import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';
import 'package:clients_manager/features/register/data/models/register_response_model.dart';
import 'package:clients_manager/features/register/domain/entities/register_request.dart';

class RegisterService {
  final HttpService httpService;

  RegisterService({required this.httpService});

  Future<RegisterResponseModel> register(RegisterRequest request) async {
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
