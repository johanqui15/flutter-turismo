import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/servicios/model/json_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetService {
  Future<List<ServiceStruct>> getData(String link) async {
    String token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token').toString();

    List<ServiceStruct> services = [];

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

        for (var item in json['informacion']) {
          //10.0.2.2:8000
          //127.0.0.1:8000
          // ESTA VALIDACIÓN ES PARA CONTROLAR  EL PRIMER VALOR NULO, YA AL INICIAR OBTENEMOS UN VALOR NULO, LO CUAL NOS DA UN ERROR
          var validacion = '';
          try {
            if (item['otrosservicios']['nombre'] != null) {
              validacion = 'si';
            }
          } catch (e) {
            print(e);
          }

          if (validacion != '') {
            services.add(ServiceStruct(
                item['otrosservicios']['id'],
                item['otrosservicios']['nombre'],
                item['otrosservicios']['direccion'],
                item['otrosservicios']['telefono'],
                item['otrosservicios']['horario'],
                item['otrosservicios']['link'],
                item['otrosservicios']['descripcion'],
                item['otrosservicios']['tiposservicio'].toString(),
                // item['imagenes_otrosservicios'],
                [
                  'https://api.destinofusagasuga.gov.co${item['imagenes_otrosservicios'][0]}'
                  // 'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                ]));
          } else {
            services.add(ServiceStruct(
                item['otrosservicios']['id'],
                item['otrosservicios']['nombre'],
                item['otrosservicios']['direccion'],
                item['otrosservicios']['telefono'],
                item['otrosservicios']['horario'],
                item['otrosservicios']['link'],
                item['otrosservicios']['descripcion'],
                item['otrosservicios']['tiposservicio'].toString(),
                // item['imagenes_otrosservicios'],
                [
                  'https://api.destinofusagasuga.gov.co${item['imagenes_otrosservicios'][0]}'
                  // 'https://api.destinofusagasuga.gov.co${restaurant['imagenes_restaurante'][0]}'
                ]));
          }
        }

        return services;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'La sesión a caducado, vuelve a iniciar sesión',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromARGB(255, 229, 226, 226),
            textColor: Colors.black);
      }
    } catch (e) {
      print('Error conexion a servicios $e');
    }
    return services;
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
            