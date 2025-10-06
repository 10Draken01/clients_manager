import 'dart:io';
import 'package:flutter/material.dart';

class SelectedImagePreview extends StatelessWidget {
  final File? imageFile;
  final String? assetPath;
  final VoidCallback onRemove;

  const SelectedImagePreview({
    super.key,
    this.imageFile,
    this.assetPath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (imageFile == null && assetPath == null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageFile != null
                  ? Image.file(
                      imageFile!,
                      height: 140,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      assetPath!,
                      height: 140,
                      fit: BoxFit.contain,
                      color: theme.colorScheme.primary,
                      colorBlendMode: BlendMode.srcIn,
                    ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: theme.colorScheme.error,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}