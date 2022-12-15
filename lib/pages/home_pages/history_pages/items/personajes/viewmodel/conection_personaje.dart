import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/history_pages/items/personajes/model/arguments_personaje.dart';

class ConnectionPersonaje {
  Future<List<ArgumentsPersonaje>> getPersonajes() async {
    List<ArgumentsPersonaje> listPersonajes = [];
    try {
      // Uri uri = Uri.parse(

      //     'https://api.destinofusagasuga.gov.co/api/personaje_historico/mostrar_personajes_multimedia');
      Uri uri = Uri.parse(
          'https://api.destinofusagasuga.gov.co/api/personaje_historico/mostrar_personajes_multimedia');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var personaje in json['informacion']) {
          listPersonajes.add(ArgumentsPersonaje(
              personaje['personaje']['id_personaje'],
              personaje['personaje']['nombre'],
              personaje['personaje']['descripcion'],

              // 'https://api.destinofusagasuga.gov.co${personaje['imagen']}',

              'https://api.destinofusagasuga.gov.co${personaje['imagen']}',
              personaje['personaje']['fecha_nacimiento']));
        }
        return listPersonajes;
      }
    } catch (e) {
      print('error personajes $e');
    }

    return listPersonajes;
  }
}
