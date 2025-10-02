
import 'package:clients_manager/features/login/domain/usecase/create_request_usecase.dart';
import 'package:clients_manager/features/login/domain/usecase/login_usecase.dart';
import 'package:clients_manager/features/login/presentation/pages/login_screen.dart';
import 'package:clients_manager/features/login/presentation/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final LoginUsecase loginUsecase;
  final CreateRequestUsecase createRequestUsecase;
  const MyApp({super.key, required this.loginUsecase, required this.createRequestUsecase});

  @override
  Widget build(BuildContext context) {
    return (
        MultiProvider(
          providers: [
          ChangeNotifierProvider(
            create: (_) => LoginProvider(loginUseCase: loginUsecase, createRequestUseCase: createRequestUsecase)),
          ],
          child: MaterialApp(
            home: LoginScreen(),
          )
    ));
  }
}