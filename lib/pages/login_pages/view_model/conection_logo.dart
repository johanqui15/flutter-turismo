import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prue/pages/login_pages/model/arguments_logo.dart';

class ConectionLogo {
  Future<ArgumentsLogo> getLogo() async {
    ArgumentsLogo argumentsLogo;
    try {
      if (Platform.isIOS) {
        print('Se actualiza');
        // final Uri url = Uri.parse('https://api.destinofusagasuga.gov.co/api/logo/last');
        final Uri url =
            Uri.parse('https://api.destinofusagasuga.gov.co/api/logo/last');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          return argumentsLogo =
              // ArgumentsLogo('https://api.destinofusagasuga.gov.co${json['link_logo']}');
              ArgumentsLogo(
                  'https://api.destinofusagasuga.gov.co${json['link_logo']}');
        }
        return argumentsLogo = ArgumentsLogo('nada');
      } else if (Platform.isAndroid) {
        print('is a Andriod');
        // final Uri url = Uri.parse('https://api.destinofusagasuga.gov.co/api/logo/last');
        final Uri url =
            Uri.parse('https://api.destinofusagasuga.gov.co/api/logo/last');
        final response =
            await http.get(url).timeout(const Duration(seconds: 4));

        if (response.statusCode == 200) {
          final body = utf8.decode(response.bodyBytes);
          final json = jsonDecode(body);

          return argumentsLogo =
              // ArgumentsLogo('https://api.destinofusagasuga.gov.co${json['link_logo']}');
              ArgumentsLogo(
                  'https://api.destinofusagasuga.gov.co${json['link_logo']}');
        } else {
          return argumentsLogo = ArgumentsLogo(
              'https://www.fusagasuga-cundinamarca.gov.co/Style%20Library/images/logo-header.png');
        }
      }
    } on TimeoutException catch (e) {
      return argumentsLogo = ArgumentsLogo(
          'https://www.fusagasuga-cundinamarca.gov.co/Style%20Library/images/logo-header.png');
    } catch (e) {
      print(e);
    }

    return argumentsLogo = ArgumentsLogo(
        'https://www.fusagasuga-cundinamarca.gov.co/Style%20Library/images/logo-header.png');
  }
}
