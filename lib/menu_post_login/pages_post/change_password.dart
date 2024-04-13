import 'dart:convert';
import 'package:fianal/token/my_token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String _message = '';

  Future<void> _changePassword() async {

    final tokenManager = TokenManager();
    String? token = tokenManager.token;
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;

    if (token != null && oldPassword.isNotEmpty && newPassword.isNotEmpty) {
      final url = Uri.parse("https://adamix.net/defensa_civil/def/cambiar_clave.php");
      final response = await http.post(url, body: {
        'token': token,
        'clave_anterior': oldPassword,
        'clave_nueva': newPassword,
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['exito']) {
          setState(() {
            _message = 'Contraseña cambiada exitosamente';
            _oldPasswordController.text = '';
            _newPasswordController.text = '';
          });
        } else {
          _showErrorDialog('Error', jsonResponse['mensaje']);
        }
      } else {
        _showErrorDialog('Error', 'Error de conexión. Por favor, inténtalo de nuevo más tarde.');
      }
    } else {
      _showErrorDialog('Error', 'Por favor, completa todos los campos.');
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    'Cambiar Contraseña',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _oldPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña Anterior',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.lock_outlined, color: Colors.blue),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Nueva Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.blue),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _changePassword,
                    child: Text('Cambiar Contraseña'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(_message, style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
