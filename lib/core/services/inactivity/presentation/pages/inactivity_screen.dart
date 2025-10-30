import 'package:clients_manager/core/services/inactivity/presentation/provider/inactivity_provider.dart';
import 'package:clients_manager/core/services/routes/values_objects/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class InactivityScreen extends StatefulWidget {
  final Widget child;
  final Duration inactivityTimeout;

  const InactivityScreen({
    Key? key,
    required this.child,
    this.inactivityTimeout = const Duration(minutes: 5),
  }) : super(key: key);

  @override
  State<InactivityScreen> createState() => _InactivityScreenState();
}

class _InactivityScreenState extends State<InactivityScreen> {
  // ✅ NO guardar referencia al provider

  @override
  void initState() {
    super.initState();
    // Diferir la inicialización después del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      // ✅ Acceder directamente sin guardar referencia
      context.read<InactivityProvider>().initializeInactivityDetection(
        timeout: widget.inactivityTimeout,
        handleInactivity: () {
          if (mounted) {
            context.go(AppRoutes.login.path);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _recordActivity(),
      onHover: (_) => _recordActivity(),
      child: GestureDetector(
        onTap: _recordActivity,
        onPanDown: (_) => _recordActivity(),
        onLongPress: _recordActivity,
        onVerticalDragDown: (_) => _recordActivity(),
        onHorizontalDragDown: (_) => _recordActivity(),
        child: Listener(
          onPointerDown: (_) => _recordActivity(),
          onPointerMove: (_) => _recordActivity(),
          onPointerUp: (_) => _recordActivity(),
          child: widget.child,
        ),
      ),
    );
  }

  void _recordActivity() {
    // ✅ Acceder directamente al provider cada vez que sea necesario
    if (mounted) {
      context.read<InactivityProvider>().recordUserActivity();
    }
  }

  @override
  void dispose() {
    // ✅ NO llamar a dispose del provider
    // Provider lo gestiona automáticamente
    super.dispose();
  }
}