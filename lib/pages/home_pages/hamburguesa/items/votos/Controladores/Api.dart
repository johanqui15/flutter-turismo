import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Modelos/Registro.dart';

class Api {
  //String baseURL = 'http://172.17.170.10:8080/api/';

  Future<dynamic> buscar(var registro) async {
    Map<String, dynamic> m = {
      'id': registro.toString(),
    };
    var url = Uri.parse('http://172.17.100.10:80/api/qr');
    var response = await http.post(url,
        headers: {
          HttpHeaders.acceptHeader: "application/json",
        },
        body: m);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
