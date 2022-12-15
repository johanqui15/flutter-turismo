import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prue/pages/home_pages/history_pages/items/historia/model/arguments_historia.dart';
import 'package:prue/pages/home_pages/history_pages/items/historia/viewmodel/connection_historia.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/route_restaurant.dart';
import 'package:prue/utilities/colors.dart';

class HistoriaPage extends StatefulWidget {
  HistoriaPage({Key? key}) : super(key: key);

  @override
  State<HistoriaPage> createState() => _HistoriaPageState();
}

class _HistoriaPageState extends State<HistoriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: ConnectionHistoria().getHistoria(),
        builder:
            (context, AsyncSnapshot<List<ArgumentsHistoria>> asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return ListView(children: listItems(asyncSnapshot.data!, context));
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
    );
  }
}

List<Widget> listItems(List<ArgumentsHistoria> data, BuildContext context) {
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
                  element.title,
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
                          builder: ((context) => RouteRestaurant(
                              linkRuta: element.link_ubicacion))));
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

        Text('Historia',
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
    options: CarouselOptions(height: 400.0),
    items: listaImagenes.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
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
