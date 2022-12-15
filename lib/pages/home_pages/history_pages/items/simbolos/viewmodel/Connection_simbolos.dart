import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/history_pages/items/simbolos/model/ArgumentsSimbolo.dart';
import 'package:http/http.dart' as http;

class ConnectionSimbolos {
  Future<List<ArgumentsSimbolo>> getSimbolos() async {
    List<ArgumentsSimbolo> listSimbolos = [];
    try {
      // Uri uri = Uri.parse(
      //     'https://api.destinofusagasuga.gov.co/api/simbolo/mostrar_simbolos_multimedia');
      Uri uri = Uri.parse(
          'https://api.destinofusagasuga.gov.co/api/simbolo/mostrar_simbolos_multimedia');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var item in json['informacion']) {
          listSimbolos.add(ArgumentsSimbolo(
              item['simbolo']['id_simbolo'],
              item['simbolo']['nombre'],
              item['simbolo']['descripcion'],

              // 'https://api.destinofusagasuga.gov.co${item['imagen']}'));
              'https://api.destinofusagasuga.gov.co${item['imagen']}'));
        }
        return listSimbolos;
      }
    } catch (e) {
      print('Connection error Simbolos $e');
    }
    return listSimbolos;
  }
}
