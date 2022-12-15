import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/servicios/model/tipo_service.dart';

class ConnectionTipoService {
  Future<List<TipoService>> getTipoService() async {
    List<TipoService> tiposList = [];

    try {
      // Uri uri = Uri.parse(
      //     'https://api.destinofusagasuga.gov.co/api/tipo_restaurante');
      Uri uri =
          Uri.parse('https://api.destinofusagasuga.gov.co/api/tiposservicio');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var tipo in json) {
          print(tipo);
          tiposList.add(TipoService(tipo['id'], tipo['nombre']));
        }
        return tiposList;
      }
    } catch (e) {
      print('FALLAS EN LA MATRIX $e');
    }
    return tiposList;
  }
}
