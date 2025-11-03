
import 'package:clients_manager/core/src/domain/entities/user_entity.dart';
import 'package:clients_manager/features/profile/presentation/widgets/atoms/profile_info_field.dart';
import 'package:clients_manager/features/profile/presentation/widgets/atoms/profile_section_title.dart';
import 'package:flutter/material.dart';

/// ðŸ§¬ Molécula - Tarjeta de información del usuario
/// Muestra todos los datos del perfil organizados por secciones
class UserInfoCard extends StatelessWidget {
  final UserEntity? user;
  final bool isLoading;

  const UserInfoCard({
    super.key,
    required this.user,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sección: Información Personal
          ProfileSectionTitle(
            title: 'Información Personal',
            icon: Icons.person,
          ),
          const SizedBox(height: 8),

          // ID
          ProfileInfoField(
            label: 'ID de Usuario',
            value: user?.id ?? 'No hay datos',
            icon: Icons.badge,
            isLoading: isLoading,
          ),

          // Username
          ProfileInfoField(
            label: 'Nombre de Usuario',
            value: user?.username ?? 'No hay datos',
            icon: Icons.account_circle,
            isLoading: isLoading,
          ),

          const SizedBox(height: 16),

          // Sección: Información de Contacto
          ProfileSectionTitle(
            title: 'Información de Contacto',
            icon: Icons.mail,
          ),
          const SizedBox(height: 8),

          // Email
          ProfileInfoField(
            label: 'Correo Electrónico',
            value: user?.email ?? 'No hay datos',
            icon: Icons.email,
            isLoading: isLoading,
          ),

          const SizedBox(height: 16),

          // Sección: Seguridad
          ProfileSectionTitle(
            title: 'Seguridad',
            icon: Icons.security,
          ),
          const SizedBox(height: 8),

          // Password (solo mostrar asteriscos si existe)
          ProfileInfoField(
            label: 'Contraseña',
            value: user?.password != null && user!.password!.isNotEmpty
                ? '*' * user!.password!.length
                : 'No hay datos',
            icon: Icons.lock,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}