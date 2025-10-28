import 'dart:convert';
import 'package:clients_manager/features/clients_display/data/models/response_delete_client_model.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/request_delete_client_d_t_o.dart';
import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';

class DeleteClientService {
  final HttpService httpService;

  DeleteClientService({required this.httpService});

  Future<ResponseDeleteClientModel> deleteClient(
    RequestDeleteClientDTO request,
  ) async {
    try {
      final response = await httpService.delete(
        ApiData.deleteClient.replaceFirst(':clientKey', request.clientKey),
        headers: {'Authorization': ApiData.tokenApiClients},
      );
      final jsonData = jsonDecode(response.body);
      return ResponseDeleteClientModel.fromJson(jsonData);
    } catch (e) {
      print('Error en DeleteClientService: $e');
      return ResponseDeleteClientModel(
        success: false,
        message: e.toString()
      );
    }
  }
}
