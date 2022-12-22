import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:prue/utilities/colors.dart';

class MainHistory extends StatefulWidget {
  MainHistory({Key? key}) : super(key: key);

  @override
  State<MainHistory> createState() => _MainHistoryState();
}

class _MainHistoryState extends State<MainHistory> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final widht = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      backgroundColor: colorBackgroudScreens,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home/fondo_tres.png'),
                fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.06),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widht * 0.02),
                    child: ButtonBack(widht, context),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('Historia y Cultura',
                          style: TextStyle(
                              fontSize: height * 0.030,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      Text('¡Conoce Fusagasugá!',
                          style: TextStyle(
                              fontSize: height * 0.030,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ],
          )),
        ),

        //cards
        Padding(
          padding: EdgeInsets.only(top: height * 0.25),
          child: ListView(
            children: [
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                child: cardNuestraHistoria(context,
                    'assets/history/btn_nuestra_historia.png', height, widht),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 900),
                child: cardPersonajes(context,
                    'assets/history/btn_personajes.png', height, widht),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 1300),
                child: cardSimbolos(
                    context, 'assets/SÍMBOLOS-25.png', height, widht),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 1700),
                child: cardPatrimonio(context,
                    'assets/history/btn_patrimonio.png', height, widht),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget cardNuestraHistoria(BuildContext context, String backgroundImage,
      double height, double widht) {
    final sizeScreen = height + widht;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widht * 0.07, height * 0.02, widht * 0.07, height * 0.00),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          splashColor: Colors.orange,
          child: Stack(children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.fill),
              ),
            ),
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'historia_page');
          },
        ),
      ),
    );
  }

  Widget cardPersonajes(BuildContext context, String backgroundImage,
      double height, double widht) {
    final sizeScreen = height + widht;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widht * 0.07, height * 0.02, widht * 0.07, height * 0.00),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          splashColor: Colors.orange,
          child: Stack(children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.cover),
              ),
            ),
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'personajes_page');
          },
        ),
      ),
    );
  }

  Widget cardSimbolos(BuildContext context, String backgroundImage,
      double height, double widht) {
    final sizeScreen = height + widht;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widht * 0.07, height * 0.02, widht * 0.07, height * 0.00),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          splashColor: Colors.orange,
          child: Stack(children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.cover),
              ),
            ),
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'simbolos_page');
          },
        ),
      ),
    );
  }

  Widget cardPatrimonio(BuildContext context, String backgroundImage,
      double height, double widht) {
    final sizeScreen = height + widht;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widht * 0.07, height * 0.02, widht * 0.07, height * 0.00),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          splashColor: Colors.orange,
          child: Stack(children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.cover),
              ),
            ),
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'patrimonio_page');
          },
        ),
      ),
    );
  }
}
