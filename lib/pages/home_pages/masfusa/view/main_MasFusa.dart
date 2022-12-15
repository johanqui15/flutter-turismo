import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prue/pages/home_pages/masfusa/model/arguments_calendario.dart';
import 'package:prue/pages/home_pages/masfusa/viewmodel/connection_calendario.dart';
import 'package:prue/providers/location/location_gps.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/route_restaurant.dart';
import 'package:prue/utilities/colors.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../restaurant_pages/view/selected_restaurant_page.dart';
//https://pub.dev/packages/youtube_player_flutter

class MainMasFusa extends StatelessWidget {
  const MainMasFusa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'U2dZKUfYS20',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    MediaQueryData queryData = MediaQuery.of(context);
    final widht = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home/fondo_tres.png'),
                fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.06),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widht * 0),
                    child: ButtonBack(widht, context),
                  ),
                  Spacer(),
                  Container(
                    child:
                        Image.asset('assets/+fusa/+FUSAGASUGA BLANCO-19.png'),
                    width: 300,
                    height: 100,
                  ),
                  Spacer()
                ],
              ),
            ],
          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.24),
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
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 5, left: 5),
                        child: Container(
                          child: Card(
                            elevation: 10,
                          ),
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

        //calendario
        Padding(
            padding: EdgeInsets.only(top: height * 0.46),
            child: FutureBuilder(
              future: ConnectionCalendario().getCalendario(),
              builder: (context,
                  AsyncSnapshot<List<ArgumentsCalendario>> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  return ListView(
                      children: listItems(asyncSnapshot.data!, context));
                } else {
                  return const Center(
                    child: Text('No se logró cargar la información'),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      ]),
    );
  }
}

List<Widget> listItems(List<ArgumentsCalendario> data, BuildContext context) {
  List<Widget> listItems = [];

  data.forEach((element) {
    //VALIDACION QUE RED SOCIAL ES

    listItems.add(Column(
      children: [
        //cafe name
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ExpandableText(
                  element.titulo,
                  expandText: 'Ver más',
                  collapseText: 'Ver menos',
                  maxLines: 2,
                  linkColor: Colors.blue,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 12, 12, 12),
                      fontWeight: FontWeight.bold),
                ),
              ),

              // Text(
              //   element.title,
              //   style: const TextStyle(
              //       fontWeight: FontWeight.w700,
              //       fontSize: 18.0,
              //       shadows: [
              //         Shadow(
              //           blurRadius: 18.0,
              //           color: Color.fromARGB(255, 27, 116, 116),
              //           offset: Offset(0, 1.0),
              //         )
              //       ]),
              // ),
              TextButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.navigation_rounded),
                      Text('Ir a Fusagasugá')
                    ]),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              RouteRestaurant(linkRuta: element.ruta))));
                },
              )
            ],
          ),
        ),
        //Restaurant Image
        ListaImagenes(element.imagenes, context),

        const Divider(
          color: Colors.white,
        ),

        Text('Calendario de Eventos',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // if you need this
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExpandableText(
                    element.descripcion,
                    expandText: 'Ver más',
                    collapseText: 'Ver menos',
                    maxLines: 7,
                    linkColor: Colors.blue,
                    textAlign: TextAlign.justify,
                  ),
                )),
          ),
        )
      ],
    ));
  });

  return listItems;
}

//imagenes where we can see two or more images in a carousel
Widget ListaImagenes(List listaImagenes, BuildContext context) {
  String localHost = '';
  if (Platform.isAndroid) {
    //192.168.20.47
    // localHost = 'https://api.destinofusagasuga.gov.co';
    localHost = 'https://api.destinofusagasuga.gov.co';
  } else if (Platform.isIOS) {
    // localHost = 'https://api.destinofusagasuga.gov.co';
    localHost = 'https://api.destinofusagasuga.gov.co';
  }
  return CarouselSlider(
    options: CarouselOptions(height: 250.0),
    items: listaImagenes.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              color: colorBackgroudScreens,
            ),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorBackgroudScreens,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                        image: NetworkImage('${localHost}${i}')),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                //Show image in dialog when we tap  the picture
                await showDialog(
                    context: context,
                    builder: (_) => ImageDialog('${localHost}${i}'));
              },
            ),
          );
        },
      );
    }).toList(),
  );
}

//Show image in dialog when we tap  the picture
Widget ImageDialog(String linkFoto) {
  return Dialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    child: Container(
      height: 480,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(linkFoto), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(30)),
    ),
    insetAnimationCurve: Curves.decelerate,
  );
}
