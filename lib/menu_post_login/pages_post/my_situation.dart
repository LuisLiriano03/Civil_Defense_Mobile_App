
import 'package:flutter/material.dart';
import 'package:fianal/token/my_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySituationPage extends StatefulWidget {
  @override
  _MySituationState createState() => _MySituationState();
}

class _MySituationState extends State<MySituationPage> {
  List<dynamic> _situaciones = [];

  @override
  void initState() {
    super.initState();
    _loadSituaciones();
  }

  Future<void> _loadSituaciones() async {
    final tokenManager = TokenManager();
    String? token = tokenManager.token;

    if (token != null) {
      final url = Uri.parse(
          "https://adamix.net/defensa_civil/def/situaciones.php");

      final response = await http.post(url, body: {'token': token});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['exito']) {
          setState(() {
            _situaciones = jsonResponse['datos'];
          });
        } else {
          _showErrorDialog(
              'Error al cargar las situaciones', jsonResponse['mensaje']);
        }
      } else {
        _showErrorDialog('Error',
            'Error de conexión. Por favor, inténtalo de nuevo más tarde.');
      }
    } else {
      _showErrorDialog('Error', 'No se ha encontrado un token almacenado.');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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
      body: Container(
        color: Colors.grey[700], // Establece el color de fondo gris
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '                   Mis Situaciones',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _situaciones.length,
                itemBuilder: (context, index) {
                  final situacion = _situaciones[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(situacion['titulo']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código: ${situacion['codigo']}'),
                          if (situacion['foto'] != null)
                            Image.network(
                              situacion['foto'],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          Text('Estado: ${situacion['estado']}'),
                          Text('Fecha: ${situacion['fecha']}'),
                          Text('Descripción: ${situacion['descripcion']}'),
                          Text(
                              'Comentarios: ${situacion['comentarios'] ?? 'No hay comentarios'}'),
                        ],
                      ),
                      // Agrega más detalles si es necesario
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

