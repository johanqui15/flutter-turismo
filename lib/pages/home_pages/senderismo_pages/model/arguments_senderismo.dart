class ArgumentsSenderismo {
  int id;
  String nombre;
  String descripcion;
  String link_ubicacion;
  String caracteristica;
  List imagenes;
  int cicla;
  int carro;
  int moto;
  int caminando;
  int tipo_turismo;

  ArgumentsSenderismo(
      this.id,
      this.nombre,
      this.descripcion,
      this.caracteristica,
      this.link_ubicacion,
      this.caminando,
      this.cicla,
      this.moto,
      this.carro,
      this.tipo_turismo,
      this.imagenes);
}
