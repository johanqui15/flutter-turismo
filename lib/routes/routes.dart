import 'package:flutter/material.dart';
import 'package:prue/main.dart';
import 'package:prue/pages/home_pages/coffee_pages/view/home_coffee_page.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/votos/vistas/votoshome.dart';
// import 'package:prue/pages/home_pages/hamburguesa/items/hamburguesas/view/main_hamburguesas.dart';
import 'package:prue/pages/home_pages/hamburguesa/view/main_hamburguesa.dart';
import 'package:prue/pages/home_pages/history_pages/items/historia/view/historia_page.dart';
import 'package:prue/pages/home_pages/history_pages/items/patrimonio/view/patrimonio_page.dart';
import 'package:prue/pages/home_pages/history_pages/items/patrimonio/view/patrimonio_select_page.dart';
import 'package:prue/pages/home_pages/history_pages/items/personajes/view/main_personajes.dart';
import 'package:prue/pages/home_pages/history_pages/items/personajes/view/selected_personaje.dart';
import 'package:prue/pages/home_pages/history_pages/items/simbolos/view/main_simbolos.dart';

import 'package:prue/pages/home_pages/history_pages/view/main_history.dart';
import 'package:prue/pages/home_pages/home_page.dart';
import 'package:prue/pages/home_pages/masfusa/view/main_MasFusa.dart';
import 'package:prue/pages/home_pages/hamburguesa/view/main_hamburguesa.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/main_restaurant_page.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/route_restaurant.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/videogastronomia.dart';
import 'package:prue/pages/home_pages/senderismo_pages/view/selected_senderismo.dart';
import 'package:prue/pages/home_pages/senderismo_pages/view/senderimos_page.dart';
import 'package:prue/pages/home_pages/servicios/view/main_servicios.dart';
import 'package:prue/pages/home_pages/tourism/view/main_tourism.dart';
import 'package:prue/pages/login_pages/login_page.dart';
import 'package:prue/pages/login_pages/recover_password.dart';
import 'package:prue/pages/register_pages/view/register_page.dart';

import '../pages/home_pages/hamburguesa/items/hamburguesas/view/main_hamburguesasres.dart';

//MAP WITH ROUTES TO PAGES
Map<String, WidgetBuilder> showRoutes() {
  return {
    'register': (context) => const RegisterPage(),
    'login': (context) => LoginPage(),
    'recover_password': (context) => RecoverPassword(),
    'home_page': (context) => HomePage(
          token: '',
        ),
    'Hamburguesa_page': (context) => MainHamburguesa(),
    'MasFusa_page': (context) => MainMasFusa(),
    'servicios_page': (context) => MainServicePage(),
    'gastronomia_page': (context) => MainRestaurantPage(),
    'history_page': (context) => MainHistory(),
    'personajes_page': (context) => const MainPersonajes(),
    'video_gastronomia': (context) => const VideoGastronomia(),
    'selected_personaje': (context) => SelectedPersonaje(),
    'simbolos_page': (context) => const MainSimbolos(),
    'patrimonio_page': (context) => PatrimonioPage(),
    'historia_page': (context) => HistoriaPage(),
    'hamburguesares_page': (context) => MainHamburguesaRes(),
    'votos_page': (context) => VotosHomePage(),

    //'route_restaurant':(context) => RouteRestaurant(linkRuta: '',),
    'home_coffee_page': (context) => const HomeCoffePage(),
    'senderismo_page': (context) => SenderismoPage(),
    'selected_senderismo': (context) => SelectedSenderismo(),
    'tourism_page': (context) => MainTourism(),
    'patrimonio_select': (context) => PatrimonioSelectPage(),
    'main_app': (context) => MyApp(),
    //'selected_restaurant_page':(context) => SelectedRestaurantePage(),
  };
}
