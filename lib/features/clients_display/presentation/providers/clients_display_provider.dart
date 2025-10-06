import 'package:clients_manager/core/domain/entities/client_entity.dart';
import 'package:clients_manager/core/domain/usecase/delete_client/create_request_delete_client_use_case.dart';
import 'package:clients_manager/core/domain/usecase/delete_client/delete_client_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/get_page_clients/create_request_get_page_clients_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/get_page_clients/get_page_clients_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClientsDisplayProvider with ChangeNotifier {
  final GetPageClientsUseCase getPageClientsUseCase;
  final CreateRequestGetPageClientsUseCase createRequestGetPageClientsUseCase;

  final DeleteClientUseCase deleteClientUseCase;
  final CreateRequestDeleteClientUseCase createRequestDeleteClientUseCase;

  ClientsDisplayProvider({
    required this.getPageClientsUseCase,
    required this.createRequestGetPageClientsUseCase,
    required this.deleteClientUseCase,
    required this.createRequestDeleteClientUseCase,
  });

  List<ClientEntity> _clients = [];
  List<ClientEntity> get clients => _clients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _message;
  String? get message => _message;

  VoidCallback? onGetPageClientsSuccess;

  Future<void> getPageClients({int page = 1}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final request = createRequestGetPageClientsUseCase.call(page);
      final response = await getPageClientsUseCase(request);

      _message = response.message;
      if (response.success) {
        _clients = response.clients!;
        onGetPageClientsSuccess?.call();
      }
    } catch (e) {
      _message = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteClient(String? claveCliente) async {
    try {
      _isLoading = true;
      notifyListeners();

      final request = createRequestDeleteClientUseCase.call(claveCliente);
      final response = await deleteClientUseCase(request);

      _message = response.message;

      if (response.success) {
        _clients.removeWhere((c) => c.claveCliente == claveCliente);
      }
    } catch (e) {
      _message = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
