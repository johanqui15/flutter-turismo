import 'dart:convert';

import 'package:prue/pages/home_pages/history_pages/items/historia/model/arguments_historia.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/masfusa/model/arguments_calendario.dart';

class ConnectionCalendario {
  Future<List<ArgumentsCalendario>> getCalendario() async {
    List<ArgumentsCalendario> listArguments = [];

    // Uri uri = Uri.parse('https://api.destinofusagasuga.gov.co/api/historia/ultima_historia');
    Uri uri = Uri.parse(
        'https://api.destinofusagasuga.gov.co/api/calendario/ultima_calendario');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);

      print(json);
      for (var item in json['informacion']) {
        listArguments.add(ArgumentsCalendario(
            item['calendario']['titulo'],
            item['calendario']['descripcion'],
            item['calendario']['direccion'],
            item['calendario']['ruta'],
            item['imagenes_calendario']));
      }

      print(json);
    }

    return listArguments;
  }
}
