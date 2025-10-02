
import 'package:clients_manager/features/login/domain/entities/login_request.dart';
import 'package:clients_manager/features/login/domain/entities/login_response.dart';
import 'package:clients_manager/features/login/domain/usecase/create_request_usecase.dart';
import 'package:clients_manager/features/login/domain/usecase/login_usecase.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final LoginUsecase loginUseCase;
  final CreateRequestUsecase createRequestUseCase;

  LoginProvider({required this.loginUseCase, required this.createRequestUseCase});

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

  String? _message;
  String? get message => _message;

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      LoginRequest request = createRequestUseCase.call(_email, _password);
      LoginResponse response = await loginUseCase.call(request);
      _message = response.message;
      if (response.success) {
        Future.delayed(Duration(seconds: 3), () {
          _message = null;
          notifyListeners();
        });
      }

    } catch (e) {
      _message = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}