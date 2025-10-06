
import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/create_client/create_client_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/create_client/create_request_create_client_use_case.dart';
import 'package:flutter/material.dart';

class ClientFormProvider with ChangeNotifier {
  final CreateClientUseCase createClientUseCase;
  final CreateRequestCreateClientUseCase createRequestCreateClientUseCase;

  ClientFormProvider({
    required this.createClientUseCase,
    required this.createRequestCreateClientUseCase,
  });

 
  String? _claveCliente;
  String? get claveCliente => _claveCliente;

  String? _nombre;
  String? get nombre => _nombre;  
  
  String? _celular;
  String? get celular => _celular;

  String? _email;
  String? get email => _email;

  CharacterIconEntity? characterIcon;
  CharacterIconEntity? get getCharacterIcon => characterIcon;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> createClient(String nombre, String apellidoPaterno, String apellidoMaterno, String telefono, String email) async {
    _isLoading = true;
    notifyListeners();

    final request = createRequestCreateClientUseCase(
      _claveCliente!,
      _nombre!,
      _celular!,
      _email!,
      characterIcon!,
    );
    final response = await createClientUseCase(request);

    _isLoading = false;
    notifyListeners();

    return response.success;
  }
}