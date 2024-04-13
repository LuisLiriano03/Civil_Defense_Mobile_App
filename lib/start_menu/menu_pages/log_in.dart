
import 'package:fianal/menu_post_login/menu_post/menu_post.dart';
import 'package:fianal/token/my_token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogInPage extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogInPage> {
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();

  Future<void> _iniciarSesion() async {
    final cedula = _cedulaController.text;
    final clave = _claveController.text;

    if (cedula.isEmpty || clave.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Campos requeridos'),
            content: Text('Por favor, completa todos los campos.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      final url =
      Uri.parse("https://adamix.net/defensa_civil/def/iniciar_sesion.php");

      final response =
      await http.post(url, body: {'cedula': cedula, 'clave': clave});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['exito']) {
          // Almacena el token utilizando la clase TokenManager
          TokenManager tokenManager = TokenManager();
          final String token = jsonResponse['datos']['token'];
          tokenManager.token = token;

          // Navega a la página de noticias después de iniciar sesión
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuPostPage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error de inicio de sesión'),
                content: Text(jsonResponse['mensaje']),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Error de conexión. Por favor, inténtalo de nuevo más tarde.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300], // Color gris para el fondo
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _cedulaController,
                      decoration: InputDecoration(
                        labelText: 'Cédula',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _claveController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _iniciarSesion,
                      child: Text('Iniciar Sesión'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




