import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prue/providers/location/location_gps.dart';
import 'package:prue/utilities/colors.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//https://pub.dev/packages/youtube_player_flutter

class VideoGastronomia extends StatelessWidget {
  const VideoGastronomia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'NN66-C9JDWY',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorFondoImagenes,
        title: Text('Gastronomia en fusagasugá'),
      ),
      body: Center(
        child: Column(
          children: [
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
                progressColors: const ProgressBarColors(
                    playedColor: Colors.blue, handleColor: Colors.blueAccent),
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    // some widgets
                    player,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Card(
                            elevation: 10,
                            child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          'Gastronomia en Fusagasugá',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Text(
                                        'Ubicándonos en Fusagasugá, ciudad capital de la Provincia del Sumapaz; emprendimos la tarea de buscar un plato típico representativo del lugar. Al investigar en internet, en guías turísticas y tras preguntarle a los mismos ciudadanos se encontró con una confusión acerca de la gastronomía fusagasugueña.'),
                                    Container(
                                      child: Center(
                                          child: FutureBuilder(
                                        future: determinePosition(),
                                        builder: (context,
                                            AsyncSnapshot<Position> asyncSnap) {
                                          if (asyncSnap.hasData) {
                                            return Text(
                                                'Hoola soy position ${asyncSnap.data!}');
                                          } else {
                                            print('esto es ${asyncSnap.data}');
                                            return Text('${asyncSnap.data}');
                                          }

                                          return Center(child: ProgressBar());
                                        },
                                      )),
                                    ),
                                  ],
                                ))),
                      ),
                    )
                    //some other widgets
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
