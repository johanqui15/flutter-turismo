import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view_model/conection_selected_restaurant.dart';
import 'package:prue/pages/home_pages/restaurant_pages/model/restaurant_arguments.dart';
import 'package:prue/pages/home_pages/restaurant_pages/model/restaurant_selected_json.dart';
import 'package:prue/pages/home_pages/restaurant_pages/model/json_restaurant.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/route_restaurant.dart';
import 'package:prue/utilities/colors.dart';

class SelectedRestaurantePage extends StatefulWidget {
  RestaurantArguments restaurantArguments;

  SelectedRestaurantePage({
    Key? key,
    required this.restaurantArguments,
  }) : super(key: key);

  @override
  State<SelectedRestaurantePage> createState() =>
      _SelectedRestaurantePageState();
}

class _SelectedRestaurantePageState extends State<SelectedRestaurantePage> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: ConectionSelectedRestaurant(widget.restaurantArguments.id_res)
            .getDataSelected(),
        builder: (context,
            AsyncSnapshot<List<RestaurantSelectedJSON>> asyncSnapshot) {
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
    double width, List<RestaurantSelectedJSON> data, BuildContext context) {
  List<Widget> listItems = [];
  String mascota;
  String mascotaTitle;

  data.forEach((element) {
    if (element.mascota == 1) {
      mascota = 'assets/huella-20.png';
      mascotaTitle = 'Se aceptan mascotas';
    } else {
      mascotaTitle = 'No mascotas :(';
      mascota = 'assets/huella-20.png';
    }

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
                    expandText: 'Ver m??s',
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
                  print(element.linkRuta);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              RouteRestaurant(linkRuta: element.linkRuta))));
                },
              )
            ],
          ),
        ),

        //Restaurant Image
        ListaImagenes(element.linkFotoPlato, context),

        //Restaurant type

        Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Row(
            children: [
              Text('Lo que este lugar ofrece',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0))
            ],
          ),
        ),

        //ADDRESS
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Image(
                  image: AssetImage('assets/ubicacion-20.png'),
                  width: 50,
                  height: 50,
                ),
              ),
              const Text('Direcci??n:',
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
                      expandText: 'Ver m??s',
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
                  image: AssetImage('assets/Telefono-20.png'),
                  width: 50,
                  height: 50,
                ),
              ),
              const Text('Tel??fono:',
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
                  image: AssetImage('assets/reloj2-20-20.png'),
                  width: 50,
                  height: 50,
                ),
              ),
              const Text('Horario:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  element.horarioAtencion,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 12, 12, 12), fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: colorVerdeAzulado,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                child: Image(
                  image: AssetImage(mascota),
                  width: 50,
                  height: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                child: Text(mascotaTitle,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0)),
              )
            ],
          ),
        ),
//PLATE NAME

        const Divider(
          color: colorVerdeAzulado,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     children: [
        //       const Padding(
        //         padding: EdgeInsets.only(right: 5.0, left: 2.0),
        //         child: Image(
        //           image: AssetImage('assets/restaurants/diswish.png'),
        //           width: 28,
        //           height: 26,
        //         ),
        //       ),
        //       const Text('Nombre plato:',
        //           style: TextStyle(
        //               color: Colors.black,
        //               fontWeight: FontWeight.w600,
        //               fontSize: 16.0)),
        //       Expanded(
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 8.0),
        //           child: ExpandableText(
        //             element.nombrePlato,
        //             expandText: 'Ver m??s',
        //             collapseText: 'Ver menos',
        //             maxLines: 2,
        //             linkColor: Colors.blue,
        //             style: const TextStyle(
        //                 color: Color.fromARGB(255, 12, 12, 12), fontSize: 16.0),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // const Divider(
        //   color: colorVerdeAzulado,
        // ),

        const Text('Descripci??n',
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
                    element.descripcionPlato,
                    expandText: 'Ver m??s',
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
