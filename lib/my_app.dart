import 'package:clients_manager/core/di/injection_container.dart';
import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/routes/app_routes.dart';
import 'package:clients_manager/core/theme/app_theme.dart';
import 'package:clients_manager/features/client_form/presentation/page/client_form_screen.dart';
import 'package:clients_manager/features/client_form/presentation/provider/client_form_provider.dart';
import 'package:clients_manager/features/clients_display/presentation/providers/clients_display_provider.dart';
import 'package:clients_manager/features/login/presentation/providers/login_provider.dart';
import 'package:clients_manager/features/register/presentation/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final InjectionContainer injectionContainer;
  const MyApp({super.key, required this.injectionContainer});

  @override
  Widget build(BuildContext context) {
    return (
        MultiProvider(
          providers: [
            Provider<HttpService>(
              create: (_) => injectionContainer.httpService
            ),
            ChangeNotifierProvider(
              create: (_) => LoginProvider(
                  loginUseCase: injectionContainer.loginUsecase, 
                  createRequestLoginUseCase: injectionContainer.createRequestLoginUseCase
                )
            ),
            ChangeNotifierProvider(
              create: (_) => RegisterProvider(
                registerUseCase: injectionContainer.registerUseCase, 
                createRequestRegisterUseCase: injectionContainer.createRequestRegisterUseCase),
            ),
            ChangeNotifierProvider(
              create: (_) => ClientsDisplayProvider(
                getPageClientsUseCase: injectionContainer.getPageClientsUseCase,
                createRequestGetPageClientsUseCase: injectionContainer.createRequestGetPageClientsUseCase,
                deleteClientUseCase: injectionContainer.deleteClientUseCase,
                createRequestDeleteClientUseCase: injectionContainer.createRequestDeleteClientUseCase
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => ClientFormProvider(
                createClientUseCase: injectionContainer.createClientUseCase,
                createRequestCreateClientUseCase: injectionContainer.createRequestCreateClientUseCase
              ),
            )
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme, // Tema oscuro opcional
            themeMode: ThemeMode.system, // S
            initialRoute: AppRoutes.login,
            routes: AppRoutes.routes,
          )
    ));
  }
}