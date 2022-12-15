import 'dart:convert';

import 'package:prue/pages/home_pages/history_pages/items/historia/model/arguments_historia.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectionHistoria {
  Future<List<ArgumentsHistoria>> getHistoria() async {
    List<ArgumentsHistoria> listArguments = [];

    // Uri uri = Uri.parse('https://api.destinofusagasuga.gov.co/api/historia/ultima_historia');
    Uri uri = Uri.parse(
        'https://api.destinofusagasuga.gov.co/api/historia/ultima_historia');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);

      print(json);
      for (var item in json['informacion']) {
        listArguments.add(ArgumentsHistoria(
            item['historia']['title'],
            item['historia']['descripcion'],
            item['historia']['link_ubicacion'],
            item['imagenes_historia']));
      }

      print(json);
    }

    return listArguments;
  }
}
