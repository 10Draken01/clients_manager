import 'dart:io';

import 'package:clients_manager/features/clients_display/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/create_client/create_client_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/create_client/create_request_create_client_use_case.dart';
import 'package:flutter/material.dart';

class ClientFormProvider with ChangeNotifier {
  final CreateClientUseCase createClientUseCase;
  final CreateRequestCreateClientUseCase createRequestCreateClientUseCase;

  // Controllers - inicializados una sola vez
  late TextEditingController _claveController;
  TextEditingController get claveController => _claveController;
  
  late TextEditingController _nombreController;
  TextEditingController get nombreController => _nombreController;

  late TextEditingController _celularController;
  TextEditingController get celularController => _celularController;

  late TextEditingController _emailController;
  TextEditingController get emailController => _emailController;

  ClientFormProvider({
    required this.createClientUseCase,
    required this.createRequestCreateClientUseCase,
  }) {
    // ✅ Inicializar controladores una sola vez
    _claveController = TextEditingController();
    _nombreController = TextEditingController();
    _celularController = TextEditingController();
    _emailController = TextEditingController();
  }

  // Icon selection - SÍ necesita notifyListeners pero con método dedicado
  int? _selectedIconIndex = 0;
  int? get selectedIconIndex => _selectedIconIndex;

  File? _selectedImageFile;
  File? get selectedImageFile => _selectedImageFile;

  // Método para actualizar la selección de ícono
  void updateIconSelection({int? iconIndex, File? imageFile}) {
    _selectedIconIndex = iconIndex;
    _selectedImageFile = imageFile;
    notifyListeners();
  }

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool value) {
    _isEditing = value;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _success = false;
  bool get success => _success;

  String? _message;
  String? get message => _message;

  Future<void> createClient() async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    try {
      final characterIcon = CharacterIconEntity.create(
        iconId: _selectedIconIndex,
        file: _selectedImageFile,
      );

      final request = createRequestCreateClientUseCase(
        claveController.text.trim(),
        nombreController.text.trim(),
        celularController.text.trim(),
        emailController.text.trim(),
        characterIcon,
      );
      
      final response = await createClientUseCase(request);
      _success = response.success;
      _message = response.message;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _message = e.toString();
      notifyListeners();
    }
  }

  void clearForm() {
    _claveController.clear();
    _nombreController.clear();
    _celularController.clear();
    _emailController.clear();
    _selectedIconIndex = 0;
    _selectedImageFile = null;
    _isEditing = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _claveController.dispose();
    _nombreController.dispose();
    _celularController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}