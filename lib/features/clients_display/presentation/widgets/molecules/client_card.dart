import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/client_avatar.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/animated_client_name.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/info_chip.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatefulWidget {
  final ClientEntity client;
  final List<String> availableIcons;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final int index;

  const ClientCard({
    super.key,
    required this.client,
    required this.availableIcons,
    this.onTap,
    this.onDelete,
    required this.index,
  });

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  String _getImagePath() {
    final characterIcon = widget.client.characterIcon;

    // Si iconId no es nulo, es un índice local
    if (characterIcon.iconId != null) {
      final index = characterIcon.iconId! % widget.availableIcons.length;
      return widget.availableIcons[index];
    }

    return '';
  }

  String? _getImageUrl() {
    final characterIcon = widget.client.characterIcon;

    // Si iconId es nulo, entonces usa la URL
    if (characterIcon.iconId == null && characterIcon.url != null) {
      return characterIcon.url;
    }

    return null;
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _scaleController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (widget.index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, child) {
        return Opacity(
          opacity: animValue,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - animValue)),
            child: child,
          ),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: _isPressed ? 1 : (isDark ? 4 : 2),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          theme.colorScheme.surface,
                          theme.colorScheme.surface.withOpacity(0.95),
                        ]
                      : [
                          Colors.white,
                          Colors.white.withOpacity(0.95),
                        ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Avatar con animación Hero
                    ClientAvatar(
                      imageUrl: _getImageUrl(),
                      assetPath: _getImagePath(),
                      size: 64,
                      showBorder: true,
                      isAnimated: true,
                    ),
                    const SizedBox(width: 16),

                    // Información del cliente
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nombre con animación
                          AnimatedClientName(
                            name: widget.client.name,
                            animationDelay: widget.index * 50,
                          ),
                          const SizedBox(height: 8),

                          // Chips de información
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              InfoChip(
                                icon: Icons.phone,
                                text: widget.client.phone,
                                color: theme.colorScheme.primary,
                              ),
                              InfoChip(
                                icon: Icons.email,
                                text: widget.client.email,
                                color: theme.colorScheme.secondary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Clave del cliente
                          Text(
                            'Clave: ${widget.client.clientKey}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Botones de acción
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Botón de eliminar
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.onDelete,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.delete_outline,
                                size: 24,
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Icono de flecha
                        AnimatedRotation(
                          turns: _isPressed ? 0.125 : 0,
                          duration: const Duration(milliseconds: 150),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: theme.colorScheme.primary.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}