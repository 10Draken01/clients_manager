import 'package:clients_manager/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final injectionContainer = InjectionContainer();
  await injectionContainer.init();

  runApp(MyApp(injectionContainer: injectionContainer));
}
