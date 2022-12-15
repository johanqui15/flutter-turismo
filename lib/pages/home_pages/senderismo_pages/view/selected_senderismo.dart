import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/route_restaurant.dart';
import 'package:prue/pages/home_pages/senderismo_pages/model/arguments_senderismo.dart';
import 'package:prue/pages/home_pages/senderismo_pages/viewmodel/connection_selected_senderismo.dart';
import 'package:prue/utilities/colors.dart';

class SelectedSenderismo extends StatefulWidget {
  SelectedSenderismo({Key? key}) : super(key: key);

  @override
  State<SelectedSenderismo> createState() => _SelectedSenderismoState();
}

class _SelectedSenderismoState extends State<SelectedSenderismo> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as ArgumentsSenderismo;

    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: ConnectionSelectedSenderismo().getSenderismo(args.id),
        builder:
            (context, AsyncSnapshot<List<ArgumentsSenderismo>> asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return ListView(
                children: listItems(asyncSnapshot.data!, context, width));
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

List<Widget> listItems(
    List<ArgumentsSenderismo> data, BuildContext context, double widht) {
  List<Widget> listItems = [];

  data.forEach((element) {
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
                  element.nombre,
                  expandText: 'Ver más',
                  maxLines: 2,
                  collapseText: 'Ver menos',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      shadows: [
                        Shadow(
                          blurRadius: 18.0,
                          color: Color.fromARGB(255, 27, 116, 116),
                          offset: Offset(0, 1.0),
                        )
                      ]),
                ),
              ),
              TextButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.navigation_rounded),
                      Text('Ir')
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconosAcceso(
              element.cicla, element.moto, element.carro, element.caminando),
        ),
        //Restaurant type

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ExpandableText(
                  element.caracteristica,
                  expandText: 'Ver más',
                  maxLines: 1,
                  collapseText: 'Ver menos',
                ),
              )
            ],
          ),
        ),

        const Divider(
          color: colorVerdeAzulado,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5.0, left: 2.0),
              ),
              const Text('Descripción: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ExpandableText(
                  element.descripcion,
                  expandText: 'Ver más',
                  collapseText: 'Ver menos',
                  maxLines: 3,
                  linkColor: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ],
    ));
  });

  return listItems;
}

//imagenes where we can see two or more images in a carousel
Widget ListaImagenes(List listaImagenes, BuildContext context) {
  String localHost = '';
  if (Platform.isAndroid) {
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

Widget IconosAcceso(int cicla, int moto, int carro, int caminando) {
  IconData iconCicla, iconMoto, iconCarro, iconCaminando;

  if (cicla == 1) {
    iconCicla = Icons.directions_bike_rounded;
  } else {}
  if (moto == 1) {
    iconMoto = Icons.motorcycle_rounded;
  }
  if (carro == 1) {
    iconCarro = FontAwesomeIcons.car;
  }
  if (caminando == 1) {
    iconCaminando = FontAwesomeIcons.personWalking;
  }

  return Row(children: [
    caminando == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.personWalking, color: Colors.blue),
          )
        : const SizedBox(),
    cicla == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.personBiking, color: Colors.blue),
          )
        : const SizedBox(),
    moto == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.motorcycle, color: Colors.blue),
          )
        : const SizedBox(),
    carro == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.car, color: Colors.blue),
          )
        : const SizedBox(),
  ]);
}
