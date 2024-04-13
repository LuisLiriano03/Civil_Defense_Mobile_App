import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  List<dynamic> _miembros = [];

  @override
  void initState() {
    super.initState();
    obtenerMiembros();
  }

  Future<void> obtenerMiembros() async {
    final url = Uri.parse("https://adamix.net/defensa_civil/def/miembros.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (responseData['exito']) {
        setState(() {
          _miembros = responseData['datos'];
        });
      } else {
        mostrarError(
            'Hubo un error al obtener los miembros. Por favor, inténtalo de nuevo más tarde.');
      }
    } catch (error) {
      mostrarError(
          'Hubo un error al realizar la solicitud. Por favor, inténtalo de nuevo más tarde.');
    }
  }

  void mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '        Miembros de la Defensa Civil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _miembros.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_miembros[index]['foto']),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(_miembros[index]['nombre']),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(_miembros[index]['cargo']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

