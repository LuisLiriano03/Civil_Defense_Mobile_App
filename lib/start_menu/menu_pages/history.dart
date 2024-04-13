import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '           Historia Defensa Civil',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10), // Espacio de 10 puntos entre el título y la imagen
                Image.network(
                  'https://defensacivil.gob.do/images/slide/2021/logoNuevoDefensa.png', // Ruta de la imagen, ajusta esto según la ubicación de tu imagen
                  height: 350, // Altura de la imagen, ajusta esto según tus necesidades
                  width: MediaQuery.of(context).size.width, // Ancho de la imagen igual al ancho de la pantalla
                  fit: BoxFit.cover, // Ajuste de la imagen para cubrir el espacio disponible
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Antes del año 1966, cuando llegaba la temporada de huracanes, un grupo de radioaficionados se reunía en la Cruz Roja para estar atentos por si surgía algún tipo de emergencia, inmediatamente ponerse a disposición y ayudar en todo lo posible, inclusive, usando sus propios equipos de comunicación para así tener contacto con el exterior en caso de que las redes telefónicas resultaran afectadas.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Al surgir el triunvirato fue designado el Dr. Rafael Cantizano Arias, como presidente de la Cruz Roja y al mismo tiempo nombraron al Ing. Carlos D´ Franco como director de la Defensa Civil, quien con un grupo compuesto por seis personas, se instaló en la calle Francia esquina Galván, siendo esa la primera oficina de la Defensa Civil.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Al surgir el Gobierno Provisional, presidido por el Dr. Héctor García Godoy, a los diecisiete días del mes de junio de 1966, fue promulgada la Ley 257, mediante la cual fue creada la Defensa Civil, institución dependiente de la Secretaría Administrativa de la Presidencia (ahora Ministerio de la Presidencia) y quien en la actualidad preside la Comisión Nacional de Emergencias.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Más adelante, el local fue trasladado a la calle Dr. Delgado No. 164 y luego en la gestión del Contralmirante Radhamés Lora Salcedo se reubicó a la Plaza de la Salud, donde aún permanece.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Lista de ex-directores de la Defensa Civil',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _buildExDirectorsTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExDirectorsTable() {
    return Table(
      border: TableBorder.all(), // Borde para la tabla
      children: const [
        TableRow(
          // Fila de encabezados de la tabla
          children: [
            TableCell(
              child: Center(child: Text('Director',
                  style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(child: Text('Inicio de gestión',
                  style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(child: Text('Fin de gestión',
                  style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
        // Filas de datos de la tabla
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Ing. Carlos D Franco')),
            ),
            TableCell(
              child: Center(child: Text('17-07-1966')),
            ),
            TableCell(
              child: Center(child: Text('11-06-1971')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Dr. Mariano Ariza Hernández')),
            ),
            TableCell(
              child: Center(child: Text('11-06-1971')),
            ),
            TableCell(
              child: Center(child: Text('26-08-1974')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Dr. Pedro Justiniano Polanco')),
            ),
            TableCell(
              child: Center(child: Text('26-08-1974')),
            ),
            TableCell(
              child: Center(child: Text('15-01-1982')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Dr. Domingo Porfirio Rojas')),
            ),
            TableCell(
              child: Center(child: Text('15-01-1982')),
            ),
            TableCell(
              child: Center(child: Text('16-01-1985')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Lic. Alfonso Julia Mera')),
            ),
            TableCell(
              child: Center(child: Text('16-01-1985')),
            ),
            TableCell(
              child: Center(child: Text('28-08-1986')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Dr. Eugenio Cabral Martínez')),
            ),
            TableCell(
              child: Center(child: Text('28-08-1986')),
            ),
            TableCell(
              child: Center(child: Text('01-09-1998')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Lic. Manuel Elpidio Báez')),
            ),
            TableCell(
              child: Center(child: Text('01-09-1998')),
            ),
            TableCell(
              child: Center(child: Text('27-02-1999')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('José Antonio De los Santos')),
            ),
            TableCell(
              child: Center(child: Text('27-02-1999')),
            ),
            TableCell(
              child: Center(child: Text('17-08-2000')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Radhames Lora Salcedo')),
            ),
            TableCell(
              child: Center(child: Text('17-08-2000')),
            ),
            TableCell(
              child: Center(child: Text('01-09-2004')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Lic. Luis Antonio Luna Paulino')),
            ),
            TableCell(
              child: Center(child: Text('01-09-2004')),
            ),
            TableCell(
              child: Center(child: Text('10-10-2014')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Rafael Emilio De Luna Pichirilo')),
            ),
            TableCell(
              child: Center(child: Text('10-10-2014')),
            ),
            TableCell(
              child: Center(child: Text('01-02-2017')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Rafael Antonio Carrasco Paulino')),
            ),
            TableCell(
              child: Center(child: Text('01-02-2017')),
            ),
            TableCell(
              child: Center(child: Text('05-05-2021')),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(child: Text('Lic. Juan Cesario Salas Rosario',
                  style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(child: Text('05-05-2021',
                  style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            TableCell(
              child: Center(child: Text('Director actual',
                  style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ],
    );
  }
}

class History extends StatelessWidget {
  const History({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HistoryPage(),
          ],
        ),
      ),
    );
  }
}
