class Registro {
  String restaurante;
  String user;
  String voto;

  Registro({required this.user, required this.restaurante, required this.voto});

  factory Registro.fromJson(Map<String, dynamic> json) {
    if (json['restaurante'] == null) {
      json['restaurante'] = "Almacen";
    }

    return Registro(
      user: json['user'] as String,
      restaurante: json['restaurante'] as String,
      voto: json['voto'] as String,
    );
  }

  Registro.fromMap(Map<String, dynamic> item)
      : user = item["user"],
        restaurante = item["restaurante"],
        voto = item["voto"];

  Map<String, Object> toMap() {
    return {'user': user, 'restaurante': restaurante, 'voto': voto};
  }
}
