class RestaurantSelectedJSON {
  int id_res;
  String nombre;
  String direccion;
  String telefono;
  String horarioAtencion;
  List linkFoto;
  String linkRuta;
  String tipoRestaurante;
  String nombrePlato;
  String descripcionPlato;
  List linkFotoPlato;
  int mascota;

  RestaurantSelectedJSON(
      this.id_res,
      this.nombre,
      this.direccion,
      this.telefono,
      this.horarioAtencion,
      this.linkFoto,
      this.linkRuta,
      this.tipoRestaurante,
      this.nombrePlato,
      this.descripcionPlato,
      this.linkFotoPlato,
      this.mascota);
}
