import 'package:clients_manager/features/clients_display/presentation/providers/clients_display_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ClientsDisplayScreen extends StatefulWidget {
  const ClientsDisplayScreen({super.key});

  @override
  State<ClientsDisplayScreen> createState() => _ClientsDisplayState();
}

class _ClientsDisplayState extends State<ClientsDisplayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ClientsDisplayProvider>();

      provider.onGetPageClientsSuccess = () {
        if(mounted) {
          // Aqui para navegar a algun lado
        }
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          
        ],
      ),
    );
  }
}
