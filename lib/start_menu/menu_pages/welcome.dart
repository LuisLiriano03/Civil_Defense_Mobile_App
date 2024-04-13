import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _HomePageState();
}

class _HomePageState extends State<WelcomePage> {
  int currentIndex = 0;
  final PageController controller = PageController();

  List<String> images = [
    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjSIjbhv5nXoR6fUT9AsWHGcP7QImxqBdrgHYWTmMSPygAhC7Q1To48-LbYT3GpTS3hrsNNYE_rSjJtnucd7XEfAiXQLv5OWzJXjhtGhubfzdRwRkZTRyoreId_pfA27LWe_q6FwlIvcK0X0HOuDI9HUlBjBXEYVgFQ5iMExpIOAkhEyJklutPGnC31AA/s1600/Juan%20Salas%20y%20embajador%20El%20Salvador%20%20(1).jpeg",
    "https://presidencia.gob.do/sites/default/files/styles/large/public/news/2022-10/310690518_170442345577808_2718689553182378246_n%20%281%29.jpg?itok=4ZF7puvW",
    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjLo--TYcNvQdFDqZtc_3yjsDuuKPjgSU4M-5pRTRXlRBr7FtctGOiig7_47yoaKWCZHHnBHz0Q6DAuntj6j1t39wKPQlHu7xe4zUONME4-XtcqLEucDASeLwA3X8I5U0GD79cy_Dz5ZBkqQ91qUiqGPwH57Mx_TLJ-rGPJnbl7fCLa7hgaTZIsBjJJ/s1280/photo4954219934301399789.jpg",
    "https://dominicanrepublic.iom.int/sites/g/files/tmzbdl911/files/styles/large/public/press_release/media/img_9527.jpg?itok=ZXgrJirr",
    "https://presidencia.gob.do/sites/default/files/styles/large/public/news/2022-04/1.JPG?itok=k7mMcO-E",
  ];

  List<String> textos = [
    "Embajador de El Salvador en RD felicita al director de la Defensa Civil por su gestión e implementación de nuevas tecnologías.",
    "Defensa Civil apuesta al uso de la tecnología para ser más eficiente ante cualquier fenómeno",
    "Superate y Defensa Civil fortalecerán el voluntariado en comunidades vulnerables del país",
    "Defensa Civil y OIM realizan taller de primeros auxilios para periodistas y comunicadores",
    "Defensa Civil y CTC acuerdan tratar prevención de desastres a zonas rurales a través de amplia red comunicacional",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(18.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 230, // Ajuste de altura de la imagen
              width: double.infinity,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10), // Espacio entre la imagen y el texto
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        textos[currentIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index % images.length;
                      });
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            images[index % images.length],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < images.length; i++)
                  buildIndicator(currentIndex == i)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
