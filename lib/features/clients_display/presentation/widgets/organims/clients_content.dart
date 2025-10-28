import 'package:clients_manager/features/clients_display/domain/entities/client_entity.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/molecules/empty_clients_state.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/organims/clients_grid.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/organims/clients_list.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/organims/loading_clients_skeleton.dart';
import 'package:flutter/material.dart';

enum ClientsViewMode { list, grid }

class ClientsContent extends StatelessWidget {
  final bool isLoading;
  final List<ClientEntity> clients;
  final List<String> icons;
  final String? errorMessage;
  final ClientsViewMode viewMode;
  final Function(ClientEntity)? onClientTap;
  final Function(ClientEntity)? onClientDelete;
  final VoidCallback? onRefresh;

  const ClientsContent({
    super.key,
    required this.isLoading,
    required this.clients,
    required this.icons,
    this.errorMessage,
    this.viewMode = ClientsViewMode.list,
    this.onClientTap,
    this.onClientDelete,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingClientsSkeleton(itemCount: 6);
    }

    if (errorMessage != null && clients.isEmpty) {
      return EmptyClientsState(message: errorMessage!);
    }

    if (clients.isEmpty) {
      return const EmptyClientsState();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: viewMode == ClientsViewMode.list
          ? ClientsList(
              key: const ValueKey('list'),
              clients: clients,
              icons: icons,
              onClientTap: onClientTap,
              onClientDelete: onClientDelete,
              onRefresh: onRefresh,
            )
          : ClientsGrid(
              key: const ValueKey('grid'),
              clients: clients,
              icons: icons,
              onClientTap: onClientTap,
              onRefresh: onRefresh,
            ),
    );
  }
}