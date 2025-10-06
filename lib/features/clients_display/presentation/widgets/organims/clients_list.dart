import 'package:clients_manager/core/domain/entities/client_entity.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/molecules/client_card.dart';
import 'package:flutter/material.dart';

class ClientsList extends StatelessWidget {
  final List<ClientEntity> clients;
  final List<String> icons;
  final Function(ClientEntity)? onClientTap;
  final Function(ClientEntity)? onClientDelete;
  final VoidCallback? onRefresh;

  const ClientsList({
    super.key,
    required this.clients,
    required this.icons,
    this.onClientTap,
    this.onClientDelete,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          onRefresh!();
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: _buildList(),
      );
    }

    return _buildList();
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      physics: const BouncingScrollPhysics(),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return ClientCard(
          client: client,
          availableIcons: icons,
          index: index,
          onTap: onClientTap != null ? () => onClientTap!(client) : null,
          onDelete: onClientDelete != null ? () => onClientDelete!(client) : null,
        );
      },
    );
  }
}