import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/senderismo_pages/model/arguments_senderismo.dart';

class ConnectionSenderismo {
  Future<List<ArgumentsSenderismo>> getSenderismo(int tipoTurismo) async {
    List<ArgumentsSenderismo> listSenderismo = [];
    try {
      // Uri uri = Uri.parse(
      //     'https://api.destinofusagasuga.gov.co/api/senderismo/mostrar_tipo_turismo/${tipoTurismo}');
      Uri uri = Uri.parse(
          'https://api.destinofusagasuga.gov.co/api/senderismo/mostrar_tipo_turismo/${tipoTurismo}');
      final response = await http.get(uri).timeout(const Duration(seconds: 8));
      print(tipoTurismo);
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var item in json['informacion']) {
          listSenderismo.add(ArgumentsSenderismo(
              item['senderismo']['id_senderismo'],
              item['senderismo']['nombre'],
              item['senderismo']['descripcion'],
              item['senderismo']['caracteristica'],
              item['senderismo']['link_ubicacion'],
              item['senderismo']['caminando'],
              item['senderismo']['cicla'],
              item['senderismo']['moto'],
              item['senderismo']['carro'],
              item['senderismo']['tipo_turismo'], [
            // 'https://api.destinofusagasuga.gov.co${item['imagenes_senderismo'][0]}'
            'https://api.destinofusagasuga.gov.co${item['imagenes_senderismo'][0]}'
          ]));
        }
        return listSenderismo;
      }
    } catch (e) {
      print(e);
    }
    return listSenderismo;
  }
}
