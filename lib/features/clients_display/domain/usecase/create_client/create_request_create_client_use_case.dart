
import 'package:clients_manager/features/clients_display/domain/data_transfer_objects/create_client/request_create_client_d_t_o.dart';
import 'package:clients_manager/features/clients_display/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';

class CreateRequestCreateClientUseCase {
  RequestCreateClientDTO call(
    String? clientKey,
    String? name,
    String? phone,
    String? email,
    CharacterIconEntity? characterIcon,
  ) {

    if(clientKey == null || name == null || phone == null || email == null || characterIcon == null) {
      throw Exception('All client fields must be provided');
    }
    final client = ClientEntity(
      id: '',
      clientKey: clientKey,
      name: name,
      phone: phone,
      email: email,
      characterIcon: characterIcon,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return RequestCreateClientDTO(client: client);
  }
}