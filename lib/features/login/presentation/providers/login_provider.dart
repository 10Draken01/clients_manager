import 'package:clients_manager/features/login/domain/data_transfer_objects/request_login_d_t_o.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/response_login_d_t_o.dart';
import 'package:clients_manager/features/login/domain/usecase/create_request_login_use_case.dart';
import 'package:clients_manager/features/login/domain/usecase/login_use_case.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final CreateRequestLoginUseCase createRequestLoginUseCase;

  LoginProvider({
    required this.loginUseCase,
    required this.createRequestLoginUseCase,
  });

  String? _email;
  String? get email => _email;
  set email(String? email) {
    _email = email;
    notifyListeners();
  }

  String? _password;
  String? get password => _password;
  set password(String? password) {
    _password = password;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _success = false;
  bool get success => _success;

  String? _message;
  String? get message => _message;

  VoidCallback? onLoginSuccess;

  Future<void> _login() async {
    _isLoading = true;
    notifyListeners();

    try {
      RequestLoginDTO request = createRequestLoginUseCase.call(
        _email,
        _password,
      );
      ResponseLoginDTO response = await loginUseCase.call(request);
      _message = response.message;
      _success = response.success;
      if (response.success) {
        Future.delayed(Duration(seconds: 3), () {
          _message = null;
          notifyListeners();
        });
        onLoginSuccess?.call();
      }
    } catch (e) {
      _message = 'An error occurred: $e';
    }
  }

  void handleLogin(Map<String, String> values) async {
    try {
      // 📦 Obtener los valores
      _email = values['email']!;
      _password = values['password']!;

      print('Email: $_email');
      print('Password: $_password');

      // Aquí harías la llamada a tu API
      await _login(); // Simular llamada
    } catch (e) {
      _message = '❌ Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
