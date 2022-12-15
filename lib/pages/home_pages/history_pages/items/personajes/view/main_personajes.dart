import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/history_pages/items/personajes/model/arguments_personaje.dart';
import 'package:prue/pages/home_pages/history_pages/items/personajes/view/selected_personaje.dart';
import 'package:prue/pages/home_pages/history_pages/items/personajes/viewmodel/conection_personaje.dart';
import 'package:prue/pages/home_pages/home_page.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainPersonajes extends StatefulWidget {
  const MainPersonajes({Key? key}) : super(key: key);

  @override
  State<MainPersonajes> createState() => _MainPersonajesState();
}

class _MainPersonajesState extends State<MainPersonajes> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    final sizeScreen = width + height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/home/fondo_tres.png'),
                  fit: BoxFit.cover)),
        ),
        //TEXTO TITULO
        Padding(
          padding: EdgeInsets.only(top: height * 0.06),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.02),
                      child: ButtonBack(width, context),
                    ),
                    Spacer(),
                    Text(
                      'Personajes Historicos',
                      style: TextStyle(
                          fontSize: height * 0.030,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
        //cards

        Padding(
          padding: EdgeInsets.only(top: height * 0.25),
          child: Center(
            child: FutureBuilder(
              future: ConnectionPersonaje().getPersonajes(),
              builder:
                  (context, AsyncSnapshot<List<ArgumentsPersonaje>> asyncSnap) {
                if (asyncSnap.hasData) {
                  if (asyncSnap.data != null) {
                    return ListView(
                        scrollDirection: Axis.vertical,
                        children: cardPersonaje(
                            context, asyncSnap.data!, width, height));
                  } else {
                    print('Nulo');
                    return Text("Nullo");
                  }

                  //cardPersonaje(context, asyncSnap.data!);
                } else if (asyncSnap.hasError) {
                  return const Text('No se logró cargar la  informaciónón. 🙁');
                }

                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ),
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  List<Widget> cardPersonaje(BuildContext context,
      List<ArgumentsPersonaje> data, double widht, double height) {
    List<Widget> lista = [];
    List list = [];
    data.forEach(
      (element) {
        list.add(ArgumentsPersonaje(element.id, element.nombre,
            element.descripcion, element.imagen, element.fecha_nacimiento));
        lista.add(
          InkWell(
            child: Card(
              elevation: 0,
              child: Center(
                child: Row(
                  children: [
                    Container(
                      height: height * 0.2,
                      width: widht * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            image: NetworkImage(element.imagen),
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/gif/loading.gif'),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      verticalDirection: VerticalDirection.down,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 5.0,
                            maxWidth: 130.0,
                            minHeight: 30.0,
                            maxHeight: 100.0,
                          ),
                          child: ExpandableText(
                            element.nombre,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            expandText: 'Ver más',
                            collapseText: 'Ver menos',
                            maxLines: 2,
                            animation: true,
                            linkColor: Colors.blue,
                          ),
                          // AutoSizeText(
                          //   element.servicios,
                          //   style: TextStyle(fontSize: 14.0),
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(element.fecha_nacimiento),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              print(element.nombre);
              Navigator.pushNamed(context, 'selected_personaje', arguments: {
                'id': element.id,
                'imagen': element.imagen,
                'nombre': element.nombre,
                'descripcion': element.descripcion,
                'fecha_nacimiento': element.fecha_nacimiento
              });
            },
          ),
        );
      },
    );

    return lista;
  }
}
