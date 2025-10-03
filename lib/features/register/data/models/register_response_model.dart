import 'package:clients_manager/features/login/domain/entities/login_response.dart';
import 'package:clients_manager/features/register/domain/entities/register_response.dart';

class RegisterResponseModel extends LoginResponse {
  final bool success;
  final String message;

  RegisterResponseModel({required this.success, required this.message})
    : super(success: success, message: message);

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }

  RegisterResponse toEntity() {
    return RegisterResponse(success: success, message: message);
  }
}
