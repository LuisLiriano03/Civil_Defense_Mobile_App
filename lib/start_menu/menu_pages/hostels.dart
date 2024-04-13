import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Shelter {
  final String city;
  final String building;
  final String coordinator;
  final String phoneNumber;
  final String capacity;

  Shelter({
    required this.city,
    required this.building,
    required this.coordinator,
    required this.phoneNumber,
    required this.capacity,
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      city: json['ciudad'],
      building: json['edificio'],
      coordinator: json['coordinador'],
      phoneNumber: json['telefono'],
      capacity: json['capacidad'],
    );
  }
}

class HostelsPage extends StatefulWidget {
  @override
  _HostelsPageState createState() => _HostelsPageState();
}

class _HostelsPageState extends State<HostelsPage> {
  late List<Shelter> shelters;

  @override
  void initState() {
    super.initState();
    fetchShelters();
  }

  Future<void> fetchShelters() async {
    final response = await http.get(Uri.parse("https://adamix.net/defensa_civil/def/albergues.php"));
    final jsonData = jsonDecode(response.body);
    if (jsonData['exito']) {
      List<dynamic> data = jsonData['datos'];
      shelters = data.map((json) => Shelter.fromJson(json)).toList();
      setState(() {});
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
              '        Albergues de la Defensa Civil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: shelters != null
                ? ListView.builder(
              itemCount: shelters.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(shelters[index].building),
                    subtitle: Text(shelters[index].city),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.symmetric(horizontal: 40.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Detalles del Albergue',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Text('Ciudad: ${shelters[index].city}'),
                                  SizedBox(height: 8.0),
                                  Text('Edificio: ${shelters[index].building}'),
                                  SizedBox(height: 8.0),
                                  Text('Coordinador: ${shelters[index].coordinator}'),
                                  SizedBox(height: 8.0),
                                  Text('Teléfono: ${shelters[index].phoneNumber}'),
                                  SizedBox(height: 8.0),
                                  Text('Capacidad: ${shelters[index].capacity}'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
