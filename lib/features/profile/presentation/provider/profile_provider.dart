import 'package:clients_manager/core/src/domain/entities/user_entity.dart';
import 'package:clients_manager/core/src/domain/usecase/get_local_data_user_unencrypted_use_case.dart';
import 'package:flutter/material.dart';

/// ðŸ"Œ Estados posibles de la pantalla de perfil
enum ProfileState {
  initial,
  loading,
  loaded,
  empty,
  error,
}

/// ðŸ"¬ ViewModel para la pantalla de Profile
/// Maneja la lógica de presentación y el estado de la pantalla
class ProfileProvider extends ChangeNotifier {
  final GetLocalDataUserUnencryptedUseCase getLocalDataUserUnencryptedUseCase;

  // Estado
  ProfileState _state = ProfileState.initial;
  UserEntity? _user;
  String _errorMessage = '';
  bool _isLoading = false;

  // Getters
  ProfileState get state => _state;
  UserEntity? get user => _user;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  // Callbacks
  Function()? onProfileLoaded;
  Function(String)? onProfileError;

  ProfileProvider({ required this.getLocalDataUserUnencryptedUseCase});

  /// ðŸ"„ Cargar el perfil del usuario
  Future<void> loadUserProfile() async {
    _setLoading(true);
    _state = ProfileState.loading;
    notifyListeners();

    try {
      final data = await getLocalDataUserUnencryptedUseCase.call();

      final user = data.user;

      if (user != null) {
        _user = user;
        _state = ProfileState.loaded;
        _errorMessage = '';
        debugPrint('âœ… Perfil cargado: ${user.username}');
        onProfileLoaded?.call();
      } else {
        _user = null;
        _state = ProfileState.empty;
        _errorMessage = 'Datos eliminados remotamente';
        debugPrint('âœ… Perfil vacío - Usuario no encontrado');
      }
    } catch (e) {
      _state = ProfileState.error;
      _errorMessage = 'Error al cargar el perfil: $e';
      _user = null;
      debugPrint('âŒ Error: $_errorMessage');
      onProfileError?.call(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  /// ðŸ"„ Refrescar el perfil del usuario
  Future<void> refreshProfile() async {
    debugPrint('ðŸ"„ Refrescando perfil...');
    await loadUserProfile();
  }

  /// ðŸ§¹ Limpiar datos
  void clearProfile() {
    _user = null;
    _state = ProfileState.initial;
    _errorMessage = '';
    notifyListeners();
  }

  /// ðŸ"' Establecer estado de carga
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}