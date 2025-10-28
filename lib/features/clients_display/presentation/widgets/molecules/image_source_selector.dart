import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/image_source_button.dart';
import 'package:flutter/material.dart';

class ImageSourceSelector extends StatelessWidget {
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;

  const ImageSourceSelector({
    super.key,
    required this.onCameraPressed,
    required this.onGalleryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ImageSourceButton(
            icon: Icons.camera_alt,
            label: 'Cámara',
            onTap: onCameraPressed,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ImageSourceButton(
            icon: Icons.photo_library,
            label: 'Galería',
            onTap: onGalleryPressed,
          ),
        ),
      ],
    );
  }
}