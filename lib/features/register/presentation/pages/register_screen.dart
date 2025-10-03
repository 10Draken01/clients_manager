import 'package:clients_manager/core/models/form_field_config.dart';
import 'package:clients_manager/core/routes/app_routes.dart';
import 'package:clients_manager/core/widgets/atoms/message_response_form.dart';
import 'package:clients_manager/core/widgets/molecules/custom_form_normal.dart';
import 'package:clients_manager/features/register/presentation/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                  Icons.face_unlock_outlined,
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
                  'Registrese para continuar',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 40),

                // 🎯 FORMULARIO con Consumer para optimizar
                Consumer<RegisterProvider>(
                  builder: (context, provider, child) {
                    return CustomFormNormal(
                      fields: [
                        FormFieldConfig.username(),
                        FormFieldConfig.email(),
                        FormFieldConfig.password(),
                      ],
                      onSubmit: provider.handleRegister,
                      submitButtonText: 'Registrarse',
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
                      '¿Ya tienes cuenta? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Navegar a registro
                        AppRoutes.goBack(context);
                        print('Ir a login');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Iniciar Sesión',
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
