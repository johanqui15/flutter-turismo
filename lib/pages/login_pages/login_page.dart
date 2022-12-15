import 'package:flutter/material.dart';
import 'package:prue/pages/login_pages/model/arguments_logo.dart';
import 'package:prue/pages/login_pages/view_model/conect_login.dart';
import 'package:prue/pages/login_pages/view_model/conection_logo.dart';
import 'package:prue/utilities/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool _passwordVisible = false;
//L,IMPIAMOS EL CONTROLADOR CUANDO SE DESCARTE EL WIDGET
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  String location = 'Null, Press Button';
  // ignore: non_constant_identifier_names
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: colorFondoImagenes,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home/fondo_tres.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _inputEmail(email),
                  _inputPassword(password),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [_backPasswordButton()],
                  ),
                  _loginButton(email, password),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagenLogo(BuildContext context) {
    return FutureBuilder(
      future: ConectionLogo().getLogo(),
      builder: (context, AsyncSnapshot<ArgumentsLogo> asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          return SafeArea(
            child: SizedBox(
              width: 25.0,
              child: Container(
                color: colorBackgroudScreens,
                child: Image(
                  image: NetworkImage(asyncSnapshot.data!.link_logo),
                  width: 15,
                  height: 100,
                ),
              ),
            ),
          );
        } else {
          return SafeArea(
            child: SizedBox(
              width: 25.0,
              child: Container(
                color: colorBackgroudScreens,
                child: Image.asset(
                  'assets/home/icono_blanco_ubicacion.png',
                  width: 10,
                  height: 170,
                ),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

//INPUTS
  Widget _inputEmail(TextEditingController controllerEmail) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controllerEmail,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          labelText: 'Email',
          hintText: 'fusagasuga@cundinamarca.co',
          //counterText: '${_email.length}',
          //icon: Image.asset('assets/home/user.png', width: 50, height: 50,),
          icon: const Icon(
            Icons.person,
            color: colorFondoImagenes,
          ),
        ),
        onChanged: (data) {
          setState(() {
            print(controllerEmail.text);
          });
        },
      ),
    );
  }

//WIDGET  INPUT PASSWORD
  Widget _inputPassword(TextEditingController controllerPassword) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 65,
        child: TextField(
            controller: controllerPassword,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: '*******',
              labelText: 'Contraseña',
              suffix: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              icon: const Icon(
                Icons.lock,
                color: colorFondoImagenes,
              ),
            ),
            onChanged: (data) {
              setState(() {
                print(controllerPassword.text);
              });
            }),
      ),
    );
  }

  Widget _backPasswordButton() {
    return TextButton(
      child: const Text(
        'Olvidé mi contraseña 🙁',
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () async {
        //Navigator.pushNamed(context, 'recover_password');
        // final Uri uri = Uri.parse('https://destinofusagasuga.gov.co/forgot-password');
        final Uri uri =
            Uri.parse('https://api.destinofusagasuga.gov.co/forgot-password');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
    );
  }

  Widget _loginButton(
      TextEditingController email, TextEditingController password) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Iniciar Sesión',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            Image.asset('assets/home/user_login.png')
          ],
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                const StadiumBorder()),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(43, 176, 193, 1.0)),
            elevation: MaterialStateProperty.all<double>(10.0),
            minimumSize: MaterialStateProperty.all(const Size(180, 50)),
            fixedSize: MaterialStateProperty.all(const Size(100, 36)),
            overlayColor: MaterialStateProperty.all(Colors.blueAccent)),
        onPressed: () async {
          if (email.text != '' && password.text != '') {
            ConectionLogin().startLogin(email.text, password.text, context);
            Position position = await _getGeoLocationPosition();
            location =
                'Lat: ${position.latitude} , Long: ${position.longitude}';
            GetAddressFromLatLong(position);
          }
        },
      ),
    );
  }
}
