
import 'dart:io';

import 'package:fianal/token/my_token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class ReportSituationPage extends StatefulWidget {
  @override
  _ReportarSituacionPageState createState() => _ReportarSituacionPageState();
}

class _ReportarSituacionPageState extends State<ReportSituationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  File? _image;
  final TextEditingController _latitudController = TextEditingController();
  final TextEditingController _longitudController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Reportar Situación',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _tituloController,
                      decoration: InputDecoration(
                        labelText: 'Título del evento o situación',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.flag_outlined, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese un título';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _descripcionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción completa de lo ocurrido',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.description_outlined, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese una descripción';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _image != null
                        ? Image.network(
                      _image!.path,
                      height: 200,
                      width: 200,
                    )
                        : SizedBox(height: 200, width: 200), // Widget de espacio para mostrar la imagen
                    ElevatedButton(
                      onPressed: _selectImage,
                      child: Text('Seleccionar foto'),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _latitudController,
                      decoration: InputDecoration(
                        labelText: 'Latitud',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.location_on_outlined, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese la latitud';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _longitudController,
                      decoration: InputDecoration(
                        labelText: 'Longitud',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.location_on_outlined, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese la longitud';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _enviarSituacion,
                      child: Text('Enviar'),
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

  Future<void> _selectImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _enviarSituacion() async {
    final tokenManager = TokenManager();
    String? token = tokenManager.token;

    if (token != null) {
      if (_formKey.currentState!.validate()) {
        final url = Uri.parse(
            "https://adamix.net/defensa_civil/def/nueva_situacion.php");

        if (_image == null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Por favor, seleccione una imagen.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }

        try {
          List<int> imageBytes = await _image!.readAsBytes();
          String base64Image = base64Encode(imageBytes);

          final response = await http.post(url, body: {
            'token': token,
            'titulo': _tituloController.text,
            'descripcion': _descripcionController.text,
            'foto': base64Image,
            'latitud': _latitudController.text,
            'longitud': _longitudController.text,
          });

          final jsonResponse = json.decode(response.body);
          if (jsonResponse['exito']) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Reporte Exitoso'),
                  content: Text(jsonResponse['mensaje']),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _limpiarFormulario();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error al enviar la situación'),
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
        } catch (error) {
          print('Error al enviar la situación: $error');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Ocurrió un error al enviar la situación.'),
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se ha encontrado un token almacenado.'),
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

  void _limpiarFormulario() {
    _tituloController.clear();
    _descripcionController.clear();
    setState(() {
      _image = null;
    });
    _latitudController.clear();
    _longitudController.clear();
  }
}
