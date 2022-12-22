import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'package:prue/pages/home_pages/servicios/model/json_service.dart';
import 'package:prue/pages/home_pages/servicios/model/service_arguments.dart';
import 'package:prue/pages/home_pages/servicios/model/service_selected_json.dart';
import 'package:prue/pages/home_pages/servicios/model/tipo_service.dart';
import 'package:prue/pages/home_pages/servicios/view/selected_service_page.dart';
import 'package:prue/pages/home_pages/servicios/view_model/conection_selected_service.dart';
import 'package:prue/pages/home_pages/servicios/view_model/conection_services.dart';
import 'package:prue/pages/home_pages/servicios/view_model/connection_tipo_service.dart';
import 'package:prue/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

//CLASE DE MOSTRAR TODOS LOS servicios
class MainServicePage extends StatefulWidget {
  MainServicePage({Key? key}) : super(key: key);

  @override
  State<MainServicePage> createState() => _MainServicePageState();
}

class _MainServicePageState extends State<MainServicePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetToken();
  }

  var token;
  Future<void> GetToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final widht = queryData.size.width;
    return DefaultTabController(
      length: 5,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/home/fondo_tres.png'),
                    fit: BoxFit.cover)),
          ),
          Scaffold(
            // extendBodyBehindAppBar: true,
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              title: const Text('Otros servicios'),
              bottom: const TabBar(
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: 'Compras',
                    ),
                    Tab(
                      text: 'Entretenimiento',
                    ),
                    Tab(
                      text: 'Finanzas',
                    ),
                    Tab(
                      text: 'Oficinas Públicas',
                    ),
                    Tab(
                      text: 'Transporte',
                    )
                  ]),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: height * 0.08),
              child: TabBarView(
                children: [
                  Center(
                    child: FutureBuilder(
                      //10.0.2.2:8000
                      //127.0.0.1:8000
                      future: GetService().getData(

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/1'),
                          'https://api.destinofusagasuga.gov.co/api/auth/otrosservicios/rest/type/1'),
                      builder: (context,
                          AsyncSnapshot<List<ServiceStruct>> asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          return ListView(
                              children: CardAll(
                                  asyncSnapshot.data!, context, height, widht));
                        }
                        if (asyncSnapshot.hasError) {
                          return const Text(
                              'No se logró cargar la  informaciónón. 🙁');
                        } else {
                          print('lakshdkjahskdjhasd');
                          return const Text(
                              'Sesión caducada, vuelve a iniciar sesión. 😉');
                        }

                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                          ),
                        );
                      },
                    ),
                  ),

                  //ULTIMO TIPO DE RESTAURANTE
                  Center(
                    child: FutureBuilder(
                      //10.0.2.2:8000
                      //127.0.0.1:8000
                      future: GetService().getData(

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/1'),
                          'https://api.destinofusagasuga.gov.co/api/auth/otrosservicios/rest/type/2'),
                      builder: (context,
                          AsyncSnapshot<List<ServiceStruct>> asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          return ListView(
                              children: CardAll(
                                  asyncSnapshot.data!, context, height, widht));
                        }
                        if (asyncSnapshot.hasError) {
                          return const Text(
                              'No se logró cargar la  informaciónón. 🙁');
                        } else {
                          print('lakshdkjahskdjhasd');
                          return const Text(
                              'Sesión caducada, vuelve a iniciar sesión. 😉');
                        }

                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: FutureBuilder(
                      //10.0.2.2:8000
                      //127.0.0.1:8000
                      future: GetService().getData(

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/1'),
                          'https://api.destinofusagasuga.gov.co/api/auth/otrosservicios/rest/type/3'),
                      builder: (context,
                          AsyncSnapshot<List<ServiceStruct>> asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          return ListView(
                              children: CardAll(
                                  asyncSnapshot.data!, context, height, widht));
                        }
                        if (asyncSnapshot.hasError) {
                          return const Text(
                              'No se logró cargar la  informaciónón. 🙁');
                        } else {
                          print('lakshdkjahskdjhasd');
                          return const Text(
                              'Sesión caducada, vuelve a iniciar sesión. 😉');
                        }

                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: FutureBuilder(
                      //10.0.2.2:8000
                      //127.0.0.1:8000
                      future: GetService().getData(

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/1'),
                          'https://api.destinofusagasuga.gov.co/api/auth/otrosservicios/rest/type/4'),
                      builder: (context,
                          AsyncSnapshot<List<ServiceStruct>> asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          return ListView(
                              children: CardAll(
                                  asyncSnapshot.data!, context, height, widht));
                        }
                        if (asyncSnapshot.hasError) {
                          return const Text(
                              'No se logró cargar la  informaciónón. 🙁');
                        } else {
                          print('lakshdkjahskdjhasd');
                          return const Text(
                              'Sesión caducada, vuelve a iniciar sesión. 😉');
                        }

                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                          ),
                        );
                      },
                    ),
                  ),

                  Center(
                    child: FutureBuilder(
                      //10.0.2.2:8000
                      //127.0.0.1:8000
                      future: GetService().getData(

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/5'),
                          'https://api.destinofusagasuga.gov.co/api/auth/otrosservicios/rest/type/5'),
                      builder: (context,
                          AsyncSnapshot<List<ServiceStruct>> asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          return ListView(
                              children: CardAll(
                                  asyncSnapshot.data!, context, height, widht));
                        } else if (asyncSnapshot.hasError) {
                          return const Text(
                              'No se logró cargar la  informaciónón. 🙁');
                        } else {
                          print('lakshdkjahskdjhasd');
                          return const Text(
                              'Sesión caducada, vuelve a iniciar sesión. ');
                        }

                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getTipoService(BuildContext context) {
  List<Widget> hola = [];

  return FutureBuilder(
      future: ConnectionTipoService().getTipoService(),
      builder: ((context, AsyncSnapshot<List<TipoService>> snapshot) {
        if (snapshot.hasData) {
          for (var item in snapshot.data!) {
            //hola.add(TipoRestaurante(item['id_tipo_res'] ,item['nombre'], item['tipo_res']));
            return ListView(
              children: [Text(item.nombre)],
            );
          }
        } else {
          print('no hay nada');
        }

        return Text('nada');
      })).toString();
}

String mostrar(List lista) {
  List data;
  String imagen = '';
  data = lista;
  data.forEach((element) {
    imagen = element;
  });

  return imagen;
}

//Show all restaurants
List<Widget> CardAll(List<ServiceStruct> data, BuildContext context,
    double height, double width) {
  List<Widget> items = [];
  //pets false

  data.forEach((element) {
//1 PARA ACTIVO 2 PARA INACTIVO

    items.add(
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: InkWell(
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.2,
                      width: width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            image: NetworkImage(mostrar(element.urlImagenes)),
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/gif/loading.gif'),
                          ),
                        ),
                      ),
                    ),

                    //restaurant Name
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Restaurant Location

                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/restaurants/telephone.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxHeight: 100.0,
                                        minHeight: 5.0,
                                        maxWidth: 100.0,
                                        minWidth: 5.0),
                                    child: ExpandableText(
                                      element.telefono,
                                      expandText: 'Ver más',
                                      collapseText: 'Ver menos',
                                      maxLines: 2,
                                      animation: true,
                                      linkColor: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        //Diswish Restaurant

                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/reloj-20.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: 5.0,
                                      maxWidth: 130.0,
                                      minHeight: 5.0,
                                      maxHeight: 100.0),
                                  child: ExpandableText(
                                    element.horario,
                                    expandText: 'Ver más',
                                    collapseText: 'Ver menos',
                                    maxLines: 2,
                                    animation: true,
                                    linkColor: Colors.blue,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        //place Text('Corregimiento aguadita'),
                        //                     Text('Se aceptan mascotas'),
                        //  Icon(Icons.location_on, color: Colors.blueAccent,),
                        //                             Icon(Icons.food_bank_outlined, color: Colors.blue,),
                        //                             Icon(Icons.pets, color: Colors.blue,),
                      ],
                    )),
                  ]),
            ),
            onTap: () {
              //SEND ID_RES TO SELECTED RESTAURANT PAGE
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => SelectedServicePage(
                          serviceArguments: ServiceArguments(element.id)))));
            },
          ),
        ),
      ),
    );
  });

  return items;
}

Widget showImage(List lista) {
  try {
    if (lista.isNotEmpty) {
      print('LA LISTAAAA $lista');
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: NetworkImage(mostrar(lista)),
          placeholder: AssetImage('assets/gif/loading.gif'),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          image: AssetImage('assets/restaurants/image_restaurant.png'),
          placeholder: AssetImage('assets/gif/loading.gif'),
        ),
      );
    }
  } catch (e) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage(
        image: AssetImage('assets/restaurants/image_restaurant.png'),
        placeholder: AssetImage('assets/gif/loading.gif'),
      ),
    );
  }
}
