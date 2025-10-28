import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/delete_client/response_delete_client_d_t_o.dart';

class ResponseDeleteClientModel extends ResponseDeleteClientDTO {
  final bool success;
  final String message;

  ResponseDeleteClientModel({
    required this.success,
    required this.message
  }) : super(
         success: success,
         message: message
       );

  factory ResponseDeleteClientModel.fromJson(Map<String, dynamic> json) {
    return ResponseDeleteClientModel(
      success: json['success'],
      message: json['message']
    );
  }

  ResponseDeleteClientDTO toEntity() {
    return ResponseDeleteClientDTO(
      success: success,
      message: message
    );
  }
}
