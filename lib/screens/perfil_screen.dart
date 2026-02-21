import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {

  Map<String, dynamic>? usuario;

  Future<void> cargarUsuario() async {
    final data = await DBHelper.getUltimoUsuario();

    if (data.isNotEmpty) {
      usuario = data.first;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil Usuario")),
      body: usuario == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(height: 20),
                      Text(usuario!["nombre"]),
                      Text(usuario!["email"]),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}