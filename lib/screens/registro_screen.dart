import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _registrar() async {

    if (_formKey.currentState!.validate()) {

      await DBHelper.insertUsuario({
        "nombre": nombreController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario guardado ✅")),
      );

      setState(() {});
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Obtener último usuario
  Future<Map<String, dynamic>?> obtenerUsuario() async {
    final data = await DBHelper.getUltimoUsuario();

    if (data.isNotEmpty) {
      return data.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Usuario"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Form(
              key: _formKey,
              child: Column(
                children: [

                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su nombre";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Correo",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su correo";
                      }
                      if (!value.contains("@")) {
                        return "Correo no válido";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese una contraseña";
                      }
                      if (value.length < 6) {
                        return "Mínimo 6 caracteres";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(
                    onPressed: _registrar,
                    child: const Text("Registrar"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            FutureBuilder(
              future: obtenerUsuario(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Text("No hay usuario registrado");
                }

                final usuario = snapshot.data as Map<String, dynamic>;

                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [

                        const CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          usuario["nombre"] ?? "",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        Text(usuario["email"] ?? ""),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}