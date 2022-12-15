import 'package:flutter/material.dart';

//Estructura api mostrar restaurantes

class RestaurantStruct {
  int idRes;
  String nombre;
  String location;
  String horario_atencion;
  List urlImageRestaurante;
  String platoPrincipal;
  int mascota;

  RestaurantStruct(this.nombre, this.location, this.horario_atencion,
      this.urlImageRestaurante, this.platoPrincipal, this.idRes, this.mascota);
}
