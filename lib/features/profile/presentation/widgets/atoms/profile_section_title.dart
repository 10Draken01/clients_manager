import 'package:flutter/material.dart';

/// ðŸ§© Átomo - Título de sección
/// Componente básico para separar secciones del perfil
class ProfileSectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;

  const ProfileSectionTitle({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12, left: 0, right: 0),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Divider(
                color: theme.colorScheme.outlineVariant,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}