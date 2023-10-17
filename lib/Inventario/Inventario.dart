

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_movil/constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../login/Login.dart';
import 'categorries.dart';
import 'Product.dart';
import 'item_card.dart';



class Inventario extends StatefulWidget {
  final int cantId;
  //Inventario(this.cantId, {super.key});
  const Inventario(this.cantId,{Key? key}):super(key: key);



  @override
  State<Inventario> createState() => _InventarioState();
}

class _InventarioState extends State<Inventario> {

  Future<List<Productos>>productFuture = getProducto();

  static Future<List<Productos>> getProducto() async {
     //print(cantId);

      const url = 'https://joseviveresmarket.000webhostapp.com/api/Inventario?opcion=';
      final response = await http.get(Uri.parse(url));

      final body = json.decode(response.body);
      return body.map<Productos>(Productos.fromJson).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market MP'),
        backgroundColor: Color(0xFFA4A4A4),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const ImageIcon(
            AssetImage('assets/images/market_1.png')
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                alerta();
              },
              icon: const Icon(Icons.list,
              ),color: kTextColor
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Inventario",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Categories(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: FutureBuilder<List<Productos>>(
                    future: productFuture ,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      } else if(snapshot.hasData){
                        final Productos = snapshot.data!;
                        return buildProducto(Productos);
                      }else{
                        return const Text('No hay productos en el inventario');
                      }
                    },
                ),
              ),
            ),
        ],
      ),
    );
  }
  Widget buildProducto(List<Productos> Productos) => GridView.builder(
    itemCount: Productos.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: kDefaultPaddin,
    crossAxisSpacing: kDefaultPaddin,
    childAspectRatio: 0.75,),
    itemBuilder: (context, index){
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${Productos[index].id}",
                child:  Image.network(Productos[index].url_img),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              Productos[index].nombre+' '+Productos[index].marca,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\Precio: ${Productos[index].precio_venta} bs",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "\Cant:${Productos[index].cantidad}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
    }
  );

  void alerta() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Cerrar sesion'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              ),
              child: const Text('Cerrar'),
            ),
          ],
        ));
  }


}

