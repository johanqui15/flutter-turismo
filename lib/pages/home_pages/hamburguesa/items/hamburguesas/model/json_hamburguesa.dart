import 'package:flutter/material.dart';

//Estructura api mostrar restaurantes

class HamburguesaStruct {
  int id;
  String restaurante;
  List urlImageHamburguesa;

  HamburguesaStruct(
    this.restaurante,
    this.urlImageHamburguesa,
    this.id,
  );
}
