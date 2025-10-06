import 'package:clients_manager/core/domain/data_transfer_objects/create_client/request_create_client_d_t_o.dart';
import 'package:clients_manager/core/domain/entities/character_icon_entity.dart';
import 'package:clients_manager/core/domain/entities/client_entity.dart';

class CreateRequestCreateClientUseCase {
  RequestCreateClientDTO call(
    String? claveCliente,
    String? nombre,
    String? celular,
    String? email,
    CharacterIconEntity? characterIcon,
  ) {

    if(claveCliente == null || nombre == null || celular == null || email == null || characterIcon == null) {
      throw Exception('All client fields must be provided');
    }
    final client = ClientEntity(
      id: '',
      claveCliente: claveCliente,
      nombre: nombre,
      celular: celular,
      email: email,
      characterIcon: characterIcon,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return RequestCreateClientDTO(client: client);
  }
}