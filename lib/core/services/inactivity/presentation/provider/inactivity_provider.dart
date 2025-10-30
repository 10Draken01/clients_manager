import 'package:clients_manager/core/services/inactivity/domain/repository/inactivity_repository.dart';
import 'package:flutter/material.dart';

class InactivityProvider extends ChangeNotifier {
  final InactivityRepository inactivityRepository;

  InactivityProvider({
    required this.inactivityRepository,
  });

  void initializeInactivityDetection({
    Duration timeout = const Duration(minutes: 5),
    required VoidCallback handleInactivity,
  }) {
    inactivityRepository.initialize(timeout, handleInactivity);
  }


  void recordUserActivity() {
    inactivityRepository.recordActivity();
  }

  @override
  void dispose() { 
    inactivityRepository.dispose();  //
    super.dispose();
  }
}