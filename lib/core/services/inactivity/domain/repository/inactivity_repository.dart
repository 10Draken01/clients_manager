import 'package:flutter/material.dart';

abstract class InactivityRepository {
  void initialize(Duration timeout, VoidCallback onInactivity);
  void recordActivity();
  void dispose();
}