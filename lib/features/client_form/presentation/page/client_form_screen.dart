import 'dart:io';
import 'package:clients_manager/core/domain/entities/client_entity.dart';
import 'package:clients_manager/features/client_form/presentation/provider/client_form_provider.dart';
import 'package:clients_manager/features/client_form/presentation/widgets/organims/character_icon_selector.dart';
import 'package:clients_manager/features/client_form/presentation/widgets/organims/client_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ClientFormScreen extends StatefulWidget {
  final ClientEntity? clientToEdit;

  const ClientFormScreen({super.key, this.clientToEdit});

  @override
  State<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimation();
  }

  void _initializeControllers() {
    final provider = context.read<ClientFormProvider>();

    provider.isEditing = widget.clientToEdit != null;

    if (provider.isEditing) {
      final client = widget.clientToEdit!;
      provider.claveController = TextEditingController(
        text: client.clientKey,
      );
      provider.nombreController = TextEditingController(text: client.name);
      provider.celularController = TextEditingController(text: client.phone);
      provider.emailController = TextEditingController(text: client.email);

      // Usar el método dedicado para actualizar ícono
      provider.updateIconSelection(
        iconIndex: client.characterIcon.iconId ?? 0,
        imageFile: null,
      );
    } else {
      provider.claveController = TextEditingController();
      provider.nombreController = TextEditingController();
      provider.celularController = TextEditingController();
      provider.emailController = TextEditingController();

      provider.updateIconSelection(iconIndex: 0, imageFile: null);
    }
  }

  void _initializeAnimation() {
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeOut,
    );
    _fabController.forward();
  }

  void _onIconSelectionChanged(int? iconIndex, File? imageFile) {
    final provider = context.read<ClientFormProvider>();
    provider.updateIconSelection(iconIndex: iconIndex, imageFile: imageFile);
  }

  Future<void> _saveClient() async {
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackBar('Por favor completa todos los campos correctamente');
      return;
    }

    HapticFeedback.mediumImpact();

    final provider = context.read<ClientFormProvider>();
    if (provider.isEditing) {
      // TODO: Implementar updateClient
      // success = await provider.updateClient(widget.clientToEdit!.id);
    } else {
      print('Crear cliente');
      await provider.createClient();
    }

    if (!mounted) return;

    if (provider.success) {
      _showSuccessSnackBar(
        provider.message ?? (provider.isEditing ? 'Cliente actualizado' : 'Cliente creado'),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) Navigator.pop(context, true);
    } else {
      _showErrorSnackBar(provider.message ?? 'Error al guardar el cliente');
    }
  }

  void _showSuccessSnackBar(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  void dispose() {
    final provider = context.read<ClientFormProvider>();
    provider.claveController.dispose();
    provider.nombreController.dispose();
    provider.celularController.dispose();
    provider.emailController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ClientFormProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.isEditing ? 'Editar Cliente' : 'Nuevo Cliente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            // Campos del formulario
            ClientFormFields(
              claveController: provider.claveController,
              nombreController: provider.nombreController,
              celularController: provider.celularController,
              emailController: provider.emailController,
              isEditing: provider.isEditing,
            ),

            const SizedBox(height: 32),

            // Selector de ícono
            CharacterIconSelector(
              initialIconIndex: provider.selectedIconIndex ?? 0,
              initialImageFile: provider.selectedImageFile,
              onSelectionChanged: _onIconSelectionChanged,
            ),

            const SizedBox(height: 100), // Espacio para el FAB
          ],
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton.extended(
          onPressed: _saveClient,
          icon: Icon(provider.isEditing ? Icons.save : Icons.add),
          label: Text(provider.isEditing ? 'Guardar' : 'Crear Cliente'),
          elevation: 4,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
