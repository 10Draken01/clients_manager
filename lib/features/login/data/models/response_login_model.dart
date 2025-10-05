import 'package:clients_manager/features/login/domain/data_transfer_objects/response_login_d_t_o.dart';

class ResponseLoginModel extends ResponseLoginDTO {
  final bool success;
  final String message;

  ResponseLoginModel({required this.success, required this.message})
    : super(success: success, message: message);

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModel(
      success: json['success'],
      message: json['message'],
    );
  }

  ResponseLoginDTO toEntity() {
    return ResponseLoginDTO(success: success, message: message);
  }
}
