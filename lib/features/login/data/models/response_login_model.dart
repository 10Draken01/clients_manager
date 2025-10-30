import 'package:clients_manager/core/src/data/models/user_model.dart';
import 'package:clients_manager/features/login/domain/data_transfer_objects/response_login_d_t_o.dart';

class ResponseLoginModel extends ResponseLoginDTO {
  final bool success;
  final String message;
  final Map<String, dynamic>? user;

  ResponseLoginModel({required this.success, required this.message, this.user})
    : super(success: success, message: message);

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    print(  'ResponseLoginModel.fromJson userJson: $userJson');
    return ResponseLoginModel(
      success: json['success'],
      message: json['message'],
      user: json['user']
    );
  }

  ResponseLoginDTO toEntity() {
    return ResponseLoginDTO(success: success, message: message);
  }
}
