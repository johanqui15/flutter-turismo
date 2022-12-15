import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/hamburguesa/items/hamburguesas/model/json_hamburguesa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetHamburguesa {
  Future<List<HamburguesaStruct>> getData(String link) async {
    String token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token').toString();

    List<HamburguesaStruct> hamburguesas = [];

    final Uri url = Uri.parse(link);

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    //, headers: {"Accept": "application/json"});

    //print(json);
    try {
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var hamburguesa in json['informacion']) {
          print('============== ${hamburguesa['hamburguesas']['restaurante']}');
          //10.0.2.2:8000
          //127.0.0.1:8000
          // ESTA VALIDACIÓN ES PARA CONTROLAR  EL PRIMER VALOR NULO, YA AL INICIAR OBTENEMOS UN VALOR NULO, LO CUAL NOS DA UN ERROR
          var validacion = '';

          try {
            if (hamburguesa['hamburguesas'][0]['restaurante'] != null) {
              validacion = 'si';
            }
          } catch (e) {
            print(e);
          }

          if (validacion != '') {
            hamburguesas.add(HamburguesaStruct(
                hamburguesa['hamburguesas'][0]['restaurante'],
                [
                  'https://api.destinofusagasuga.gov.co${hamburguesa['imagenes_hamburguesas'][0]}'
                  // 'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                ],
                hamburguesa['hamburguesas'][0]['id']));
          } else {
            hamburguesas.add(HamburguesaStruct(
                hamburguesa['hamburguesas']['restaurante'] ?? 'Restaurante',
                [
                  // 'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                  'https://api.destinofusagasuga.gov.co${hamburguesa['imagenes_hamburguesas'][0]}'
                ],
                hamburguesa['hamburguesas']['id'] ?? 2));
          }
        }

        return hamburguesas;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'La sesión a caducado, vuelve a iniciar sesión',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromARGB(255, 229, 226, 226),
            textColor: Colors.black);
      }
    } catch (e) {
      print('Error conexion a hamburguesas $e');
    }
    return hamburguesas;
  }
}







              // restaurants.add(HamburguesaStruct(
              //     restaurant['restaurante']['nombre'],
              //     restaurant['restaurante']['direccion'],
              //     [
              //       'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
              //     ],
              //     restaurant['plato']['0']['nombre'],
              //     restaurant['restaurante']['id_res'],
              //     restaurant['restaurante']['mascota']));
              // print('!!!!!!!!!!!!!es uno ${restaurant['mascota']}');
            