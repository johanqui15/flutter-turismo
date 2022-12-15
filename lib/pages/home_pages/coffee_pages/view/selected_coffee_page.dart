import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prue/pages/home_pages/coffee_pages/model/coffe_selected_argument.dart';
import 'package:prue/pages/home_pages/coffee_pages/model/coffee_arguments.dart';
import 'package:prue/pages/home_pages/coffee_pages/model/services_coffe.dart';
import 'package:prue/pages/home_pages/coffee_pages/view_model/conection_selected_coffe.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/route_restaurant.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:prue/utilities/colors.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedCoffePage extends StatefulWidget {
  CoffeSelectedArgument coffeSelectedArgument;
  SelectedCoffePage({
    Key? key,
    required this.coffeSelectedArgument,
  }) : super(
          key: key,
        );

  @override
  State<SelectedCoffePage> createState() => _SelectedCoffePageState();
}

class _SelectedCoffePageState extends State<SelectedCoffePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: ConectionSelectedCoffe(widget.coffeSelectedArgument.id_cafe)
            .getDataCoffeSelected(),
        builder: (context, AsyncSnapshot<List<CoffeeArguments>> asyncSnapshot) {
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

List<Widget> listItems(List<CoffeeArguments> data, BuildContext context) {
  List<Widget> listItems = [];
  String banio,
      baniotitulo,
      musica,
      musicatitulo,
      wifi,
      wifititulo,
      pago,
      pagotitulo,
      otroservicio,
      otroserviciotitulo,
      ninguno,
      ningunotitulo;
  data.forEach((element) {
    //VALIDACION QUE RED SOCIAL ES
    if (element.banio == 1) {
      banio = 'assets/baño-20.png';
      baniotitulo = 'servicio de baño';
    } else {
      banio = 'assets/baño-20.png';
      baniotitulo = 'no hay servicio de baño';
    }
    if (element.zona_wifi == 1) {
      wifi = 'assets/wifi-20.png';
      wifititulo = 'servicio de wifi';
    } else {
      wifi = 'assets/wifi-20.png';
      wifititulo = 'no hay servicio de wifi';
    }
    if (element.musica_vivo == 1) {
      musica = 'assets/musica-20.png';
      musicatitulo = 'servicio de musica en vivo';
    } else {
      musica = 'assets/musica-20.png';
      musicatitulo = 'no hay servicio de musica en vivo';
    }
    if (element.pagos_digitales == 1) {
      pago = 'assets/pagos-20.png';
      pagotitulo = 'servicio de pago digital';
    } else {
      pago = 'assets/pagos-20.png';
      pagotitulo = 'no hay servicio de pago digital';
    }

    listItems.add(Column(
      children: [
        //cafe name
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                element.nombre,
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
              // TextButton(
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: const [
              //         Icon(Icons.navigation_rounded),
              //         Text('Ir al café')
              //       ]),
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: ((context) => RouteRestaurant(linkRuta: element.))));
              //   },
              // )
            ],
          ),
        ),
        //Restaurant Image
        ListaImagenes(element.imagen, context),

        //Restaurant type

//BOTONES SERVICIOS DISPOMNIBNLES

//ICON FACEBOOK

        ButtonRedesSociales(element.red_social),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                element.nombre,
                style: const TextStyle(
                    color: Color.fromARGB(255, 141, 136, 136),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0),
              ),
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
              const Text('Dirección:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ExpandableText(
                    element.direccion,
                    expandText: 'Ver más',
                    collapseText: 'Ver menos',
                    maxLines: 2,
                    linkColor: Colors.blue,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12), fontSize: 16.0),
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
              Padding(
                padding: EdgeInsets.only(right: 8.0, left: 3.0),
                child: Image(
                  image: AssetImage('assets/reloj2-20-20.png'),
                  width: 50,
                  height: 50,
                ),
              ),
              const Text('Horario de atención:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ExpandableText(
                    element.horario_atencion,
                    expandText: 'Ver más',
                    collapseText: 'Ver menos',
                    maxLines: 2,
                    linkColor: Colors.blue,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12), fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),

//PLATE NAME

        const Divider(
          color: colorVerdeAzulado,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0, left: 3.0),
                child: Image(
                  image: AssetImage('assets/cafe-20.png'),
                  width: 50,
                  height: 50,
                ),
              ),
              const Text('Origen de cafe:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ExpandableText(
                    element.origen_cafe,
                    expandText: 'Ver más',
                    collapseText: 'Ver menos',
                    maxLines: 2,
                    linkColor: Colors.blue,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12), fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        //wifi

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
                  image: AssetImage(banio),
                  width: 50,
                  height: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                child: Text(baniotitulo,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0)),
              )
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
                  image: AssetImage(wifi),
                  width: 50,
                  height: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                child: Text(wifititulo,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0)),
              )
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
                  image: AssetImage(musica),
                  width: 50,
                  height: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                child: Text(musicatitulo,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0)),
              )
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
                  image: AssetImage(pago),
                  width: 50,
                  height: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                child: Text(pagotitulo,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0)),
              )
            ],
          ),
        ),

        const Divider(
          color: colorVerdeAzulado,
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
                    element.historia,
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

Widget ButtonRedesSociales(List redes) {
  late FaIcon iconoRedSocial = FaIcon(
    FontAwesomeIcons.android,
  );
  List<Widget> listaRedes = [];
  redes.forEach((red) {
    print(red);
    if (red.contains('Facebook') || red.contains('facebook')) {
      iconoRedSocial = const FaIcon(FontAwesomeIcons.facebook);
    } else if (red.contains('whatsapp') || red.contains('Whatsapp')) {
      iconoRedSocial = const FaIcon(
        FontAwesomeIcons.whatsapp,
        color: Colors.green,
      );
    } else if (red.contains('instagram') || red.contains('Instagram')) {
      iconoRedSocial = const FaIcon(FontAwesomeIcons.instagram);
    } else if (red.contains('tiktok') || red.contains('Tiktok')) {
      iconoRedSocial = const FaIcon(
        FontAwesomeIcons.tiktok,
        color: Colors.black,
      );
    }

    listaRedes.add(TextButton(
        onPressed: () async {
          final Uri uri = Uri.parse(red);
          if (Platform.isAndroid) {
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          }
        },
        child: iconoRedSocial));
    print(listaRedes);
  });
  return Row(
    children: listaRedes,
  );
}

//imagenes where we can see two or more images in a carousel
Widget ListaImagenes(List listaImagenes, BuildContext context) {
  String localHost = '';
  if (Platform.isAndroid) {
    localHost = 'https://api.destinofusagasuga.gov.co';
    // localHost = 'https://api.destinofusagasuga.gov.co';
  } else if (Platform.isIOS) {
    localHost = 'https://api.destinofusagasuga.gov.co';
    // localHost = 'https://api.destinofusagasuga.gov.co';
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

Widget bano() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('assets/cicla.jpeg'))),
  );
}
