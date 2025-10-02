
import 'package:clients_manager/features/login/presentation/pages/login_screen.dart';
import 'package:clients_manager/features/login/presentation/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (
        MultiProvider(
          providers: [
          ChangeNotifierProvider(
            create: (_) => LoginProvider(getPostsUseCase: getPostsUseCase)),
          ],
          child: MaterialApp(
            home: LoginScreen(),
          )
    ));
  }
}