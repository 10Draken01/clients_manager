import 'package:clients_manager/features/profile/presentation/provider/profile_provider.dart';
import 'package:clients_manager/features/profile/presentation/widgets/organims/profile_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 👤 Pantalla de Perfil del Usuario
/// Muestra la información personal del usuario autenticado
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _appBarAnimController;
  late Animation<double> _appBarAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadProfile();
  }

  void _initializeAnimations() {
    _appBarAnimController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _appBarAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _appBarAnimController, curve: Curves.easeOut),
    );
    _appBarAnimController.forward();
  }

  void _loadProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileProvider>().loadUserProfile();
      }
    });
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _appBarAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
          tooltip: 'Regresar',
        ),
        title: FadeTransition(
          opacity: _appBarAnimation,
          child: const Text(
            'Mi Perfil',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        scrolledUnderElevation: 0,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          return ProfileContent(
            user: profileProvider.user,
            isLoading: profileProvider.isLoading,
            state: profileProvider.state,
            onRefresh: () async {
              await profileProvider.refreshProfile();
            },
          );
        },
      ),
    );
  }
}