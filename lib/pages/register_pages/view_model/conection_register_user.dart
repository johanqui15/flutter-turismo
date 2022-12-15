import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterUser {
  void registerUser(
      String name,
      String email,
      String tipoDocumento,
      String document,
      String birthDate,
      String city,
      String password,
      BuildContext context) async {
    try {
      //
      final tipo = 2;
      final response = await http.post(
          // Uri.parse('https://api.destinofusagasuga.gov.co/api/auth/register'),
          Uri.parse('https://api.destinofusagasuga.gov.co/api/auth/register'),
          headers: {},
          body: {
            'nombre': name,
            'email': email,
            'fecha_nacimiento': birthDate,
            'tipo_documento': tipoDocumento,
            'documento': document,
            'ciudad_residencia': city,
            'password': password,
            'tipo_usuario': tipo.toString(),
          });
      if (response.statusCode == 201) {
        final body = response.body;
        final json = await jsonDecode(body);

        print('----------------------Se registró');

        Fluttertoast.showToast(
            msg: 'Usuario registrado',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromARGB(255, 229, 226, 226),
            textColor: Colors.black);
        Navigator.of(context).pop();
      } else if (response.statusCode == 400) {
        final body = response.body;
        final json = await jsonDecode(body);

        switch (json) {
          case '{"email":["The email has already been taken."]}':
            Fluttertoast.showToast(
                msg: 'El correo ya ha sido registrado',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Color.fromARGB(255, 229, 226, 226),
                textColor: Colors.black);
            break;

          case '{"documento":["The documento has already been taken."]}':
            Fluttertoast.showToast(
                msg: 'El documento ya ha sido registrado',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Color.fromARGB(255, 229, 226, 226),
                textColor: Colors.black);
            break;
          default:
            Fluttertoast.showToast(
                msg: 'Revise los datos',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Color.fromARGB(255, 229, 226, 226),
                textColor: Colors.black);
        }

        print('En 400 $json');
      } else if (response.statusCode == 500) {
        final body = response.body;
        final json = jsonDecode(body);
        print('En 500 $json');
      } else {
        final body = response.body;
        final json = jsonDecode(body);
        print('En falso $json');
      }
    } catch (e) {
      print('Error al registrarse $e');
    }
  }
}
