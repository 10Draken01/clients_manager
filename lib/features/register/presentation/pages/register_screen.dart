

import 'package:clients_manager/core/models/form_field_config.dart';
import 'package:clients_manager/core/routes/values_objects/app_routes.dart';
import 'package:clients_manager/core/widgets/atoms/message_response_form.dart';
import 'package:clients_manager/core/widgets/molecules/custom_form_normal.dart';
import 'package:clients_manager/features/register/presentation/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ Configurar callbacks cuando se crea el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<RegisterProvider>();

      // ✅ Cuando el registro es exitoso
      provider.onRegisterSuccess = () {
        if (mounted) {
          context.pop();
        }
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_rounded,
                  size: 100,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 20),

                Text(
                  'Crear cuenta',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  'Regístrate para continuar',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 40),

                Consumer<RegisterProvider>(
                  builder: (context, provider, child) {
                    return CustomFormNormal(
                      fields: [
                        FormFieldConfig.username(),
                        FormFieldConfig.email(),
                        FormFieldConfig.password(minLength: 8),
                      ],
                      // ✅ Solo llama al método, NO navegas aquí
                      onSubmit: provider.handleRegister,
                      submitButtonText: 'Registrarse',
                      isLoading: provider.isLoading,
                      messageWidget: provider.message != null
                          ? MessageResponseForm(
                              message: provider.message!,
                              isSuccess: provider.success,
                            )
                          : null,
                    );
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes cuenta? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.login.path);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Inicia sesión',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}