import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/coffee_pages/model/coffee_arguments.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConectionCoffe {
  Future<List<CoffeeArguments>> getDataCoffee() async {
    var token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');

    List<CoffeeArguments> listInfoCoffee = [];
    if (Platform.isIOS) {
      print('is a IOS');

      // final Uri url = Uri.parse('https://api.destinofusagasuga.gov.co/api/auth/cafe/todos');
      final Uri url =
          Uri.parse('https://api.destinofusagasuga.gov.co/api/auth/cafe/todos');
      final response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

//HACER ALGORTIMO PARA RECORRER LA CANTIDAD DE IMAGENES Y ASIGNARLA EN EL ARREGLO
//DE IMAGENES
        for (var item in json['informacion']) {
          print(json['informacion']);
          print(item['imagenes_cafe']);

          listInfoCoffee.add(CoffeeArguments(
              item['cafe']['id_cafe'],
              item['cafe']['nombre'],
              item['cafe']['direccion'],
              item['cafe']['historia'],
              item['cafe']['horario_atencion'],
              item['cafe']['origen_cafe'],
              item['cafe']['pagina_web'] ?? 'empty',
              item['cafe']['red_social'] ?? ['empty'],
              item['menu']['0']['id_menu'],
              item['menu']['0']['menu'],
              item['menu']['0']['pasteleria'],
              item['menu']['0']['licores'],
              item['menu']['0']['comidas_rapidas'],
              item['menu']['0']['helados'],
              item['menu']['0']['otro'],
              item['servicio_adicional']['0']['banio'],
              item['servicio_adicional']['0']['otro'],
              item['servicio_adicional']['0']['ninguno'],
              item['servicio_adicional']['0']['zona_wifi'],
              item['servicio_adicional']['0']['musica_vivo'],
              item['servicio_adicional']['0']['pagos_digitales'],
              item['servicio_adicional']['0']['servicios'], [
            // 'https://api.destinofusagasuga.gov.co${item['imagenes_cafe'][0]}'
            'https://api.destinofusagasuga.gov.co${item['imagenes_cafe'][0]}'
          ]));
        }
        return listInfoCoffee;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'La sesión a caducado, vuelve a iniciar sesión',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromARGB(255, 229, 226, 226),
            textColor: Colors.black);
      }
    } else if (Platform.isAndroid) {
      print('is a Andriod');

      try {
        // final Uri url = Uri.parse(
        //     'https://api.destinofusagasuga.gov.co/api/auth/cafe/todos');
        final Uri url = Uri.parse(
            'https://api.destinofusagasuga.gov.co/api/auth/cafe/todos');
        final response = await http.get(url, headers: {
          "Authorization": "Bearer $token"
        }).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);
          for (var item in json['informacion']) {
            listInfoCoffee.add(CoffeeArguments(
                item['cafe']['id_cafe'],
                item['cafe']['nombre'],
                item['cafe']['direccion'],
                item['cafe']['historia'],
                item['cafe']['horario_atencion'],
                item['cafe']['origen_cafe'],
                item['cafe']['pagina_web'] ?? 'empty',
                item['cafe']['red_social'] ?? ['empty'],
                item['menu']['0']['id_menu'],
                item['menu']['0']['menu'],
                item['menu']['0']['pasteleria'],
                item['menu']['0']['licores'],
                item['menu']['0']['comidas_rapidas'],
                item['menu']['0']['helados'],
                item['menu']['0']['otro'],
                item['servicio_adicional']['0']['banio'],
                item['servicio_adicional']['0']['otro'],
                item['servicio_adicional']['0']['ninguno'],
                item['servicio_adicional']['0']['zona_wifi'],
                item['servicio_adicional']['0']['musica_vivo'],
                item['servicio_adicional']['0']['pagos_digitales'],
                item['servicio_adicional']['0']['servicios'], [
              // 'https://api.destinofusagasuga.gov.co${item['imagenes_cafe'][0]}'
              'https://api.destinofusagasuga.gov.co${item['imagenes_cafe'][0]}'
            ]));
          }
          return listInfoCoffee;
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: 'La sesión a caducado, vuelve a iniciar sesión',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Color.fromARGB(255, 229, 226, 226),
              textColor: Colors.black);
        }
      } on TimeoutException catch (e) {
        listInfoCoffee.add(CoffeeArguments(
            0,
            'Sin servicio',
            '',
            '',
            '',
            'Estamos teniedo problemas para acceder a la red.  ',
            '',
            [],
            0,
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            '',
            []));
      } catch (e) {
        print('El error es el siguient $e');
      }
    }

    return listInfoCoffee;
  }
}
