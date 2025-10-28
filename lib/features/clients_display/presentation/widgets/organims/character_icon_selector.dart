import 'dart:io';
import 'package:clients_manager/features/clients_display/domain/values_objects/character_icons_images.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/form_section_title.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/molecules/icon_selector_grid.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/molecules/image_source_selector.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/molecules/selected_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CharacterIconSelector extends StatefulWidget {
  final int initialIconIndex;
  final File? initialImageFile;
  final Function(int?, File?) onSelectionChanged;

  const CharacterIconSelector({
    super.key,
    this.initialIconIndex = 0,
    this.initialImageFile,
    required this.onSelectionChanged,
  });

  @override
  State<CharacterIconSelector> createState() => _CharacterIconSelectorState();
}

class _CharacterIconSelectorState extends State<CharacterIconSelector> {
  late int _selectedIconIndex;
  File? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedIconIndex = widget.initialIconIndex;
    _selectedImageFile = widget.initialImageFile;
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          _selectedImageFile = File(photo.path);
          _selectedIconIndex = -1; // Indica que se usó imagen personalizada
        });
        widget.onSelectionChanged(null, _selectedImageFile);
      }
    } catch (e) {
      _showErrorSnackBar('Error al tomar la foto: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImageFile = File(image.path);
          _selectedIconIndex = -1;
        });
        widget.onSelectionChanged(null, _selectedImageFile);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
      _showErrorSnackBar('Error al seleccionar imagen: $e');
    }
  }

  void _onIconSelected(int index) {
    setState(() {
      _selectedIconIndex = index;
      _selectedImageFile = null;
    });
    widget.onSelectionChanged(index, null); // Pasa el índice, no null
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImageFile = null;
      _selectedIconIndex = 0;
    });
    widget.onSelectionChanged(0, null);
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionTitle(
          title: 'Ícono del Personaje',
          icon: Icons.palette_outlined,
        ),

        // Vista previa de imagen seleccionada
        if (_selectedImageFile != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SelectedImagePreview(
              imageFile: _selectedImageFile,
              onRemove: _removeSelectedImage,
            ),
          ),

        // Grid de íconos predefinidos
        if (_selectedImageFile == null) ...[
          IconSelectorGrid(
            icons: CharacterIconsImages.listIcons,
            selectedIndex: _selectedIconIndex,
            onIconSelected: _onIconSelected,
          ),
          const SizedBox(height: 16),
        ],

        // Selector de fuente de imagen
        const Text(
          'O selecciona una imagen personalizada:',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        ImageSourceSelector(
          onCameraPressed: _pickImageFromCamera,
          onGalleryPressed: _pickImageFromGallery,
        ),
      ],
    );
  }
}
