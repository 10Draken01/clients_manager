import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ClientAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final File? localImage; // Nuevo parámetro
  final double size;
  final bool showBorder;
  final bool isAnimated;

  const ClientAvatar({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.localImage, // Nuevo parámetro
    this.size = 56.0,
    this.showBorder = true,
    this.isAnimated = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderWidth = size * 0.05;
    final paddingSize = size * 0.1;

    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: borderWidth,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: _buildImage(theme),
        ),
      ),
    );

    if (!isAnimated) return avatar;

    return Hero(
      tag: 'avatar_${imageUrl ?? assetPath ?? localImage?.path}',
      child: avatar,
    );
  }

  Widget _buildImage(ThemeData theme) {
    if (localImage != null) {
      return Image.file(
        localImage!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.person,
          size: size * 0.5,
          color: theme.colorScheme.primary.withOpacity(0.5),
        ),
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: size * 0.4,
            height: size * 0.4,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.person,
          size: size * 0.5,
          color: theme.colorScheme.primary.withOpacity(0.5),
        ),
      );
    }

    if (assetPath != null && assetPath!.isNotEmpty) {
      return Image.asset(
        assetPath!,
        fit: BoxFit.cover,
        color: theme.colorScheme.primary,
        colorBlendMode: BlendMode.srcIn,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.person,
          size: size * 0.5,
          color: theme.colorScheme.primary.withOpacity(0.5),
        ),
      );
    }

    return Icon(
      Icons.person,
      size: size * 0.5,
      color: theme.colorScheme.primary.withOpacity(0.5),
    );
  }
}