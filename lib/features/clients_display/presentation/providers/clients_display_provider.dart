import 'package:clients_manager/core/domain/entities/client_entity.dart';
import 'package:clients_manager/core/domain/usecase/create_request_get_page_clients_use_case.dart';
import 'package:clients_manager/core/domain/usecase/get_page_clients_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class ClientsDisplayProvider with ChangeNotifier {
  final GetPageClientsUseCase getPageClientsUseCase;
  final CreateRequestGetPageClientsUseCase createRequestGetPageClientsUseCase;

  ClientsDisplayProvider({
    required this.getPageClientsUseCase,
    required this.createRequestGetPageClientsUseCase,
  });

  List<ClientEntity> _clients = [];
  List<ClientEntity> get clients => _clients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _message;
  String? get message => _message;

  VoidCallback? onGetPageClientsSuccess;

  Future<void> getPageClients(int page, int limit) async {
    try {
      final request = createRequestGetPageClientsUseCase.call(page);
      final response = await getPageClientsUseCase(request);

      if (response.success) {
        _clients = response.clients;
        _message = response.message;
        onGetPageClientsSuccess?.call();
      }
    } catch (e) {
      _message = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
