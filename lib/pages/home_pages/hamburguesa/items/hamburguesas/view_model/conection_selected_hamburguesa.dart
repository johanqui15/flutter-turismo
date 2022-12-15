import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prue/pages/home_pages/hamburguesa/items/hamburguesas/model/hamburguesa_selected_json.dart';

class ConectionSelectedHamburguesa {
//HERA WE GET THE ITEMS OF RESTAURANTS API
  int id;

  ConectionSelectedHamburguesa(this.id);

  Future<List<HamburguesaSelectedJSON>> getDataSelected() async {
    List<HamburguesaSelectedJSON> listInfoHamburguesa = [];

    try {
      if (Platform.isAndroid) {
        // final Uri url =
        //     Uri.parse('https://api.destinofusagasuga.gov.co/api/restaurante/rest/$_idRes');
        final Uri url = Uri.parse(
            'https://api.destinofusagasuga.gov.co/api/hamburguesas/mostrar_hamburguesas/$id');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          for (var hamburguesa in json['informacion']) {
            listInfoHamburguesa.add(HamburguesaSelectedJSON(
                hamburguesa['hamburguesas']['id'],
                hamburguesa['hamburguesas']['restaurante'],
                hamburguesa['hamburguesas']['direccion'],
                hamburguesa['hamburguesas']['telefono'],
                hamburguesa['hamburguesas']['horario'],
                hamburguesa['imagenes_hamburguesas'],
                hamburguesa['hamburguesas']['linkruta'],
                hamburguesa['hamburguesas']['ingredientes'],
                hamburguesa['hamburguesas']['nombre_hamburguesa']));

            return listInfoHamburguesa;
          }
        }
      } else if (Platform.isIOS) {
        // final Uri url = Uri.parse(
        //     'https://api.destinofusagasuga.gov.co/api/restaurante/rest/$_idRes');
        final Uri url = Uri.parse(
            'https://api.destinofusagasuga.gov.co/api/hamburguesas/mostrar_hamburguesas/$id');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          for (var hamburguesa in json['informacion']) {
            listInfoHamburguesa.add(HamburguesaSelectedJSON(
                hamburguesa['hamburguesas']['id'],
                hamburguesa['hamburguesas']['restaurante'],
                hamburguesa['hamburguesas']['direccion'],
                hamburguesa['hamburguesas']['telefono'],
                hamburguesa['hamburguesas']['horario'],
                hamburguesa['imagenes_hamburguesas'],
                hamburguesa['hamburguesas']['linkruta'],
                hamburguesa['hamburguesas']['ingredientes'],
                hamburguesa['hamburguesas']['nombre_hamburguesa']));

            return listInfoHamburguesa;
          }
        }
      }
    } catch (e) {
      print('error $e');
    }

    return listInfoHamburguesa;
  }
}
