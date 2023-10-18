import 'package:bars/internal/application.dart';
import 'package:flutter/material.dart';
import 'internal/injection_container.dart';

void main() {
  initializeDependencies();
  runApp(Application());
}
