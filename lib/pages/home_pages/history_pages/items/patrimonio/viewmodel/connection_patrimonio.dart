import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/history_pages/items/patrimonio/model/patrimonio_arguments.dart';
import 'package:http/http.dart' as http;

class ConnectionPatrimonio {
  Future<List<PatrimonioArguments>> getPatrimonio(int tipoPatrimonio) async {
    List<PatrimonioArguments> listPatrimonio = [];

    try {
      //await Future.delayed(Duration(seconds: 3));

      // Uri uri = Uri.parse('https://api.destinofusagasuga.gov.co/api/patrimonio/mostrar_tipo_patrimonio/${tipoPatrimonio}');
      Uri uri = Uri.parse(
          'https://api.destinofusagasuga.gov.co/api/patrimonio/mostrar_tipo_patrimonio/${tipoPatrimonio}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);

        for (var patrimonio in json['informacion']) {
          listPatrimonio.add(PatrimonioArguments(
              patrimonio['patrimonio']['nombre'],
              patrimonio['patrimonio']['descripcion'],
              patrimonio['patrimonio']['direccion'],
              patrimonio['patrimonio']['link_ruta'],
              patrimonio['patrimonio']['fecha_creacion'],

              // 'https://api.destinofusagasuga.gov.co${patrimonio['imagenes_patrimonio']}'));
              'https://api.destinofusagasuga.gov.co${patrimonio['imagenes_patrimonio']}'));
        }
        return listPatrimonio;
      }
    } catch (e) {
      print('error patrimonio $e');
    }

    return listPatrimonio;
  }
}
