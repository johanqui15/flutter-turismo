import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/history_pages/items/patrimonio/model/patrimonio_arguments.dart';
import 'package:prue/pages/home_pages/history_pages/items/patrimonio/viewmodel/connection_patrimonio.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:prue/utilities/colors.dart';

class PatrimonioPage extends StatefulWidget {
  PatrimonioPage({Key? key}) : super(key: key);

  @override
  State<PatrimonioPage> createState() => _PatrimonioPageState();
}

class _PatrimonioPageState extends State<PatrimonioPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final widht = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      backgroundColor: colorBackgroudScreens,
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
                    padding: EdgeInsets.only(left: widht * 0.02),
                    child: ButtonBack(widht, context),
                  ),
                  Spacer(),
                  Text('Patrimonio Y Cultura',
                      style: TextStyle(
                          fontSize: height * 0.030,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  Spacer(),
                ],
              ),
            ],
          )),
        ),

        //cards
        Padding(
          padding: EdgeInsets.only(top: height * 0.25),
          child: ListView(
            children: [
              DelayedDisplay(
                delay: Duration(milliseconds: 100),
                child: cardCasona(
                    context, 'assets/history/casona.png', height, widht),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                child: cardMonumento(
                    context, 'assets/history/monumento.png', height, widht),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 1000),
                child: cardPatrimonio(
                    context, 'assets/history/patrimonio.png', height, widht),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget cardCasona(BuildContext context, String backgroundImage, double height,
      double widht) {
    final sizeScreen = height + widht;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widht * 0.07, height * 0.02, widht * 0.07, height * 0.00),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          splashColor: Colors.orange,
          child: Stack(children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.fill),
              ),
            ),
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'patrimonio_select',
                arguments: {'tipo': 1, 'title': 'Casonas'});
          },
        ),
      ),
    );
  }

  Widget cardMonumento(BuildContext context, String backgroundImage,
      double height, double widht) {
    final sizeScreen = height + widht;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widht * 0.07, height * 0.02, widht * 0.07, height * 0.00),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          splashColor: Colors.orange,
          child: Stack(children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.cover),
              ),
            ),
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'patrimonio_select',
                arguments: {'tipo': 2, 'title': 'Monumentos'});
          },
        ),
      ),
    );
  }

  Widget cardPatrimonio(BuildContext context, String backgroundImage,
      double height, double widht) {
    final sizeScreen = height + widht;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widht * 0.07, height * 0.02, widht * 0.07, height * 0.00),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          splashColor: Colors.orange,
          child: Stack(children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.cover),
              ),
            ),
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'patrimonio_select',
                arguments: {'tipo': 3, 'title': 'Cultura'});
          },
        ),
      ),
    );
  }
}

class ListaCard extends StatelessWidget {
  const ListaCard({
    Key? key,
    required this.tipo,
    required this.height,
  }) : super(key: key);

  final int tipo;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/history/btn_personajes.png'))),
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.08),
          child: Center(
            child: FutureBuilder(
              future: ConnectionPatrimonio().getPatrimonio(tipo),
              builder: (context,
                  AsyncSnapshot<List<PatrimonioArguments>> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  print(asyncSnapshot.data!);
                  return ListView(
                      children: CardPatrimonio(asyncSnapshot.data!, context));
                } else if (asyncSnapshot.hasError) {
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
        ),
      ),
    );
  }
}

List<Widget> CardPatrimonio(
    List<PatrimonioArguments> data, BuildContext context) {
  List<Widget> items = [];

  data.forEach((element) {
    items.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      image: NetworkImage(element.link_foto),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/gif/loading.gif'),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //name Restaurant
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      element.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Restaurant Location
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/restaurants/ubication.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            //TEXTO DIRECCION
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 5.0,
                                maxWidth: 130.0,
                                minHeight: 30.0,
                                maxHeight: 100.0,
                              ),
                              child: AutoSizeText(
                                element.direccion,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //MENU CAFE
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.date_range_outlined,
                                color: colorVerdeAzulado,
                              ),
                            ),
                          ],
                        ),
                        //TEXTO DEL MENU
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 5.0,
                                  maxWidth: 130.0,
                                  minHeight: 30.0,
                                  maxHeight: 100.0,
                                ),
                                child: ExpandableText(
                                  element.fecha_creacion,
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
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, 'selected_personaje', arguments: {
              'imagen': element.link_foto,
              'nombre': element.nombre,
              'descripcion': element.descripcion,
              'fecha_creacion': element.fecha_creacion,
              'direccion': element.direccion,
              'link_ruta': element.link_ruta
            });
          },
        ),
      ),
    ));
  });
  return items;
}
