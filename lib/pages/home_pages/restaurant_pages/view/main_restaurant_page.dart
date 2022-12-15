import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/restaurant_pages/model/restaurant_arguments.dart';
import 'package:prue/pages/home_pages/restaurant_pages/model/tipo_restaurante.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view_model/conection_restaurants.dart';
import 'package:prue/pages/home_pages/restaurant_pages/model/json_restaurant.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view_model/connection_tipo_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLASE DE MOSTRAR TODOS LOS RESTAURANTES
class MainRestaurantPage extends StatefulWidget {
  MainRestaurantPage({Key? key}) : super(key: key);

  @override
  State<MainRestaurantPage> createState() => _MainRestaurantPageState();
}

class _MainRestaurantPageState extends State<MainRestaurantPage> {
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
      length: 3,
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
              title: const Text('Restaurantes'),
              actions: [
                TextButton(
                    child: const Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'video_gastronomia');
                    }),
              ],
              bottom: const TabBar(indicatorColor: Colors.white, tabs: [
                Tab(
                  text: 'Todos',
                ),
                Tab(
                  text: 'Comida tipica',
                ),
                Tab(
                  text: 'Comida rapida',
                ),
              ]),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: height * 0.08),
              child: TabBarView(
                children: [
                  Center(
                    child: FutureBuilder(
                      future: GetRestaurant().getData(
                          //https://api.destinofusagasuga.gov.co

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/mostrarRestaurante'),
                          'https://api.destinofusagasuga.gov.co/api/auth/restaurante/mostrarRestaurante'),
                      builder: (context,
                          AsyncSnapshot<List<RestaurantStruct>> asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          return ListView(
                              children: CardAll(
                                  asyncSnapshot.data!, context, height, widht));
                        } else if (asyncSnapshot.hasError) {
                          return const Text(
                              'No se logró cargar la información. 🙁');
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
                      future: GetRestaurant().getData(

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/1'),
                          'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/1'),
                      builder: (context,
                          AsyncSnapshot<List<RestaurantStruct>> asyncSnapshot) {
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
                      future: GetRestaurant().getData(

                          // 'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/5'),
                          'https://api.destinofusagasuga.gov.co/api/auth/restaurante/rest/type/2'),
                      builder: (context,
                          AsyncSnapshot<List<RestaurantStruct>> asyncSnapshot) {
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

String getTipoRestaurante(BuildContext context) {
  List<Widget> hola = [];

  return FutureBuilder(
      future: ConnectionTipoRestaurante().getTipoRest(),
      builder: ((context, AsyncSnapshot<List<TipoRestaurante>> snapshot) {
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
List<Widget> CardAll(List<RestaurantStruct> data, BuildContext context,
    double height, double width) {
  List<Widget> items = [];
  //pets false
  String horarioAtencion;
  String mascota = 'assets/restaurants/mascota.png';
  String mascotaTitle = 'ola';

  data.forEach((element) {
//1 PARA ACTIVO 2 PARA INACTIVO
    if (element.mascota == 1) {
      mascota = 'assets/restaurants/mascota.png';
      mascotaTitle = 'Se aceptan mascotas';
      //print('=========!!!!!!!!!!!!!!!!!!!! mascotita=======${element.mascota}');
    } else if (element.mascota == 2) {
      mascotaTitle = 'No se aceptan :(';
      mascota = 'assets/restaurants/no_mascota.png';
      //print(
      //  '=========!!!!!!!!!!!!!!!!!!!! mastotita falsa=======${element.mascota}');
    }

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
                            image: NetworkImage(
                                mostrar(element.urlImageRestaurante)),
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

                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          SelectedRestaurantePage(
                                              restaurantArguments:
                                                  RestaurantArguments(
                                                      element.idRes)))));
                            },
                            child: Text('Ver informacion')),
                        // Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Container(
                        //           width: 30,
                        //           height: 30,
                        //           decoration: const BoxDecoration(
                        //             image: DecorationImage(
                        //               image: AssetImage(
                        //                   'assets/restaurants/diswish.png'),
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 4.0),
                        //           child: ConstrainedBox(
                        //             constraints: const BoxConstraints(
                        //                 maxHeight: 100.0,
                        //                 minHeight: 5.0,
                        //                 maxWidth: 100.0,
                        //                 minWidth: 5.0),
                        //             child: ExpandableText(
                        //               element.platoPrincipal,
                        //               expandText: 'Ver más',
                        //               collapseText: 'Ver menos',
                        //               maxLines: 2,
                        //               animation: true,
                        //               linkColor: Colors.blue,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // ),
                        //Diswish Restaurant

                        //Pets
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 10.0),
                        //   child: Row(
                        //     children: [
                        //       Column(
                        //         children: [
                        //           Container(
                        //             width: 30,
                        //             height: 30,
                        //             decoration: BoxDecoration(
                        //               image: DecorationImage(
                        //                 image: AssetImage(mascota),
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(mascotaTitle),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Container(
                        //           width: 30,
                        //           height: 30,
                        //           decoration: const BoxDecoration(
                        //             image: DecorationImage(
                        //               image: AssetImage('assets/reloj-20.png'),
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         ConstrainedBox(
                        //           constraints: const BoxConstraints(
                        //               minWidth: 5.0,
                        //               maxWidth: 130.0,
                        //               minHeight: 5.0,
                        //               maxHeight: 100.0),
                        //           child: ExpandableText(
                        //             element.horario_atencion,
                        //             expandText: 'Ver más',
                        //             collapseText: 'Ver menos',
                        //             maxLines: 2,
                        //             animation: true,
                        //             linkColor: Colors.blue,
                        //           ),
                        //         ),
                        //       ],
                        //     )
                        //   ],
                        // ),
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
                      builder: ((context) => SelectedRestaurantePage(
                          restaurantArguments:
                              RestaurantArguments(element.idRes)))));
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
