import 'package:clients_manager/core/src/domain/entities/user_entity.dart';
import 'package:clients_manager/features/profile/presentation/provider/profile_provider.dart';
import 'package:clients_manager/features/profile/presentation/widgets/molecules/profile_header.dart';
import 'package:clients_manager/features/profile/presentation/widgets/molecules/user_info_card.dart';
import 'package:flutter/material.dart';

/// ðŸ§¬ Organismo - Contenido del perfil
/// Componente complejo que combina átomos y moléculas
class ProfileContent extends StatelessWidget {
  final UserEntity? user;
  final bool isLoading;
  final ProfileState state;
  final VoidCallback onRefresh;

  const ProfileContent({
    super.key,
    required this.user,
    required this.isLoading,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
        // Esperar a que se complete la carga
        await Future.delayed(const Duration(seconds: 1));
      },
      color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.surface,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Header
            ProfileHeader(
              username: user?.username ?? 'Usuario',
              isLoading: isLoading,
            ),

            const SizedBox(height: 24),

            // Contenido según estado
            if (state == ProfileState.empty)
              _buildEmptyState(context)
            else if (state == ProfileState.error)
              _buildErrorState(context)
            else
              _buildContent(context),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// ðŸ"ª Estado: Sin datos
  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Datos Eliminados',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tus datos han sido eliminados remotamente o tu sesión ha expirado.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Recargar'),
          ),
        ],
      ),
    );
  }

  /// ðŸš¨ Estado: Error
  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error al Cargar',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hubo un problema al cargar tu perfil. Intenta de nuevo.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Recargar'),
          ),
        ],
      ),
    );
  }

  /// ðŸ"„ Estado: Contenido cargado
  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        // Tarjeta de información
        UserInfoCard(
          user: user,
          isLoading: isLoading,
        ),

        const SizedBox(height: 24),

        // Botón de recargar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : onRefresh,
              icon: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.refresh),
              label: const Text('Recargar Información'),
            ),
          ),
        ),
      ],
    );
  }
}