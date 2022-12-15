import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:prue/pages/home_pages/coffee_pages/model/coffe_selected_argument.dart';
import 'package:prue/pages/home_pages/coffee_pages/model/coffee_arguments.dart';
import 'package:prue/pages/home_pages/coffee_pages/view/selected_coffee_page.dart';
import 'package:prue/pages/home_pages/coffee_pages/view_model/conection_coffe.dart';
import 'package:prue/utilities/colors.dart';

class HomeCoffePage extends StatefulWidget {
  const HomeCoffePage({Key? key}) : super(key: key);

  @override
  State<HomeCoffePage> createState() => _HomeCoffePageState();
}

class _HomeCoffePageState extends State<HomeCoffePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;

    final width = queryData.size.width;
    return Scaffold(
      backgroundColor: colorBackgroudScreens,
      // appBar: AppBar(

      //   title: const Text('Café'),
      //   backgroundColor: colorFondoImagenes,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/home/fondo_tres.png'),
                    fit: BoxFit.cover)),
          ),
          //TEXT TITLE RUTAS DEL CAFE
          Padding(
            padding: EdgeInsets.only(top: height * 0.06),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Ruta del café',
                  style: TextStyle(
                      fontSize: height * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            )),
          ),

          //BUTTON BACK
          Padding(
            padding: EdgeInsets.only(top: height * 0.09),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: height * 0.08),
            child: const Divider(
              height: 100,
              thickness: 1,
              color: Color.fromARGB(195, 255, 255, 255),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.08),
            child: Divider(
              endIndent: width * 0.35,
              indent: width * 0.35,
              height: 100,
              thickness: 5,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),

          //LIST CARD COFFE
          Padding(
            padding: EdgeInsets.only(top: height * 0.25),
            child: Center(
              child: FutureBuilder(
                future: ConectionCoffe().getDataCoffee(),
                builder: (context,
                    AsyncSnapshot<List<CoffeeArguments>> asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    print(asyncSnapshot.data!);
                    return ListView(
                        children: CardCoffee(asyncSnapshot.data!, context, height, width));
                  } else if (asyncSnapshot.hasError) {
                    return const Text('No se logró cargar la  informaciónón. 🙁');
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.amber,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> CardCoffee(List<CoffeeArguments> data, BuildContext context, double heigth, double width) {
  List<Widget> items = [];

  
  data.forEach((element) {
    items.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: heigth * 0.2,
                width:  width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      image: NetworkImage(mostrar(element.imagen)), fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/gif/loading.gif'),
                    ),
                  ),
                ),
              ),
             
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //name Restaurant
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      element.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Restaurant Location
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/restaurants/ubication.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            //TEXTO DIRECCION
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 5.0,
                                maxWidth: 130.0,
                                minHeight: 30.0,
                                maxHeight: 100.0,
                              ),
                              child: AutoSizeText(
                                element.direccion,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //MENU CAFE
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/restaurants/diswish.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //TEXTO DEL MENU
                        Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 5.0,
                                maxWidth: 130.0,
                                minHeight: 30.0,
                                maxHeight: 100.0,
                              ),
                              child: ExpandableText(
                                element.menu,
                                expandText: 'Ver más',
                                collapseText: 'Ver menos',
                                maxLines: 2,
                                animation: true,
                                linkColor: Colors.blue,
                              ),
                              // AutoSizeText(
                              //   element.servicios,
                              //   style: TextStyle(fontSize: 14.0),
                              // ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  //Pets
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(element.pagos_digitales == 1
                                      ? 'assets/coffee/pago_activo.png'
                                      : 'assets/coffee/pago_inactivo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 5.0,
                                maxWidth: 130.0,
                                minHeight: 30.0,
                                maxHeight: 100.0,
                              ),
                              child: ExpandableText(
                                element.pagos_digitales == 1
                                    ? 'Pagos Digitales'
                                    : 'No tiene pagos digitales',
                                style: TextStyle(
                                    color: element.pagos_digitales == 1
                                        ? Colors.black
                                        : Colors.grey),
                                expandText: 'Ver más',
                                collapseText: 'Ver menos',
                                maxLines: 2,
                                animation: true,
                                linkColor: Colors.blue,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  //place Text('Corregimiento aguadita'),
                  //                     Text('Se aceptan mascotas'),
                  //  Icon(Icons.location_on, color: Colors.blueAccent,),
                  //                             Icon(Icons.food_bank_outlined, color: Colors.blue,),
                  //                             Icon(Icons.pets, color: Colors.blue,),
                ],
              ))
            ],
          ),
          onTap: () {
            //SEND ID_RES TO SELECTED RESTAURANT PAGE
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SelectedCoffePage(
                        coffeSelectedArgument:
                            CoffeSelectedArgument(element.id_cafe)))));
          },
        ),
      ),
    ));
  });
  return items;
}

//ARRAY PARA PODER MOSTRAR UNA IMAGEN
String mostrar(List lista) {
  List data;
  String imagen = '';
  data = lista;
  data.forEach((element) {
    imagen = element;
    print('---------- ${imagen}');
  });

  return imagen;
}
