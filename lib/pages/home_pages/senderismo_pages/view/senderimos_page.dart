import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prue/pages/home_pages/senderismo_pages/model/arguments_senderismo.dart';
import 'package:prue/pages/home_pages/senderismo_pages/viewmodel/connection_senderismo.dart';
import 'package:prue/utilities/colors.dart';

class SenderismoPage extends StatefulWidget {


  SenderismoPage({

    Key? key}) : super(key: key);

  @override
  State<SenderismoPage> createState() => _SenderismoPageState();

}

class _SenderismoPageState extends State<SenderismoPage> {
    




  @override
  Widget build(BuildContext context) {
        final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
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
                  arguments['title'],
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
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),

          //LIST CARD
          Padding(
            padding: EdgeInsets.only(top: height * 0.22),
            child: Center(
              child: FutureBuilder(
                
                future: ConnectionSenderismo().getSenderismo(arguments['tipo']),
                builder: (context,
                    AsyncSnapshot<List<ArgumentsSenderismo>> asyncSnapshot) {
                    
                     if (asyncSnapshot.connectionState == ConnectionState.done) {
                       if (asyncSnapshot.hasData) {
                    print(asyncSnapshot.data!);
                    return ListView(  
                        children: CardSenderismo(asyncSnapshot.data!, context));
                  } else if (asyncSnapshot.hasError) {
                    return const Text('No se logró cargar la  informaciónón. 🙁');
                  }
                     }else{
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

Widget IconosAcceso(int cicla, int moto, int carro, int caminando) {
  IconData iconCicla, iconMoto, iconCarro, iconCaminando;

  if (cicla == 1) {
    iconCicla = Icons.directions_bike_rounded;
  } else {}
  if (moto == 1) {
    iconMoto = Icons.motorcycle_rounded;
  }
  if (carro == 1) {
    iconCarro = FontAwesomeIcons.car;
  }
  if (caminando == 1) {
    iconCaminando = FontAwesomeIcons.personWalking;
  }

  return Row(children: [
    caminando == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.personWalking, color: Colors.blue),
          )
        : const SizedBox(),
    cicla == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.personBiking, color: Colors.blue),
          )
        : const SizedBox(),
    moto == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.motorcycle, color: Colors.blue),
          )
        : const SizedBox(),
    carro == 1
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.car, color: Colors.blue),
          )
        : const SizedBox(),
  ]);
}

List<Widget> CardSenderismo(
    List<ArgumentsSenderismo> data, BuildContext context) {
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      image: NetworkImage(mostrar(element.imagenes)),
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

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 5.0,
                      maxWidth: 130.0,
                      minHeight: 30.0,
                      maxHeight: 100.0,
                    ),
                    child: AutoSizeText(
                      element.caracteristica,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),

                  IconosAcceso(element.cicla, element.moto, element.carro,
                      element.caminando),
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


            Navigator.pushNamed(context, 'selected_senderismo',
                arguments: ArgumentsSenderismo(
                    element.id,
                    element.nombre,
                    element.descripcion,
                    element.caracteristica,
                    element.link_ubicacion,
                    element.caminando,
                    element.cicla,
                    element.moto,
                    element.carro,
                    element.tipo_turismo,
                    element.imagenes));
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

//  SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Center(
//             child: Row(
//               children: [CaracteristicasFusa()],
//             ),
//           )),
Widget CaracteristicasFusa() {
  Map<String, IconData> mapListaItems = {};
  List<Widget> lista = [];
  Map<IconData, String> mapCaracteristicas = {
    Icons.flag: 'Colombia',
    Icons.person_pin_circle_sharp: 'Fusagasugueños',
    Icons.people_outline: '147.631 habitantes',
    Icons.emoji_nature_outlined: 'Ciudad Jardín',
  };

  mapCaracteristicas.forEach((key, value) {
    lista.add(Padding(
      padding: EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent)),
          onPressed: () {},
          icon: Icon(key, size: 18),
          label: Text(value)),
    ));
  });
  return Row(children: lista);
}
