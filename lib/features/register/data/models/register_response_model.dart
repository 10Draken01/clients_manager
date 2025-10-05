import 'package:clients_manager/features/register/domain/data_transfer_objects/response_register_d_t_o.dart';

class RegisterResponseModel extends ResponseRegisterDTO {
  final bool success;
  final String message;

  RegisterResponseModel({required this.success, required this.message})
    : super(success: success, message: message);

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }

  ResponseRegisterDTO toEntity() {
    return ResponseRegisterDTO(success: success, message: message);
  }
}
