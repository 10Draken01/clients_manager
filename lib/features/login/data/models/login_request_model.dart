import 'package:clients_manager/features/login/domain/entities/login_request.dart';

class LoginRequestModel extends LoginRequest {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password})
    : super(email: email, password: password);

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(email: json['email'], password: json['password']);
  }
}
