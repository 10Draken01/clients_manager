import 'dart:io';
import 'package:clients_manager/core/domain/entities/client_entity.dart';
import 'package:clients_manager/core/domain/values_objects/character_icons_images.dart';
import 'package:clients_manager/features/client_form/presentation/widgets/organims/character_icon_selector.dart';
import 'package:clients_manager/features/client_form/presentation/widgets/organims/client_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientFormScreen extends StatefulWidget {
  final ClientEntity? clientToEdit;

  const ClientFormScreen({
    super.key,
    this.clientToEdit,
  });

  @override
  State<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _claveController;
  late TextEditingController _nombreController;
  late TextEditingController _celularController;
  late TextEditingController _emailController;

  int? _selectedIconIndex;
  File? _selectedImageFile;

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  bool get _isEditing => widget.clientToEdit != null;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimation();
  }

  void _initializeControllers() {
    if (_isEditing) {
      final client = widget.clientToEdit!;
      _claveController = TextEditingController(text: client.claveCliente);
      _nombreController = TextEditingController(text: client.nombre);
      _celularController = TextEditingController(text: client.celular);
      _emailController = TextEditingController(text: client.email);
      
      // Inicializar ícono
      if (client.characterIcon.iconId != null) {
        _selectedIconIndex = client.characterIcon.iconId;
      } else {
        _selectedIconIndex = 0; // Por defecto si viene de URL
      }
    } else {
      _claveController = TextEditingController();
      _nombreController = TextEditingController();
      _celularController = TextEditingController();
      _emailController = TextEditingController();
      _selectedIconIndex = 0; // Primer ícono por defecto
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
    setState(() {
      _selectedIconIndex = iconIndex;
      _selectedImageFile = imageFile;
    });
  }

  Future<void> _saveClient() async {
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackBar('Por favor completa todos los campos correctamente');
      return;
    }

    HapticFeedback.mediumImpact();

    // Aquí obtienes los datos del formulario
    final clientData = {
      'claveCliente': _claveController.text.trim(),
      'nombre': _nombreController.text.trim(),
      'celular': _celularController.text.trim(),
      'email': _emailController.text.trim(),
      'iconId': _selectedIconIndex,
      'imageFile': _selectedImageFile,
    };

    // TODO: Llama al método del provider para crear o editar
    if (_isEditing) {
      // provider.updateClient(widget.clientToEdit!.id, clientData);
      print('EDITAR CLIENTE: $clientData');
    } else {
      // provider.createClient(clientData);
      print('CREAR CLIENTE: $clientData');
    }

    // Muestra mensaje de éxito y regresa
    _showSuccessSnackBar(
      _isEditing 
        ? 'Cliente actualizado exitosamente' 
        : 'Cliente creado exitosamente'
    );
    
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) Navigator.pop(context, true);
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
    _claveController.dispose();
    _nombreController.dispose();
    _celularController.dispose();
    _emailController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Cliente' : 'Nuevo Cliente'),
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
              claveController: _claveController,
              nombreController: _nombreController,
              celularController: _celularController,
              emailController: _emailController,
              isEditing: _isEditing,
            ),

            const SizedBox(height: 32),

            // Selector de ícono
            CharacterIconSelector(
              initialIconIndex: _selectedIconIndex ?? 0,
              initialImageFile: _selectedImageFile,
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
          icon: Icon(_isEditing ? Icons.save : Icons.add),
          label: Text(_isEditing ? 'Guardar' : 'Crear Cliente'),
          elevation: 4,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}