import 'package:clients_manager/features/login/domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  final bool success;
  final String message;

  LoginResponseModel({required this.success, required this.message})
    : super(success: success, message: message);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }

  LoginResponse toEntity() {
    return LoginResponse(success: success, message: message);
  }
}
