import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/coffee_pages/model/coffee_arguments.dart';
import 'package:prue/pages/home_pages/coffee_pages/model/services_coffe.dart';

class ConectionSelectedCoffe {
  int id_cafe;
  ConectionSelectedCoffe(this.id_cafe);

  Future<List<ServicesCoffe>> getServicesCoffe() async {
    List<ServicesCoffe> listServices = [];

    // final Uri uri = Uri.parse('https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
    try {
      if (Platform.isIOS) {
        // final Uri uri = Uri.parse('https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
        final Uri uri =
            Uri.parse('https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          for (var item in json['informacion']) {
            listServices.add(ServicesCoffe(
                item['servicio_adicional']['0']['banio'],
                item['servicio_adicional']['0']['otro'],
                item['servicio_adicional']['0']['musica_vivo'],
                item['servicio_adicional']['0']['ninguno'],
                item['servicio_adicional']['0']['pagos_digitales'],
                item['servicio_adicional']['0']['zona_wifi'],
                item['servicio_adicional']['0']['servicios']));
            return listServices;
          }
        }
      } else if (Platform.isAndroid) {
        try {
          // final Uri uri = Uri.parse(
          //     'https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
          final Uri uri = Uri.parse(
              ' https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
          final response =
              await http.get(uri).timeout(const Duration(seconds: 10));

          if (response.statusCode == 200) {
            final body = utf8.decode(response.bodyBytes);
            final json = jsonDecode(body);

            for (var item in json['informacion']) {
              listServices.add(ServicesCoffe(
                  item['servicio_adicional']['0']['banio'],
                  item['servicio_adicional']['0']['otro'],
                  item['servicio_adicional']['0']['musica_vivo'],
                  item['servicio_adicional']['0']['ninguno'],
                  item['servicio_adicional']['0']['pagos_digitales'],
                  item['servicio_adicional']['0']['zona_wifi'],
                  item['servicio_adicional']['0']['servicios']));
              return listServices;
            }
          }
        } on TimeoutException catch (e) {
          listServices.add(ServicesCoffe(0, 0, 0, 0, 0, 0, ''));
          return listServices;
        } catch (e) {
          print('error servicios');
        }
      }
    } catch (e) {
      print('error $e');
    }
    return listServices;
  }

  Future<List<CoffeeArguments>> getDataCoffeSelected() async {
    List<CoffeeArguments> listInfoCoffe = [];

    try {
      if (Platform.isAndroid) {
        // Uri url =
        //     Uri.parse('https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
        Uri url =
            Uri.parse('https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
        var response = await http.get(url).timeout(const Duration(seconds: 7));

        if (response.statusCode == 200) {
          var body = utf8.decode(response.bodyBytes);
          var json = jsonDecode(body);

          for (var item in json['informacion']) {
            listInfoCoffe.add(CoffeeArguments(
                item['cafe']['id_cafe'],
                item['cafe']['nombre'],
                item['cafe']['direccion'],
                item['cafe']['historia'],
                item['cafe']['horario_atencion'],
                item['cafe']['origen_cafe'],
                item['cafe']['pagina_web'] ?? 'empty',
                item['redes_sociales'] ?? ['empty'],
                item['menu']['0']['id_menu'],
                item['menu']['0']['menu'],
                item['menu']['0']['pasteleria'],
                item['menu']['0']['licores'],
                item['menu']['0']['comidas_rapidas'],
                item['menu']['0']['helados'],
                item['menu']['0']['otro'],
                item['servicio_adicional']['0']['banio'],
                item['servicio_adicional']['0']['otro'],
                item['servicio_adicional']['0']['ninguno'],
                item['servicio_adicional']['0']['zona_wifi'],
                item['servicio_adicional']['0']['musica_vivo'],
                item['servicio_adicional']['0']['pagos_digitales'],
                item['servicio_adicional']['0']['servicios'],
                item['imagenes_cafe']));
            return listInfoCoffe;
          }
          return listInfoCoffe;
        }
      } else if (Platform.isIOS) {
        // Uri url =
        //     Uri.parse('https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
        Uri url =
            Uri.parse('https://api.destinofusagasuga.gov.co/api/cafe/$id_cafe');
        var response = await http.get(url);

        if (response.statusCode == 200) {
          var body = utf8.decode(response.bodyBytes);
          var json = jsonDecode(body);

          for (var item in json['informacion']) {
            print(item['redes_sociales']);

            listInfoCoffe.add(CoffeeArguments(
                item['cafe']['id_cafe'],
                item['cafe']['nombre'],
                item['cafe']['direccion'],
                item['cafe']['historia'],
                item['cafe']['horario_atencion'],
                item['cafe']['origen_cafe'],
                item['cafe']['pagina_web'] ?? 'empty',
                item['redes_sociales'] ?? ['empty'],
                item['menu']['0']['id_menu'],
                item['menu']['0']['menu'],
                item['menu']['0']['pasteleria'],
                item['menu']['0']['licores'],
                item['menu']['0']['comidas_rapidas'],
                item['menu']['0']['helados'],
                item['menu']['0']['otro'],
                item['servicio_adicional']['0']['banio'],
                item['servicio_adicional']['0']['otro'],
                item['servicio_adicional']['0']['ninguno'],
                item['servicio_adicional']['0']['zona_wifi'],
                item['servicio_adicional']['0']['musica_vivo'],
                item['servicio_adicional']['0']['pagos_digitales'],
                item['servicio_adicional']['0']['servicios'],
                item['imagenes_cafe']));

            return listInfoCoffe;
          }
        }
      }
    } on TimeoutException catch (e) {
      listInfoCoffe.add(CoffeeArguments(
          0,
          'Sin servicio',
          'No se logró acceder a la red',
          '',
          '',
          'Estamos teniedo problemas para acceder a la información ',
          '',
          [],
          0,
          '',
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          '',
          []));
      return listInfoCoffe;
    } catch (e) {
      print('error $e');
    }
    return listInfoCoffe;
  }
}
