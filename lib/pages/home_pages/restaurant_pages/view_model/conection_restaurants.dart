import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/restaurant_pages/model/json_restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRestaurant {
  Future<List<RestaurantStruct>> getData(String link) async {
    String token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token').toString();

    List<RestaurantStruct> restaurants = [];

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

        for (var restaurant in json['informacion']) {
          print('============== ${restaurant['plato']['nombre']}');
          //10.0.2.2:8000
          //127.0.0.1:8000
          // ESTA VALIDACIÓN ES PARA CONTROLAR  EL PRIMER VALOR NULO, YA AL INICIAR OBTENEMOS UN VALOR NULO, LO CUAL NOS DA UN ERROR
          var validacion = '';

          try {
            if (restaurant['restaurante'][0]['nombre'] != null) {
              validacion = 'si';
            }
          } catch (e) {
            print(e);
          }

          if (validacion != '') {
            restaurants.add(RestaurantStruct(
                restaurant['restaurante'][0]['nombre'],
                restaurant['restaurante'][0]['direccion'],
                restaurant['restaurante'][0]['horario_atencion'],
                [
                  'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                  // 'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                ],
                restaurant['plato']['0']['nombre'],
                restaurant['restaurante'][0]['id_res'],
                restaurant['restaurante'][0]['mascota']));
          } else {
            restaurants.add(RestaurantStruct(
                restaurant['restaurante']['nombre'] ?? 'Restaurante',
                restaurant['restaurante']['direccion'] ?? 'Fusagasugá',
                restaurant['restaurante']['horario_atencion'] ?? 'Restaurante',
                [
                  // 'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                  'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                ],
                restaurant['plato']['0']['nombre'] ?? 'Plato',
                restaurant['restaurante']['id_res'] ?? 2,
                restaurant['restaurante']['mascota'] ?? 2));
          }
        }

        return restaurants;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'La sesión a caducado, vuelve a iniciar sesión',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromARGB(255, 229, 226, 226),
            textColor: Colors.black);
      }
    } catch (e) {
      print('Error conexion a restaurantes $e');
    }
    return restaurants;
  }
}







              // restaurants.add(RestaurantStruct(
              //     restaurant['restaurante']['nombre'],
              //     restaurant['restaurante']['direccion'],
              //     [
              //       'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
              //     ],
              //     restaurant['plato']['0']['nombre'],
              //     restaurant['restaurante']['id_res'],
              //     restaurant['restaurante']['mascota']));
              // print('!!!!!!!!!!!!!es uno ${restaurant['mascota']}');
            