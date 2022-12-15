import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'package:prue/pages/home_pages/restaurant_pages/view/route_restaurant.dart';
import 'package:prue/utilities/colors.dart';

class SelectedPersonaje extends StatefulWidget {
  SelectedPersonaje({Key? key}) : super(key: key);

  @override
  State<SelectedPersonaje> createState() => _SelectedPersonajeState();
}

class _SelectedPersonajeState extends State<SelectedPersonaje> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    MediaQueryData queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    final sizeScreen = width + height;

    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(arguments['imagen']),
                    fit: BoxFit.cover)),
            //CERRAR EL CONTAINNERRRRRRRRRR
            child: Center(
              child: Column(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 82, 80, 80),
                            blurRadius: 20,
                            // Shadow position
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 82, 80, 80),
                                blurRadius: 20,
                                // Shadow position
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: colorVerdeAzulado,
                            child: IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_left_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      buttonNavigation(
                          arguments['link_ruta'] != null
                              ? arguments['link_ruta']
                              : '',
                          width),
                    ],
                  ),
                  const Spacer(),
                  const Spacer(),
                  SizedBox(
                    height: height * 0.5,
                    child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              arguments['imagen'],
                              fit: BoxFit.cover,
                            ))),
                  ),
                  Padding(
                    padding: EdgeInsets.all(sizeScreen * 0.01),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(168, 14, 13, 47),
                        borderRadius: BorderRadius.all(Radius.circular(13.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(sizeScreen * 0.02),
                        child: Row(children: [
                          Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 5.0,
                                  maxWidth: width * 0.8,
                                  minHeight: 30.0,
                                  maxHeight: 100.0,
                                ),
                                child: AutoSizeText(
                                  arguments['nombre'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                  minFontSize: 16,
                                ),
                              ),
                              Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 5.0,
                                    maxWidth: width * 0.8,
                                    minHeight: 30.0,
                                    maxHeight: height * 1,
                                  ),
                                  child: ExpandableText(
                                    arguments['descripcion'],
                                    style: TextStyle(color: Colors.white),
                                    expandText: 'Ver más',
                                    collapseText: 'Ver menos',
                                    maxLines: 3,
                                    animation: true,
                                    linkColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ))
      ]),
    );
  }

  Widget buttonNavigation(String link_ruta, double width) {
    if (link_ruta != '') {
      print(link_ruta);
      return Padding(
        padding: EdgeInsets.only(right: width * 0.03),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 82, 80, 80),
                blurRadius: 20,
                // Shadow position
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: Icon(
                Icons.navigation_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            RouteRestaurant(linkRuta: link_ruta))));
              },
            ),
          ),
        ),
      );
    } else {
      print('vaciooooooo');
    }
    return SizedBox();
  }
}
