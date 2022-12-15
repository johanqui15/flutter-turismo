import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/restaurant_pages/model/tipo_restaurante.dart';
import 'package:http/http.dart' as http;

class ConnectionTipoRestaurante {
  Future<List<TipoRestaurante>> getTipoRest() async {
    List<TipoRestaurante> tiposList = [];

    try {
      // Uri uri = Uri.parse(
      //     'https://api.destinofusagasuga.gov.co/api/tipo_restaurante');
      Uri uri = Uri.parse(
          'https://api.destinofusagasuga.gov.co/api/tipo_restaurante');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var tipo in json) {
          print(tipo);
          tiposList.add(TipoRestaurante(
              tipo['id_tipo_res'], tipo['nombre'], tipo['tipo_res']));
        }
        return tiposList;
      }
    } catch (e) {
      print('FALLAS EN LA MATRIX $e');
    }
    return tiposList;
  }
}
