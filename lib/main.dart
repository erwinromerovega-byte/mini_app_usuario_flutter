import 'package:flutter/material.dart';
import 'screens/registro_screen.dart';
import 'screens/perfil_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Ruta inicial
      initialRoute: "/",

      // Navegación de la app
      routes: {
        "/": (context) => const RegistroScreen(),
        "/perfil": (context) => const PerfilScreen(),
      },
    );
  }
}