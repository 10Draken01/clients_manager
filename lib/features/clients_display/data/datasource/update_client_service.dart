import 'dart:convert';
import 'dart:io';
import 'package:clients_manager/core/services/network/http_service.dart';
import 'package:clients_manager/core/services/network/values_objects/api_data.dart';
import 'package:clients_manager/features/clients_display/data/models/response_create_client_model.dart';
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/create_client/request_create_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/values_objects/character_icon_types.dart';

class UpdateClientService {
  final HttpService httpService;

  UpdateClientService({required this.httpService});

  Future<ResponseCreateClientModel> updateClient(
    RequestCreateClientDTO request,
  ) async {
    try {
      // Campos comunes para todos los casos
      final fields = {
        'clientKey': request.client.clientKey,
        'name': request.client.name,
        'phone': request.client.phone,
        'email': request.client.email,
      };

      Map<String, File>? files;

      // Determinar si se envía iconId o archivo
      if (request.client.characterIcon.type != CharacterIconType.number) {
        // Caso 1: Ícono predeterminado (número 0-9)
        fields['characterIcon'] = request.client.characterIcon.iconId.toString();
      } else if (request.client.characterIcon.file != null) {
        // Caso 2: Imagen personalizada (archivo)
        files = {
          'characterIcon': request.client.characterIcon.file!,
        };
      } else {
        // Caso 3: Fallback - usar ícono 0 por defecto
        fields['characterIcon'] = '0';
      }
      print('fields: $fields');
      print('files: $files');

      // Realizar petición
      final response = await httpService.putFormData(
        ApiData.updateClient,
        headers: {'Authorization': ApiData.keyTokenApiClients},
        fields: fields,
        files: files,
      );

      // Validar respuesta
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = jsonDecode(response.body);
        return ResponseCreateClientModel.fromJson(jsonData);
      } else {
        final jsonData = jsonDecode(response.body);
        return ResponseCreateClientModel(
          success: false,
          message: 'Error del servidor: ${jsonData['message'] ?? response.body}',
        );
      }
    } on SocketException {
      return ResponseCreateClientModel(
        success: false,
        message: 'No hay conexión a internet',
      );
    } on FormatException {
      return ResponseCreateClientModel(
        success: false,
        message: 'Error al procesar la respuesta del servidor',
      );
    } catch (e) {
      print('Error en UpdateClientService: $e');
      return ResponseCreateClientModel(
        success: false,
        message: 'Error inesperado: ${e.toString()}',
      );
    }
  }
}