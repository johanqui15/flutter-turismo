import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/senderismo_pages/model/arguments_senderismo.dart';

class ConnectionSelectedSenderismo {
  Future<List<ArgumentsSenderismo>> getSenderismo(int id) async {
    List<ArgumentsSenderismo> listSenderismo = [];
    try {
      // Uri uri = Uri.parse(
      //     'https://api.destinofusagasuga.gov.co/api/senderismo/mostrar_senderismo/${id}');
      Uri uri = Uri.parse(
          'https://api.destinofusagasuga.gov.co/api/senderismo/mostrar_senderismo/${id}');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var element in json['informacion']) {
          listSenderismo.add(ArgumentsSenderismo(
              element['senderismo']['id_senderismo'],
              element['senderismo']['nombre'],
              element['senderismo']['descripcion'],
              element['senderismo']['caracteristica'],
              element['senderismo']['link_ubicacion'],
              element['senderismo']['caminando'],
              element['senderismo']['cicla'],
              element['senderismo']['moto'],
              element['senderismo']['carro'],
              element['senderismo']['tipo_turismo'],
              element['imagenes_senderismo']));
        }
        return listSenderismo;
      }
    } catch (e) {
      print(e);
    }
    return listSenderismo;
  }
}
