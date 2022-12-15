import 'package:flutter/material.dart';

class RecoverPassword extends StatefulWidget {
  RecoverPassword({Key? key}) : super(key: key);

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contrasenia')),
    );
  }
}
