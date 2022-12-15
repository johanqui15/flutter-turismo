import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'package:prue/pages/home_pages/servicios/model/service_arguments.dart';
import 'package:prue/pages/home_pages/servicios/model/service_selected_json.dart';
import 'package:prue/pages/home_pages/servicios/view/route_service.dart';
import 'package:prue/pages/home_pages/servicios/view_model/conection_services.dart';
import 'package:prue/pages/home_pages/servicios/view_model/conection_selected_service.dart';
import 'package:prue/utilities/colors.dart';

class SelectedServicePage extends StatefulWidget {
  ServiceArguments serviceArguments;

  SelectedServicePage({
    Key? key,
    required this.serviceArguments,
  }) : super(key: key);

  @override
  State<SelectedServicePage> createState() => _SelectedServicePageState();
}

class _SelectedServicePageState extends State<SelectedServicePage> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: ConectionSelectedService(widget.serviceArguments.id)
            .getDataSelected(),
        builder:
            (context, AsyncSnapshot<List<ServiceSelectedJSON>> asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return ListView(
                children: listItems(width, asyncSnapshot.data!, context));
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}

List<Widget> listItems(
    double width, List<ServiceSelectedJSON> data, BuildContext context) {
  List<Widget> listItems = [];

  data.forEach((element) {
    listItems.add(Column(
      children: [
        //Restaurant Name
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonBack(width, context),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxHeight: 100.0,
                      minHeight: 5.0,
                      maxWidth: 100.0,
                      minWidth: 5.0),
                  child: ExpandableText(
                    element.nombre,
                    expandText: 'Ver más',
                    collapseText: 'Ver menos',
                    maxLines: 2,
                    linkColor: Colors.blue,
                    style: const TextStyle(
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
              ),
              TextButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.navigation_rounded),
                      Text('Ir')
                    ]),
                onPressed: () {
                  print(element.link);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              RouteService(link: element.link))));
                },
              )
            ],
          ),
        ),

        //Restaurant Image
        ListaImagenes(element.urlImagenes, context),

        //Restaurant type

        //ADDRESS
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: colorVerdeAzulado,
                  )),
              const Text('Dirección:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxHeight: 100.0,
                        minHeight: 15.0,
                        maxWidth: 100.0,
                        minWidth: 5.0),
                    child: ExpandableText(
                      element.direccion,
                      expandText: 'Ver más',
                      collapseText: 'Ver menos',
                      maxLines: 2,
                      linkColor: Colors.blue,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 12, 12, 12),
                          fontSize: 16.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
//TELEFONO
        const Divider(
          color: colorVerdeAzulado,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0, left: 3.0),
                child: Image(
                  image: AssetImage('assets/restaurants/telephone.png'),
                  width: 20,
                  height: 19,
                ),
              ),
              const Text('Teléfono:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  element.telefono,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 12, 12, 12), fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),

//PLATE NAME

        const Divider(
          color: colorVerdeAzulado,
        ),

        const Divider(
          color: colorVerdeAzulado,
        ),

        const Text('Descripción',
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
                    element.description,
                    expandText: 'Ver más',
                    collapseText: 'Ver menos',
                    maxLines: 2,
                    linkColor: Colors.blue,
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
    // localHost = 'https://api.destinofusagasuga.gov.co/';
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

// Padding(
//           padding: EdgeInsets.only(top: 58.0, bottom: 58.0),
//           child: InkWell(
//             child:  CarouselSlider(
//               items: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: colorBackgroudScreens,
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           repeat: ImageRepeat.noRepeat,

//                           image: NetworkImage(item)),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 7,
//                           offset:
//                               const Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: colorBackgroudScreens,
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           repeat: ImageRepeat.noRepeat,

//                           image: NetworkImage(item)),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 7,
//                           offset:
//                               const Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ].toList(),
//               options: CarouselOptions(
//                 height: 260.0,
//                 autoPlay: true,
//               )),

//             onTap: () async {
//               //Show image in dialog when we tap  the picture
//               await showDialog(
//                   context: context,
//                   builder: (_) => ImageDialog(item));
//             },
//           ),
//         );
}

//Show image in dialog when we tap  the picture
Widget ImageDialog(String linkFoto) {
  return Dialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    child: Container(
      height: 350,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(linkFoto), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(30)),
    ),
    insetAnimationCurve: Curves.decelerate,
  );
}

Container ButtonBack(double width, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(181, 82, 80, 80),
          blurRadius: 20,
          // Shadow position
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(right: width * 0.02),
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
  );
}
