import 'package:flutter/material.dart';

//Estructura api mostrar

class ServiceStruct {
  int id;
  String nombre;
  String direccion;
  String telefono;
  String horario;
  String link;
  String description;
  String tiposservicio;
  List urlImagenes;

  ServiceStruct(
    this.id,
    this.nombre,
    this.direccion,
    this.telefono,
    this.horario,
    this.link,
    this.description,
    this.tiposservicio,
    this.urlImagenes,
  );
}
