import 'package:clients_manager/core/models/form_field_config.dart';
import 'package:clients_manager/core/routes/app_router.dart';
import 'package:clients_manager/core/widgets/atoms/message_response_form.dart';
import 'package:clients_manager/core/widgets/molecules/custom_form_normal.dart';
import 'package:clients_manager/features/login/presentation/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Configurar callbacks cuando se crea el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<LoginProvider>();

      // ✅ Cuando el login es exitoso
      provider.onLoginSuccess = () {
        if (mounted) {
          AppRoutes.navigateTo(context, AppRoutes.clientsDisplay);
        }
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 Obtener el tema y colores
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
                // 🎭 Logo o ícono con color del tema
                Icon(
                  Icons.lock_person_rounded,
                  size: 100,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 20),

                // 📝 Título con estilo del tema
                Text(
                  'Bienvenido',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 8),

                // 📝 Subtítulo
                Text(
                  'Inicia sesión para continuar',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 40),

                // 🎯 FORMULARIO con Consumer para optimizar
                Consumer<LoginProvider>(
                  builder: (context, provider, child) {
                    return CustomFormNormal(
                      fields: [
                        // agregar datos del provider al formulario
                        FormFieldConfig.email(),
                        FormFieldConfig.password(
                          minLength: 8
                        ),
                      ],
                      onSubmit: provider.handleLogin,
                      submitButtonText: 'Iniciar Sesión',
                      isLoading: provider.isLoading,

                      // 📢 Widget de mensaje adaptativo al tema
                      messageWidget: provider.message != null
                          ? MessageResponseForm(
                              message: provider.message!,
                              isSuccess: provider.success,
                              isDark: isDark,
                            )
                          : null,
                    );
                  },
                ),

                const SizedBox(height: 20),

                // 🔗 Link de registro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tienes cuenta? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Navegar a registro
                        AppRoutes.navigateTo(context, AppRoutes.register);
                        print('Ir a registro');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Regístrate',
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
