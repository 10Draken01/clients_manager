
class ResponseLoginDTO {
  final bool success;
  final String message;
  final Map<String, dynamic>? user;

  ResponseLoginDTO({required this.success, required this.message, this.user});
}