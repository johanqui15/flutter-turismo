import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prue/pages/home_pages/servicios/model/service_selected_json.dart';

class ConectionSelectedService {
//HERA WE GET THE ITEMS OF serviceS API
  int id;

  ConectionSelectedService(this.id);

  Future<List<ServiceSelectedJSON>> getDataSelected() async {
    List<ServiceSelectedJSON> listInfoservice = [];

    try {
      if (Platform.isAndroid) {
        // final Uri url =
        //     Uri.parse('https://api.destinofusagasuga.gov.co/api/servicee/rest/$_idRes');
        final Uri url = Uri.parse(
            'https://api.destinofusagasuga.gov.co/api/otrosservicios/rest/$id');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          for (var item in json['informacion']) {
            listInfoservice.add(ServiceSelectedJSON(
              item['otrosservicios']['id'],
              item['otrosservicios']['nombre'],
              item['otrosservicios']['direccion'],
              item['otrosservicios']['telefono'],
              item['otrosservicios']['horario'],
              item['otrosservicios']['link'],
              item['otrosservicios']['descripcion'],
              item['otrosservicios']['tiposservicio'].toString(),
              item['imagenes_otros'],
            ));
          }

          return listInfoservice;
        }
      } else if (Platform.isIOS) {
        // final Uri url = Uri.parse(
        //     'https://api.destinofusagasuga.gov.co/api/servicee/rest/$_idRes');
        final Uri url = Uri.parse(
            'https://api.destinofusagasuga.gov.co/api/otrosservicios/rest/$id');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          for (var item in json['informacion']) {
            listInfoservice.add(ServiceSelectedJSON(
              item['otrosservicios']['id'],
              item['otrosservicios']['nombre'],
              item['otrosservicios']['direccion'],
              item['otrosservicios']['telefono'],
              item['otrosservicios']['horario'],
              item['otrosservicios']['link'],
              item['otrosservicios']['descripcion'],
              item['otrosservicios']['tiposservicio'].toString(),
              item['imagenes_otros'],
            ));
          }

          return listInfoservice;
        }
      }
    } catch (e) {
      print('error $e');
    }

    return listInfoservice;
  }
}
