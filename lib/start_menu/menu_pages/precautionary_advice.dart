import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Servicio {
  final String id;
  final String titulo;
  final String descripcion;
  final String imageUrl;

  Servicio({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imageUrl,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imageUrl: json['foto'] ?? '',
    );
  }
}

class PrecautionaryAdvicePage extends StatelessWidget {
  final String apiUrl = "https://adamix.net/defensa_civil/def/medidas_preventivas.php";

  const PrecautionaryAdvicePage({Key? key});

  Future<List<Servicio>> fetchServicios() async {
    var result = await http.get(Uri.parse(apiUrl));
    if (result.statusCode == 200) {
      List<dynamic> serviciosJson = json.decode(result.body)['datos'];
      return serviciosJson.map((json) => Servicio.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load servicios');
    }
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
              '               Medidas Preventivas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<Servicio>>(
                future: fetchServicios(),
                builder: (BuildContext context, AsyncSnapshot<List<Servicio>> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    snapshot.data![index].titulo,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].descripcion,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      snapshot.data![index].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
