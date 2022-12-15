import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:prue/utilities/colors.dart';

class MainHamburguesa extends StatefulWidget {
  MainHamburguesa({Key? key}) : super(key: key);

  @override
  State<MainHamburguesa> createState() => _MainHamburguesaState();
}

class _MainHamburguesaState extends State<MainHamburguesa> {
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
                image:
                    AssetImage('assets/BurguerFestival/fondo_participa-24.png'),
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
                      // Text('BURGUER FESTIVAL',
                      //     style: TextStyle(
                      //         fontSize: height * 0.030,
                      //         fontWeight: FontWeight.w500,
                      //         color: Colors.white)),
                      // Text('¡Participa de este festival!',
                      //     style: TextStyle(
                      //         fontSize: height * 0.030,
                      //         fontWeight: FontWeight.w500,
                      //         color: Colors.white)),
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
          padding: EdgeInsets.only(top: height * 0.42),
          child: ListView(
            children: [
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                child: cardHamburguesaRes(
                    context,
                    'assets/BurguerFestival/boton_res_participantes-22.png',
                    height,
                    widht),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 1300),
                child: cardVotos(context,
                    'assets/BurguerFestival/boton_votos-22.png', height, widht),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget cardHamburguesaRes(BuildContext context, String backgroundImage,
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
            Navigator.pushNamed(context, 'hamburguesares_page');
          },
        ),
      ),
    );
  }

  Widget cardVotos(BuildContext context, String backgroundImage, double height,
      double widht) {
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
            Navigator.pushNamed(context, 'votos_page');
          },
        ),
      ),
    );
  }
}
