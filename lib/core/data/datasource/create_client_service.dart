import 'dart:convert';
import 'dart:io';

import 'package:clients_manager/core/data/models/response_create_client_model.dart';
import 'package:clients_manager/core/domain/data_transfer_objects/create_client/request_create_client_d_t_o.dart';
import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';

class CreateClientService {
  final HttpService httpService;

  CreateClientService({required this.httpService});

  Future<ResponseCreateClientModel> createClient(
    RequestCreateClientDTO request,
  ) async {
    try {
      late final fields;
      late final files;

      if (request.client.characterIcon.iconId != null) {
        fields = {
          'claveCliente': request.client.claveCliente,
          'nombre': request.client.nombre,
          'celular': request.client.celular,
          'email': request.client.email,
          'characterIcon': request.client.characterIcon.iconId.toString(),
        };
      } else {
        fields = {
          'claveCliente': request.client.claveCliente,
          'nombre': request.client.nombre,
          'celular': request.client.celular,
          'email': request.client.email,
        };
        files = {
          'characterIcon': File(request.client.characterIcon.image!.path),
        };
      }
        // estraer el archivo del path

      final response = await httpService.postFormData(
        ApiData.createClient,
        headers: {'Authorization': ApiData.tokenApiClients},
        fields: fields,
        files: files,
      );
      final jsonData = jsonDecode(response.body);
      return ResponseCreateClientModel.fromJson(jsonData);
    } catch (e) {
      print('Error en CreateClientService: $e');
      return ResponseCreateClientModel(success: false, message: e.toString());
    }
  }
}
