import 'package:clients_manager/core/di/injection_container.dart';
import 'package:clients_manager/core/services/inactivity/presentation/provider/inactivity_provider.dart';
import 'package:clients_manager/core/services/network/http_service.dart';
import 'package:clients_manager/core/services/routes/app_router.dart';
import 'package:clients_manager/features/clients_display/presentation/providers/client_form_provider.dart';
import 'package:clients_manager/features/clients_display/presentation/providers/clients_display_provider.dart';
import 'package:clients_manager/features/login/presentation/providers/login_provider.dart';
import 'package:clients_manager/features/profile/presentation/provider/profile_provider.dart';
import 'package:clients_manager/features/register/presentation/providers/register_provider.dart';
import 'package:clients_manager/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  final InjectionContainer injectionContainer;

  const MyApp({super.key, required this.injectionContainer});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // ✅ Llamar onAppReady cuando la app está lista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.injectionContainer.firebaseMessagingService.initialize(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (MultiProvider(
      providers: [
        Provider<HttpService>(
          create: (_) => widget.injectionContainer.httpService,
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            loginUseCase: widget.injectionContainer.loginUsecase,
            createRequestLoginUseCase:
                widget.injectionContainer.createRequestLoginUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(
            registerUseCase: widget.injectionContainer.registerUseCase,
            createRequestRegisterUseCase:
                widget.injectionContainer.createRequestRegisterUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ClientsDisplayProvider(
            getPageClientsUseCase:
                widget.injectionContainer.getPageClientsUseCase,
            createRequestGetPageClientsUseCase:
                widget.injectionContainer.createRequestGetPageClientsUseCase,
            deleteClientUseCase: widget.injectionContainer.deleteClientUseCase,
            createRequestDeleteClientUseCase:
                widget.injectionContainer.createRequestDeleteClientUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ClientFormProvider(
            createClientUseCase: widget.injectionContainer.createClientUseCase,
            createRequestCreateClientUseCase:
                widget.injectionContainer.createRequestCreateClientUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => InactivityProvider(
            inactivityRepository:
                widget.injectionContainer.inactivityRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(
            getLocalDataUserUnencryptedUseCase: widget.injectionContainer.getLocalDataUserUnencryptedUseCase
          ),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme, // Tema oscuro opcional
        themeMode: ThemeMode.system, // Sistema
        routerConfig: appRouter,
      ),
    ));
  }
}
