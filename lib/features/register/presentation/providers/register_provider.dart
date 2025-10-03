import 'package:clients_manager/features/login/domain/entities/login_request.dart';
import 'package:clients_manager/features/login/domain/entities/login_response.dart';
import 'package:clients_manager/features/login/domain/usecase/create_login_request_use_case.dart';
import 'package:clients_manager/features/login/domain/usecase/login_use_case.dart';
import 'package:clients_manager/features/register/domain/entities/register_request.dart';
import 'package:clients_manager/features/register/domain/entities/register_response.dart';
import 'package:clients_manager/features/register/domain/usecase/create_register_request_use_case.dart';
import 'package:clients_manager/features/register/domain/usecase/register_use_case.dart';
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  final RegisterUseCase registerUseCase;
  final CreateRegisterRequestUseCase createRegisterRequestUseCase;

  RegisterProvider({
    required this.registerUseCase,
    required this.createRegisterRequestUseCase,
  });

  String? _username;
  String? get username => _username;
  set username(String? username) {
    _username = username;
    notifyListeners();
  }

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

  Future<void> _register() async {
    _isLoading = true;
    notifyListeners();

    try {
      RegisterRequest request = createRegisterRequestUseCase.call(_username, _email, _password);
      RegisterResponse response = await registerUseCase.call(request);
      _message = response.message;
      _success = response.success;
      if (response.success) {
        Future.delayed(Duration(seconds: 3), () {
          _message = null;
          notifyListeners();
        });
      }
    } catch (e) {
      _message = 'An error occurred: $e';
    }
  }

  void handleRegister(Map<String, String> values) async {
    try {
      // 📦 Obtener los valores
      _username = values['username'];
      _email = values['email']!;
      _password = values['password']!;

      print('Username: $_username');
      print('Email: $_email');
      print('Password: $_password');

      // Aquí harías la llamada a tu API
      await _register(); // Simular llamada
    } catch (e) {
      _message = '❌ Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
