import 'user.dart';
import 'voto.dart';
import 'package:prue/pages/home_pages/hamburguesa/items/hamburguesas/model/hamburguesa_selected_json.dart';

class Post {
  int? id;
  User? user;
  Festival? festival;

  Post({
    this.id,
    this.user,
    this.festival,
  });

// map json to post model

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        // conection: hamburguesaJSON(
        //   id: json ['hamburguesas']['id'],
        // ),
        user: User(
            id: json['user']['id'],
            name: json['user']['name'],
            email: json['user']['email']),
        festival: Festival(
          id: json['festival']['id'],
          voto: json['festival']['voto'],
        ));
  }
}
