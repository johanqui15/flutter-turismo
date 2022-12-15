import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/home_page.dart';

import 'package:prue/pages/login_pages/model/arguments_logo.dart';
import 'package:prue/pages/login_pages/view_model/conection_logo.dart';
import 'package:prue/routes/routes.dart';
import 'package:prue/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//b694e074ee4176c686174558cbd7ea43
//id   a2190a0f
// void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  void initState() {}
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  State<MyApp> createState() => _MyAppState();
  MyApp({Key? key}) : super(key: key);
}

class _MyAppState extends State<MyApp> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  var onBoarding;

  @override
  void initState() {
    // TODO: implement initState

    sendLogin();

    GetOnBoardingScreeens();
    super.initState();
  }

  Future<void> sendLogin() async {
    await analytics.logEvent(name: "Aplicación_abierta", parameters: {
      "Inicio": "Si",
    });
  }

  Future<bool> GetOnBoardingScreeens() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('onboarding') != null) {
      onBoarding = preferences.getBool('onboarding')!;
      return onBoarding;
    } else {
      onBoarding = false;
      return onBoarding;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Destino Fusagasugá',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FutureBuilder(
          future: GetOnBoardingScreeens(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data == true ? MainView() : OnboardingViews();
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
            );
          })),
      initialRoute: '/',
      routes: showRoutes(),
    );
  }
}

Widget Screen(bool on) {
  return on ? MainView() : OnboardingViews();
}

class MainView extends StatefulWidget {
  const MainView({
    Key? key,
  }) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    ShowSession();
    ShowToken();
    super.initState();
  }

  var getStatusLogin;
  var getToken;

  Future<bool> ShowSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    getStatusLogin = await prefs.getBool('estado_sesion');

    print('SESIONNNNNNN ----------- $getStatusLogin');

    if (prefs.getBool('estado_sesion') != null) {
      getStatusLogin = prefs.getBool('estado_sesion')!;
      return getStatusLogin;
    } else {
      getStatusLogin = false;
      return getStatusLogin;
    }
    //pref.clear();
  }

  Future<void> ShowToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getToken = await prefs.getString('token');
    getStatusLogin = await prefs.getBool('estado_sesion');
    print('MAIN ==== $getToken');
    print('SESIONNNNNNN main ----------- $getStatusLogin');

    //pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ShowSession(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print('TENEMOS SESION INICIADA');
          return snapshot.data == true
              ? HomePage(token: getToken != null ? getToken : 'empty')
              : ViewStartLogin();
        } else {
          print('NO TENEMOS SESION INICIADA');
          return ViewStartLogin();
        }
      },
    );
  }
}

class ViewStartLogin extends StatelessWidget {
  const ViewStartLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home/fondo_uno.png'),
                fit: BoxFit.cover)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.05),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/home/icono_blanco_ubicacion.png',
                        width: 100,
                        height: 170,
                      ),
                      const Text(
                        'Destino Fusagasugá',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 26),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ButtonHome(
                      titleButton: 'Inicia sesión',
                      colorButton: Color.fromRGBO(43, 176, 193, 1.0),
                      colorFont: Colors.white,
                      route: 'login',
                    ),
                    ButtonHome(
                      titleButton: 'Registrate',
                      colorButton: Colors.white,
                      colorFont: Colors.black,
                      route: 'register',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(width: 25.0, child: imagenLogo(context)),
      ),
    );
  }
}

Widget imagenLogo(BuildContext context) {
  return FutureBuilder(
    future: ConectionLogo().getLogo(),
    builder: (context, AsyncSnapshot<ArgumentsLogo> asyncSnapshot) {
      // print('ESTO HAYYYYY ${asyncSnapshot.data!.link_logo}');

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
      } else if (asyncSnapshot.hasError) {
        return SafeArea(
          child: SizedBox(
            width: 25.0,
            child: Container(
              color: colorBackgroudScreens,
              child: Image(
                image: AssetImage('assets/logo_alcaldia.png'),
                width: 15,
                height: 100,
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

//Buttons
class ButtonHome extends StatelessWidget {
  final String titleButton;
  final Color colorButton;
  final Color colorFont;
  final String route;
  const ButtonHome({
    Key? key,
    this.titleButton = '',
    this.colorButton = Colors.transparent,
    this.colorFont = Colors.transparent,
    this.route = 'register',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextButton(
          child: Text(
            titleButton,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            //backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(43, 176, 193, 1.0)),
            backgroundColor: MaterialStateProperty.all<Color>(this.colorButton),
            minimumSize: MaterialStateProperty.all(Size(180, 50)),
            fixedSize: MaterialStateProperty.all(Size(100, 36)),
            foregroundColor: MaterialStateProperty.all<Color>(this.colorFont),
            overlayColor: MaterialStateProperty.all<Color>(Colors.yellow),
            elevation: MaterialStateProperty.all<double>(10.0),

            shape: MaterialStateProperty.all<OutlinedBorder>(
                const StadiumBorder()),
          ),
          onPressed: () {
            // Navigator.of(context).pop();
            FirebaseAnalytics analytics = FirebaseAnalytics.instance;
            Future<void> sendLogin() async {
              await analytics.logEvent(name: "Aplicación_abierta", parameters: {
                "Inicio": "Si",
              });
            }

            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }
}

class OnboardingViews extends StatelessWidget {
  Future<void> SaveOnboardingScreens(bool onboarding) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print('SE VA A GUARDAR $onboarding');
    await preferences.setBool('onboarding', onboarding);
  }

  OnboardingViews({Key? key}) : super(key: key);
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final data = [
      'assets/onboarding1.png',
      'assets/onboarding2.png',
      'assets/onboarding3.png',
    ];

    return Scaffold(
      extendBody: true,
      body: PageView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: data.length,
        controller: controller,
        itemBuilder: ((context, index) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(data[index]), fit: BoxFit.cover)),
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: previousPage,
              child: const Icon(Icons.swipe_left),
              backgroundColor: colorGreen,
            ),
            const Spacer(),
            FloatingActionButton(
              heroTag: 'btn2',
              onPressed: (() {
                if (controller.page!.toInt() == 2) {
                  SaveOnboardingScreens(true);
                  Navigator.popAndPushNamed(context, 'main_app');
                  // Navigator.push(context, MaterialPageRoute(builder:(context) => const MainView()));

                }

                controller.animateToPage(controller.page!.toInt() + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              }),
              child: const Icon(Icons.swipe_right_rounded),
              backgroundColor: colorVerdeAzulado,
            )
          ],
        ),
      ),
    );
  }

  void previousPage() {
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
