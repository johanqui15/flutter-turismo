import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prue/pages/home_pages/restaurant_pages/model/restaurant_selected_json.dart';

class ConectionSelectedRestaurant {
//HERA WE GET THE ITEMS OF RESTAURANTS API
  int _idRes;

  ConectionSelectedRestaurant(this._idRes);

  Future<List<RestaurantSelectedJSON>> getDataSelected() async {
    List<RestaurantSelectedJSON> listInfoRestaurant = [];

    try {
      if (Platform.isAndroid) {
        // final Uri url =
        //     Uri.parse('https://api.destinofusagasuga.gov.co/api/restaurante/rest/$_idRes');
        final Uri url = Uri.parse(
            'https://api.destinofusagasuga.gov.co/api/restaurante/rest/$_idRes');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          for (var restaurant in json['informacion']) {
            if (restaurant['mascota'] != null) {
              listInfoRestaurant.add(RestaurantSelectedJSON(
                  restaurant['restaurante']['id_res'],
                  restaurant['restaurante']['nombre'],
                  restaurant['restaurante']['direccion'],
                  restaurant['restaurante']['telefono'],
                  restaurant['restaurante']['horario_atencion'],
                  restaurant['imagenes_restaurante'],
                  restaurant['ruta']['0']['link_ruta'],
                  restaurant['tipo_restaurante']['nombre'],
                  restaurant['plato']['0']['nombre'],
                  restaurant['plato']['0']['descripcion'],
                  restaurant['imagenes_plato'],
                  restaurant['restaurante']['mascota']));
            } else {
              listInfoRestaurant.add(RestaurantSelectedJSON(
                  restaurant['restaurante']['id_res'],
                  restaurant['restaurante']['nombre'],
                  restaurant['restaurante']['direccion'],
                  restaurant['restaurante']['telefono'],
                  restaurant['restaurante']['horario_atencion'],
                  restaurant['imagenes_restaurante'],
                  restaurant['ruta']['0']['link_ruta'],
                  restaurant['tipo_restaurante']['0']['nombre'],
                  restaurant['plato']['0']['nombre'],
                  restaurant['plato']['0']['descripcion'],
                  restaurant['imagenes_plato'],
                  restaurant['restaurante']['mascota']));
            }

            return listInfoRestaurant;
          }
        }
      } else if (Platform.isIOS) {
        // final Uri url = Uri.parse(
        //     'https://api.destinofusagasuga.gov.co/api/restaurante/rest/$_idRes');
        final Uri url = Uri.parse(
            'https://api.destinofusagasuga.gov.co/api/restaurante/rest/$_idRes');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          for (var restaurant in json['informacion']) {
            if (restaurant['mascota'] != null) {
              listInfoRestaurant.add(RestaurantSelectedJSON(
                  restaurant['restaurante']['id_res'],
                  restaurant['restaurante']['nombre'],
                  restaurant['restaurante']['direccion'],
                  restaurant['restaurante']['telefono'],
                  restaurant['restaurante']['horario_atencion'],
                  restaurant['imagenes_restaurante'],
                  restaurant['ruta']['0']['link_ruta'],
                  restaurant['restaurante']['nombre_propietario'],
                  restaurant['plato']['0']['nombre'],
                  restaurant['plato']['0']['descripcion'],
                  restaurant['imagenes_plato'],
                  restaurant['restaurante']['mascota']));
            } else {
              listInfoRestaurant.add(RestaurantSelectedJSON(
                  restaurant['restaurante']['id_res'],
                  restaurant['restaurante']['nombre'],
                  restaurant['restaurante']['direccion'],
                  restaurant['restaurante']['telefono'],
                  restaurant['restaurante']['horario_atencion'],
                  restaurant['imagenes_restaurante'],
                  restaurant['ruta']['0']['link_ruta'],
                  restaurant['restaurante']['nombre_propietario'],
                  restaurant['plato']['0']['nombre'],
                  restaurant['plato']['0']['descripcion'],
                  restaurant['imagenes_plato'],
                  restaurant['restaurante']['mascota']));
            }

            return listInfoRestaurant;
          }
        }
      }
    } catch (e) {
      print('error $e');
    }

    return listInfoRestaurant;
  }
}
