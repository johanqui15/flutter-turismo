import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/history_pages/items/patrimonio/model/patrimonio_arguments.dart';
import 'package:prue/pages/home_pages/history_pages/items/patrimonio/viewmodel/connection_patrimonio.dart';
import 'package:prue/utilities/colors.dart';

class PatrimonioSelectPage extends StatefulWidget {
  PatrimonioSelectPage({Key? key}) : super(key: key);

  @override
  State<PatrimonioSelectPage> createState() => _PatrimonioSelectPageState();
}

class _PatrimonioSelectPageState extends State<PatrimonioSelectPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;

    final width = queryData.size.width;
    return Scaffold(
      backgroundColor: colorBackgroudScreens,
      // appBar: AppBar(

      //   title: const Text('Café'),
      //   backgroundColor: colorFondoImagenes,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/home/fondo_tres.png'),
                    fit: BoxFit.cover)),
          ),
          //TEXT TITLE RUTAS DEL CAFE
          Padding(
            padding: EdgeInsets.only(top: height * 0.06),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  arguments['title'],
                  style: TextStyle(
                      fontSize: height * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            )),
          ),

          //BUTTON BACK
          Padding(
            padding: EdgeInsets.only(top: height * 0.09),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: height * 0.08),
            child: const Divider(
              height: 100,
              thickness: 1,
              color: Color.fromARGB(195, 255, 255, 255),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.08),
            child: Divider(
              endIndent: width * 0.35,
              indent: width * 0.35,
              height: 100,
              thickness: 5,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),

          //LIST CARD COFFE
          Padding(
            padding: EdgeInsets.only(top: height * 0.25),
            child: Center(
                child: ListaCard(tipo: arguments['tipo'], height: height)),
          ),
        ],
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
