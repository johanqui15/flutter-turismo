import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prue/pages/register_pages/view_model/conection_register_user.dart';
import 'package:prue/utilities/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final documentController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final birthDateController = TextEditingController();
  bool _passwordVisible = false;
  DateTime dateTime = DateTime(1998, 02, 17);
//To formatter the birth Date
  final maskFormatterBirthDate = MaskTextInputFormatter(
      mask: '####-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  String dropdownValue = 'Tarjeta de identidad';

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final widht = queryData.size.width;
    final allSize = widht + height;

    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/home/fondo_tres.png'),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.08),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: widht * 0.03),
                      child: Text(
                        'Registrarse',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: allSize * 0.02),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.2),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  children: [
                    //NOMBRE
                    Padding(
                      padding: EdgeInsets.fromLTRB(allSize * 0.04,
                          allSize * 0.04, allSize * 0.04, allSize * 0.01),
                      child: Container(
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              labelText: 'Nombres y Apellidos',
                              border: InputBorder.none),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    //CORREO ELECTRONICO
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          allSize * 0.04, 0, allSize * 0.04, allSize * 0.01),
                      child: Container(
                        height: height * 0.09,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: 'Correo electronico',
                              border: InputBorder.none),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          allSize * 0.04, 0, allSize * 0.04, allSize * 0.01),
                      child: Container(
                        width: widht,
                        child: Column(
                          children: [
                            Text('Tipo de documento'),
                            DropdownButton(
                              value: dropdownValue,
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  print(dropdownValue);
                                });
                              },
                              items: <String>[
                                'Tarjeta de identidad',
                                'Cedula de ciudadania',
                                'Cedula de extranjería',
                                'Pasaporte'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          allSize * 0.04, 0, allSize * 0.04, allSize * 0.01),
                      child: Container(
                        height: height * 0.09,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: documentController,
                          maxLength: 10,
                          decoration: const InputDecoration(
                              labelText: 'Documento', border: InputBorder.none),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          allSize * 0.04, 0, allSize * 0.04, allSize * 0.01),
                      child: Container(
                        width: widht,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'Fecha de nacimiento: ${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                              ElevatedButton(
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      locale: const Locale("es", "ES"),
                                      initialDate: dateTime,
                                      firstDate: DateTime(1930),
                                      lastDate: DateTime(2018),
                                    );

                                    if (newDate == null) return;

                                    setState(() {
                                      dateTime = newDate;
                                    });
                                  },
                                  child: Text('Cambiar la fecha')),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          allSize * 0.04, 0, allSize * 0.04, allSize * 0.01),
                      child: Container(
                        child: TextFormField(
                          showCursor: false,
                          maxLines: 1,
                          expands: false,
                          maxLength: 50,
                          controller: cityController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: 'Ciudad de residencia',
                              border: InputBorder.none),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          allSize * 0.04, 0, allSize * 0.04, allSize * 0.01),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText:
                              !_passwordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            border: InputBorder.none,
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print(documentController.text.toString());
                        nameController.text != null ||
                                emailController.text != null ||
                                documentController.text != null ||
                                cityController.text != null ||
                                passwordController.text != null
                            ? (documentController.text.length >= 6)
                                ? RegisterUser().registerUser(
                                    nameController.text.toString(),
                                    emailController.text.toString(),
                                    dropdownValue.toString(),
                                    documentController.text,
                                    dateTime.toString(),
                                    cityController.text.toString(),
                                    passwordController.text.toString(),
                                    context)
                                : Fluttertoast.showToast(
                                    msg: 'Segure que es tu documento?.',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor:
                                        Color.fromARGB(255, 229, 226, 226),
                                    textColor: Colors.black)
                            : Fluttertoast.showToast(
                                msg: 'Complete los campos.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor:
                                    Color.fromARGB(255, 229, 226, 226),
                                textColor: Colors.black);
                      },
                      child: const Text('Registrarse'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
