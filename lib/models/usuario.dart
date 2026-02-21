class Usuario {
  final int? id;
  final String nombre;
  final String email;
  final String password;

  Usuario({
    this.id,
    required this.nombre,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'email': email,
      'password': password,
    };
  }
}