import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/client_avatar.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/animated_client_name.dart';
import 'package:flutter/material.dart';

class ClientsGrid extends StatelessWidget {
  final List<ClientEntity> clients;
  final List<String> icons;
  final Function(ClientEntity)? onClientTap;
  final VoidCallback? onRefresh;

  const ClientsGrid({
    super.key,
    required this.clients,
    required this.icons,
    this.onClientTap,
    this.onRefresh,
  });

  String _getImagePath(ClientEntity client) {
    final characterIcon = client.characterIcon;
    if (characterIcon.iconId != null) {
      final index = characterIcon.iconId! % icons.length;
      return icons[index];
    }
    return '';
  }

  String? _getImageUrl(ClientEntity client) {
    final characterIcon = client.characterIcon;
    if (characterIcon.iconId == null && characterIcon.url != null) {
      return characterIcon.url;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final gridView = GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return _GridClientCard(
          client: client,
          imageUrl: _getImageUrl(client),
          assetPath: _getImagePath(client),
          index: index,
          onTap: onClientTap != null ? () => onClientTap!(client) : null,
        );
      },
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          onRefresh!();
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: gridView,
      );
    }

    return gridView;
  }
}

class _GridClientCard extends StatefulWidget {
  final ClientEntity client;
  final String? imageUrl;
  final String? assetPath;
  final int index;
  final VoidCallback? onTap;

  const _GridClientCard({
    required this.client,
    this.imageUrl,
    this.assetPath,
    required this.index,
    this.onTap,
  });

  @override
  State<_GridClientCard> createState() => _GridClientCardState();
}

class _GridClientCardState extends State<_GridClientCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: Transform.scale(
            scale: 0.8 + (0.2 * animValue),
            child: child,
          ),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: isDark ? 4 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: widget.onTap,
            onTapDown: (_) => _controller.forward(),
            onTapUp: (_) => _controller.reverse(),
            onTapCancel: () => _controller.reverse(),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClientAvatar(
                    imageUrl: widget.imageUrl,
                    assetPath: widget.assetPath,
                    size: 72,
                    isAnimated: true,
                  ),
                  const SizedBox(height: 12),
                  AnimatedClientName(
                    name: widget.client.name,
                    animationDelay: widget.index * 30,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widget.client.phone,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}