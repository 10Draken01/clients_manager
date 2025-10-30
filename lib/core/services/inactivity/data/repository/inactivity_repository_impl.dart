import 'dart:async';
import 'package:clients_manager/core/services/inactivity/domain/repository/inactivity_repository.dart';
import 'package:flutter/material.dart';

class InactivityRepositoryImpl implements InactivityRepository {
  Timer? _inactivityTimer;
  late Duration _inactivityDuration;
  late VoidCallback _onInactivityCallback;

  @override
  void initialize(Duration timeout, VoidCallback onInactivity) {
    _inactivityDuration = timeout;
    _onInactivityCallback = onInactivity;
    _startTimer();
  }

  @override
  void recordActivity() {
    _inactivityTimer?.cancel();
    _startTimer();
  }

  void _startTimer() {
    _inactivityTimer = Timer(_inactivityDuration, () {
      _onInactivityCallback();
    });
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
  }
}