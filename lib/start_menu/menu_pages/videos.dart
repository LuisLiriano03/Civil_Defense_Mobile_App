import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video {
  final String titulo;
  final String descripcion;
  final String link;

  Video({required this.titulo, required this.descripcion, required this.link});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideosPage(),
    );
  }
}

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  late List<Video> videos;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/videos.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        videos = List<Video>.from(jsonData['datos'].map((video) => Video(
          titulo: video['titulo'],
          descripcion: video['descripcion'],
          link: video['link'],
        )));
      });
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('              Videos de la Defensa Civil'),
      ),
      body: videos != null
          ? ListView.builder(
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) {
          return VideoCard(video: videos[index]);
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Video video;

  VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: video.link,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  video.descripcion,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
