import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/viewmodel/connection_weather.dart';
import 'package:prue/pages/login_pages/model/arguments_logo.dart';
import 'package:prue/pages/login_pages/view_model/conection_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/colors.dart';

class HomePage extends StatefulWidget {
  String token;

  HomePage({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //INICIALIZAMOS LOS METODOS PARA GUARDAR EL TOKEN RECIBIDO DEL LOGIN
    SaveTokenShared(widget.token);
  }

  Future<void> SaveTokenShared(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //GUARDAMOS EL TOKEN CON LA KEY TOKEN
    await prefs.setString('token', token);
    //guardamos estado de sesión
    await prefs.setBool('estado_sesion', true);

    print('para guard==== $token');
    print('SESIONNNNNNN ----------- true');
    print('hola mundo');
  }

  var getToken;
  var getStatusLogin;
  Future<void> ShowToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getToken = await prefs.getString('token');
    getStatusLogin = await prefs.getBool('estado_sesion');
    print('el guardadooooo==== $getToken');
    print('SESIONNNNNNN ----------- $getStatusLogin');

    //pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final widht = queryData.size.width;
    final size = MediaQuery.of(context).size;
    //NO BACK ACTIVITY
    return WillPopScope(
      onWillPop: () async {
        final pop = await ShowDialog();
        return pop ?? false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(244, 244, 242, 1),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/home/fondo_tres.png'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: height * 0.09),
                    child: Text(
                      '¿Qué quieres hacer hoy?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: height * 0.01),
                    child: FutureBuilder(
                      future: ConnectionWeather().getWeather(),
                      builder: (context, AsyncSnapshot<double> asyncSnapshot) {
                        if (asyncSnapshot.hasError) {
                          return const Text('');
                        }
                        if (asyncSnapshot.hasData) {
                          return Column(
                            children: [
                              Text('Temperatura en Fusagasugá',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                              Text('${asyncSnapshot.data!}°C',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22))
                            ],
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(height * 0.07),
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisSpacing: 18.0,
                        mainAxisSpacing: 20.0,
                        crossAxisCount: 2,
                        children: [
                          cardGastronomia(context),
                          cardTurismo(context),
                          cardHistory(context),
                          cardCoffee(context),
                          cardServicios(context),
                          // cardHamburguesa(context),
                          cardMasFusa(context),

                          SizedBox(
                            height: 1,
                          )
                          //cardTrekking(context)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: SizedBox(height: 50, width: 800, child: imagenLogo(context)),
        ),
      ),
    );
  }

  Future<void> DeleteSessionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //GUARDAMOS EL TOKEN CON LA KEY TOKEN

    //guardamos estado de sesión
    await prefs.remove('estado_sesion');
    await prefs.remove('token');

    print('SE ELIMINAROOONNN ');
  }

//DIALOG EXIT APPLICATION

  Future<bool?> ShowDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('¿Quieres salir de la aplicación?'),
            actions: [
              TextButton(
                  onPressed: () {
                    DeleteSessionStatus();
                    Navigator.pop(context, true);
                  },
                  child: const Text('Si')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No')),
            ],
          ));
}

Widget imagenLogo(BuildContext context) {
  return FutureBuilder(
    future: ConectionLogo().getLogo(),
    builder: (context, AsyncSnapshot<ArgumentsLogo> asyncSnapshot) {
      if (asyncSnapshot.hasData) {
        return SafeArea(
          child: SizedBox(
            width: 25.0,
            child: Container(
              color: colorBackgroudScreens,
              child: Image(
                image: NetworkImage(asyncSnapshot.data!.link_logo),
                width: 800,
                height: 50,
              ),
            ),
          ),
        );
      } else if (asyncSnapshot.hasError) {
        return SafeArea(
          child: SizedBox(
            width: 25.0,
            child: Container(
              color: colorBackgroudScreens,
              child: Image(
                image: AssetImage('assets/logo_alcaldia.png'),
                width: 15,
                height: 100,
              ),
            ),
          ),
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

Widget cardCoffee(BuildContext context) {
  return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: const Color.fromARGB(163, 230, 212, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        child: Container(
          width: double.infinity,

          child: const Image(
            image: AssetImage('assets/coffee/AMANTES DEL CAFE-11.png'),
            width: 585,
            height: 130,
          ),
          //Text(
          //  'Turismo',
          //  style: TextStyle(fontWeight: FontWeight.bold),
          //),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'home_coffee_page');
        },
      ));
}

Widget cardTurismo(BuildContext context) {
  return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: Color.fromARGB(163, 230, 212, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        child: Container(
          child: Image(
            image: AssetImage(
                'assets/SERVICIOS TURISTICOS/SERVICIOS TURÍSTICOS-11.png'),
            width: 585,
            height: 130,
          ),
          //Text(
          //  'Turismo',
          //  style: TextStyle(fontWeight: FontWeight.bold),
          //),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'tourism_page');
        },
      ));
}

Widget cardServicios(BuildContext context) {
  return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: Color.fromARGB(163, 230, 212, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        child: Container(
          child: Image(
            image: AssetImage('assets/otrosservicios/OTROS SERVICIOS-11.png'),
            width: 585,
            height: 130,
          ),
          //Text(
          //  'Turismo',
          //  style: TextStyle(fontWeight: FontWeight.bold),
          //),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'servicios_page');
        },
      ));
}

// Widget cardHamburguesa(BuildContext context) {
//   return Card(
//       color: Colors.white,
//       elevation: 14,
//       shadowColor: Color.fromARGB(163, 230, 212, 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
//       child: InkWell(
//         child: Container(
//           child: Image(
//             image: AssetImage('assets/logo burger-20.png'),
//             width: 585,
//             height: 130,
//           ),
//           //Text(
//           //  'Turismo',
//           //  style: TextStyle(fontWeight: FontWeight.bold),
//           //),
//         ),
//         onTap: () {
//           Navigator.pushNamed(context, 'Hamburguesa_page');
//         },
//       ));
// }

Widget cardMasFusa(BuildContext context) {
  return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: Color.fromARGB(163, 230, 212, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        child: Container(
          child: Image(
            image: AssetImage('assets/+fusa/+FUSAGASUGA-11.png'),
            width: 585,
            height: 130,
          ),
          //Text(
          //  'Turismo',
          //  style: TextStyle(fontWeight: FontWeight.bold),
          //),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'MasFusa_page');
        },
      ));
}

launchURL1(String url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'could not launch $url';
  }
}

Widget cardHistory(BuildContext context) {
  return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: Color.fromARGB(163, 230, 212, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        child: Container(
          child: Image(
            image: AssetImage('assets/history/historia_logo.png'),
            width: 585,
            height: 130,
          ),
          //Text(
          // 'Gastronomía',
          // style: TextStyle(fontWeight: FontWeight.bold),
          // ),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'history_page');
        },
      ));
}

Widget cardTrekking(BuildContext context) {
  return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: Color.fromARGB(163, 230, 212, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        child: Container(
          child: Image(
            image: AssetImage('assets/trekking/trekking_fondo.png'),
            width: 585,
            height: 130,
          ),
          //Text(
          // 'Gastronomía',
          // style: TextStyle(fontWeight: FontWeight.bold),
          // ),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'gastronomia_page');
        },
      ));
}

Widget cardGastronomia(BuildContext context) {
  return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: Color.fromARGB(163, 230, 212, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: InkWell(
        child: Container(
          child: Image(
            image: AssetImage('assets/restaurants/gastronomy.png'),
            width: 585,
            height: 130,
          ),
          //Text(
          // 'Gastronomía',
          // style: TextStyle(fontWeight: FontWeight.bold),
          // ),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'gastronomia_page');
        },
      ));
}
