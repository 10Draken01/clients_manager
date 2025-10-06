import 'package:clients_manager/core/domain/entities/client_entity.dart';
import 'package:clients_manager/core/domain/values_objects/character_icons_images.dart';
import 'package:clients_manager/core/routes/app_routes.dart';
import 'package:clients_manager/features/client_form/presentation/page/client_form_screen.dart';
import 'package:clients_manager/features/clients_display/presentation/providers/clients_display_provider.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/molecules/delete_confirmation_dialog.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/organims/clients_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ClientsDisplayScreen extends StatefulWidget {
  const ClientsDisplayScreen({super.key});

  @override
  State<ClientsDisplayScreen> createState() => _ClientsDisplayScreenState();
}

class _ClientsDisplayScreenState extends State<ClientsDisplayScreen>
    with SingleTickerProviderStateMixin {
  ClientsViewMode _viewMode = ClientsViewMode.list;
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _initializeFabAnimation();
    _initializeScreen();
  }

  void _initializeFabAnimation() {
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeInOut,
    );
    _fabController.forward();
  }

  void _initializeScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ClientsDisplayProvider>();
      provider.getPageClients();

      provider.onGetPageClientsSuccess = () {
        if (mounted) {
          _showSuccessSnackBar('Clientes cargados exitosamente');
        }
      };
    });
  }

  void _showSuccessSnackBar(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _toggleViewMode() {
    HapticFeedback.lightImpact();
    setState(() {
      _viewMode = _viewMode == ClientsViewMode.list
          ? ClientsViewMode.grid
          : ClientsViewMode.list;
    });
  }

  void _refreshClients() {
    HapticFeedback.mediumImpact();
    context.read<ClientsDisplayProvider>().getPageClients();
  }

  void _onClientTap(ClientEntity client) {
    HapticFeedback.selectionClick();
    _navigateToEditClient(client);
  }

  void _onClientDelete(ClientEntity client) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        clientName: client.nombre,
        onConfirm: () => _deleteClient(client),
      ),
    );
  }

  void _deleteClient(ClientEntity client) {
    
    print('ELIMINAR CLIENTE: ${client.claveCliente} - ${client.nombre}');
    context.read<ClientsDisplayProvider>().deleteClient(client.claveCliente);
    
    _showSuccessSnackBar('Cliente eliminado exitosamente');
  }

  Future<void> _navigateToCreateClient() async {
    HapticFeedback.mediumImpact();

    final result = await AppRoutes.navigateTo(context, AppRoutes.client_form);

    if (result == true && mounted) {
      _refreshClients();
    }
  }

  Future<void> _navigateToEditClient(ClientEntity client) async {
    
    final result = await AppRoutes.navigateTo(context, AppRoutes.client_form, arguments: {'clientToEdit': client});

    if (result == true && mounted) {
      _refreshClients();
    }
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Clientes'),
        actions: [
          // Toggle view mode
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: IconButton(
              key: ValueKey(_viewMode),
              icon: Icon(
                _viewMode == ClientsViewMode.list
                    ? Icons.grid_view_rounded
                    : Icons.view_list_rounded,
              ),
              onPressed: _toggleViewMode,
              tooltip: _viewMode == ClientsViewMode.list
                  ? 'Vista en cuadrícula'
                  : 'Vista en lista',
            ),
          ),

          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _refreshClients,
            tooltip: 'Actualizar',
          ),

          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<ClientsDisplayProvider>(
        builder: (context, provider, _) {
          return ClientsContent(
            isLoading: provider.isLoading,
            clients: provider.clients,
            icons: CharacterIconsImages.listIcons,
            errorMessage: provider.message,
            viewMode: _viewMode,
            onClientTap: _onClientTap,
            onClientDelete: _onClientDelete,
            onRefresh: _refreshClients,
          );
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton.extended(
          onPressed: _navigateToCreateClient,
          icon: const Icon(Icons.person_add_rounded),
          label: const Text('Agregar'),
          elevation: 4,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}