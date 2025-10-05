import 'dart:convert';

import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';
import 'package:clients_manager/core/data/models/response_get_page_clients_model.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/request_get_page_clients_d_t_o.dart';

class GetPageClientsService {
  final HttpService httpService;

  GetPageClientsService({required this.httpService});

  Future<ResponseGetPageClientsModel> getPageClients(
    RequestGetPageClientsDTO request,
  ) async {
    try {
      final response = await httpService.get(
        ApiData.getPageClients.replaceFirst(':page', request.page.toString()),
        headers: {'Authorization': ApiData.tokenApiClients},
      );

      final jsonData = jsonDecode(response.body);

      return ResponseGetPageClientsModel.fromJson(jsonData);
    } catch (e) {
      return ResponseGetPageClientsModel(
        success: false,
        message: e.toString(),
        clients: [],
        totalClients: 0,
      );
    }
  }
}
