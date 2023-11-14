import 'package:bars/internal/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'internal/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );  
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  initializeDependencies();
  runApp(Application());
}
