import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/home_pages/home_page.dart';
import 'package:prue/pages/login_pages/model/login_token.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConectionLogin {
  void startLogin(String email, String password, BuildContext context) async {
    print(email);

    try {
      final response = await http.post(
        //https://api.destinofusagasuga.gov.co
        // https://api.destinofusagasuga.gov.co

        // Uri.parse('https://api.destinofusagasuga.gov.co/api/auth/login'),
        Uri.parse('https://api.destinofusagasuga.gov.co/api/auth/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final json = jsonDecode(body);
        print(json['access_token']);

        Future<void> SaveTokenShared(String token) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          //GUARDAMOS EL TOKEN CON LA KEY TOKEN
          await prefs.setString('token', token);
          await prefs.setBool('estado_sesion', true);
        }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(token: json['access_token'])));
        //Navigator.pushNamed(context, 'home_page');

      } else {
        Fluttertoast.showToast(
            msg: 'Datos incorrectos',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromARGB(255, 229, 226, 226),
            textColor: Colors.black);
      }
    } catch (e) {
      print('Error login $e');
    }
  }
}
