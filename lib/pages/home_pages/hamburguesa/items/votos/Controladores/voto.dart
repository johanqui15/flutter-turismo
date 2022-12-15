import 'dart:ffi';

class Festival {
  int id;
  Bool? voto;

  Festival({
    required this.id,
    this.voto,
  });

  // function to convert json data to user model
  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      id: json['festival']['id'] as int,
      voto: json['festival']['voto'],
    );
  }
}
