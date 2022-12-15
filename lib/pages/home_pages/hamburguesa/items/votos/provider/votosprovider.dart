import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/votos/vistas/votoshome.dart';

class VotosProvider with ChangeNotifier {
  String? _id;
  var idham;
  var _voto;
  var _user_id;
  SharedPreferences? prefs;

  registro(String idh, voto, user_id, context) async {
    prefs = await SharedPreferences.getInstance();
    Map data2 = {
      'fk_id_hamburguesa': idh,
      'voto': voto,
      'fk_id_user': user_id,
    };
    print(data2);
    _id = idh;
    print(" boton ");
    print(_id);

    String body = json.encode(data2);
    print(body);
    var url = Uri.parse(
        'https://api.destinofusagasuga.gov.co/api/festival/registrar');
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    prefs!.setString('id', idh);
    prefs!.setString('voto', voto);
    prefs!.setString('user_id', user_id.toString());

    idham = prefs!.getString('id');
    _voto = prefs!.getString('voto');
    _user_id = prefs!.getString('user_id');

    print(idham);
    print(_voto);
    print(_user_id);
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //Or put here your next screen using Navigator.push() method
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VotosHomePage()));

      print('success');
    } else {
      print('error');
    }
  }
}
