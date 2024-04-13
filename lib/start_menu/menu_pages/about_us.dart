import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '              Acerca de Nosotros',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildDeveloperInfo('Susan Liriano','susan.lirianox05@gmail.com', '520-752-1023', 'San Pedro de Macoris, \nRep. Dom.'),
              SizedBox(height: 20),
              _buildDeveloperInfo('Junior Calvo', 'juniorcalvo0410@gmail.com', '809-555-1234', 'Santo Domingo, \nRep. Dom.'),
              SizedBox(height: 20),
              _buildDeveloperInfo('Daniel Baez', 'danielbalez1@gmail.com', '809-555-5678', 'Santo Domingo, \nRep. Dom.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperInfo(String name, String phone, String email, String location) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' $name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              ' $phone',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              ' $email',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.deepOrange,),
                SizedBox(width: 5.0),
                Text(
                  location,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
