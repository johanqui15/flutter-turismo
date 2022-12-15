import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/restaurant_pages/view/selected_restaurant_page.dart';
import 'package:prue/pages/home_pages/tourism/model/items_tourism_main.dart';

class MainTourism extends StatefulWidget {
  MainTourism({Key? key}) : super(key: key);

  @override
  State<MainTourism> createState() => _MainTourismState();
}

class _MainTourismState extends State<MainTourism> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final widht = queryData.size.width;
    final allSize = height + widht;
    final _items = [];
    List<ItemsTourismMain> _itemsMain = [
      ItemsTourismMain('assets/SERVICIOS TURISTICOS/1. HOTELES-16.png',
          'senderismo_page', height, widht, 1, 'Hoteles', context),
      ItemsTourismMain(
          'assets/SERVICIOS TURISTICOS/2. ALOJAMIENTO RURAL-16.png',
          'senderismo_page',
          height,
          widht,
          2,
          'Fincas',
          context),
      ItemsTourismMain(
          'assets/SERVICIOS TURISTICOS/3. CENTROS VACACIONALES-16.png',
          'senderismo_page',
          height,
          widht,
          3,
          'Centros Vacacionales',
          context),
      ItemsTourismMain('assets/SERVICIOS TURISTICOS/4. GLAMPING-16.png',
          'senderismo_page', height, widht, 4, 'Glamping y Camping', context),
      ItemsTourismMain('assets/SERVICIOS TURISTICOS/5. PARQUE TEMÁTICOS-16.png',
          'senderismo_page', height, widht, 5, 'Parques tematicos', context),
      ItemsTourismMain(
          'assets/SERVICIOS TURISTICOS/6. AGENCIAS DE VIAJE-16.png',
          'senderismo_page',
          height,
          widht,
          6,
          'Agencia de viajes y operadores',
          context),
      ItemsTourismMain('assets/SERVICIOS TURISTICOS/7. GUIAS DE TURISMO-16.png',
          'senderismo_page', height, widht, 7, 'Guias de turismo', context),
      ItemsTourismMain(
          'assets/SERVICIOS TURISTICOS/8.TRANSPORTE TURISTICO-16.png',
          'senderismo_page',
          height,
          widht,
          8,
          'Transporte turistico',
          context),
      ItemsTourismMain('assets/SERVICIOS TURISTICOS/9.RUTAS TURISTICAS-16.png',
          'senderismo_page', height, widht, 9, 'Rutas Turisticas', context),
    ];

    return Scaffold(
      body: Center(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/home/fondo_tres.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: widht * 0.02),
                  child: ButtonBack(widht, context),
                ),
                Spacer(),
                Text('Servicios Turisticos',
                    style: TextStyle(
                        fontSize: height * 0.030,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: height * 0.25),
              child: ListView.builder(
                  itemCount: _itemsMain.length,
                  itemBuilder: ((context, index) {
                    return cardTourism(
                        _itemsMain[index].imageRoute,
                        height,
                        widht,
                        _itemsMain[index].pushRoute,
                        _itemsMain[index].tipoTurismo,
                        _itemsMain[index].title,
                        context);
                  })))
        ]),
      ),
    );
  }
}

Widget cardTourism(String routeImage, double height, double widht,
    String routePush, int tipoTurismo, String title, BuildContext context) {
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
            height: height * 0.10,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              image: DecorationImage(
                  image: AssetImage(routeImage), fit: BoxFit.fill),
            ),
          ),
        ]),
        onTap: () {
          Navigator.pushNamed(context, routePush,
              arguments: {'tipo': tipoTurismo, 'title': title});
        },
      ),
    ),
  );
}
