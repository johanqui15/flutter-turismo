import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/rendering.dart';
import 'package:prue/pages/login_pages/login_page.dart';
import 'package:prue/utilities/colors.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/votos/Controladores/Api.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/votos/Controladores/user.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/votos/Controladores/api_response.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/votos/provider/user_services.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/votos/provider/votosprovider.dart';
import 'package:http/http.dart' as http;
// import 'package:prueba2/Modelos/Registro.dart';
import 'dart:async';
import 'dart:convert';

class VotosHomePage extends StatefulWidget {
  @override
  State<VotosHomePage> createState() => _VotosHomePageState();
}

class _VotosHomePageState extends State<VotosHomePage> {
  var voto;

  User? user;
  bool loading = true;
  var user_id;
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      // print(response.data);
      setState(() {
        user = response.data as User;
        loading = false;
        user_id = user?.id;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // void getres() async {
  //   ApiResponse response = await getDataSelected();
  //   if (response.error == null) {
  //     setState(() {
  //        = response.data as User;
  //       loading = false;
  //       user_id = user?.id;
  //     });
  //   } else if (response.error == unauthorized) {
  //     logout().then((value) => {
  //           Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => LoginPage()),
  //               (route) => false)
  //         });
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('${response.error}')));
  //   }
  // }
  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final widht = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      backgroundColor: colorBackgroudScreens,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/BurguerFestival/fondo_vota-27.png'),
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
                      padding: EdgeInsets.only(left: 20),
                      child: ButtonBack(widht, context),
                    ),
                    Spacer(),
                    Column(
                      children: [],
                    ),
                    Spacer()
                  ],
                ),
              ],
            )),
          ),
          if (rows == '')
            if (carga == true)
              Container(
                margin: EdgeInsets.only(top: 480, left: 60),
                padding: EdgeInsets.all(5),
                child: Container(
                  width: 280,
                  height: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
          // if (carga == true)
          //   Container(
          //     margin: EdgeInsets.all(10),
          //     padding: EdgeInsets.all(5),
          //     child: Container(
          //       width: 280,
          //       height: 35,
          //       color: Colors.white,
          //       child: Text(
          //         'Escaneaste: $qr',
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontStyle: FontStyle.italic,
          //           fontSize: 25,
          //           color: Colors.blue[500],
          //         ),
          //       ),
          //     ),
          //   ),
          if (carga == true)
            Container(
              margin: EdgeInsets.only(top: 500, left: 60),
              padding: EdgeInsets.all(5),
              child: Container(
                width: 280,
                height: 35,
                color: Colors.white,
                child: Text(
                  'Informacion del Usuario',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Color.fromARGB(255, 243, 33, 33),
                  ),
                ),
              ),
            ),
          if (carga == true)
            Container(
              margin: EdgeInsets.only(top: 480, left: 60),
              padding: EdgeInsets.all(5),
              child: Container(
                width: 280,
                height: 60,
                color: Colors.white,
                child: Text(
                  'Nombre restaurante: $restaurante',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          // if (carga == true)
          //   Container(
          //     margin: EdgeInsets.only(top: 500, left: 60),
          //     padding: EdgeInsets.all(5),
          //     child: Container(
          //       width: 280,
          //       height: 80,
          //       color: Colors.white,
          //       child: Text(
          //         'Cedula: $ple',
          //         style: TextStyle(
          //           fontWeight: FontWeight.normal,
          //           fontStyle: FontStyle.italic,
          //           fontSize: 16,
          //           color: Color.fromARGB(255, 0, 0, 0),
          //         ),
          //       ),
          //     ),
          //   ),

          if (carga == true)
            Container(
              margin: EdgeInsets.only(top: 550),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // print(user_id);
                      VotosProvider().registro(idh.toString(),
                          voto = 1.toString(), user_id.toString(), context);
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 168, 200),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image:
                              AssetImage('assets/BurguerFestival/like-24.png'),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      VotosProvider().registro(idh.toString(),
                          voto = 0.toString(), user_id.toString(), context);
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 168, 200),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/BurguerFestival/dislike-24.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 680, left: 60),
            width: 300,
            height: 60,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 168, 200),
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              child: Text("¡Escanea para votar!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 25)),
              onPressed: () {
                sca();
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Container(
          //   child: Image(image: AssetImage('assets/LogoAlcaldia.png')),
          // )
        ],
      ),
    );
  }

  var rows = '';
  var restaurante = '';
  var idh = '';
  var ple = '';
  var data = '';
  // var qr = '';
  var resultado = '';
  bool carga = false;

  var hola2 = 'por aca vamos';
  var hola = 'hola';
  sca() async {
    print(hola);
    var result = await BarcodeScanner.scan();
    print(result.rawContent);
    var id = result.rawContent;
    final Uri url = Uri.parse(
        'https://api.destinofusagasuga.gov.co/api/hamburguesas/mostrar_hamburguesas/$id');
    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);
      print(json);

      if (result.rawContent == '') {
        setState(() {
          rows = '';
          carga = false;
        });
      } else {
        setState(() {
          // rows = response;
          idh = '${json['informacion'][0]['hamburguesas']['id']}';
          restaurante =
              '${json['informacion'][0]['hamburguesas']['restaurante']}';

          // pli = '${json['placa_interna']}';
          // ple = '${json['placa_externa']}';
          // asig = '${json['nombre']}';
          carga = true;
          // qr = result.rawContent;
        });
      }
      // print(hola2);
      // Api api = Api();
      //
      // setState(() {
      //   rows = r;
      // });
      // print(rows);
    }
  }
}
