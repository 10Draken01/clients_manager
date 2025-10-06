import 'package:clients_manager/core/domain/data_transfer_objects/create_client/response_create_client_d_t_o.dart';

class ResponseCreateClientModel extends ResponseCreateClientDTO {
  final bool success;
  final String message;

  ResponseCreateClientModel({
    required this.success,
    required this.message
  }) : super(
         success: success,
         message: message
       );

  factory ResponseCreateClientModel.fromJson(Map<String, dynamic> json) {
    return ResponseCreateClientModel(
      success: json['success'],
      message: json['message']
    );
  }

  ResponseCreateClientDTO toEntity() {
    return ResponseCreateClientDTO(
      success: success,
      message: message
    );
  }
}
