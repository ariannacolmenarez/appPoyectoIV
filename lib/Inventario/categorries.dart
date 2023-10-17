import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants.dart';
import 'CategoriasModel.dart';
import 'Inventario.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  Future<List<Categorias>>catFuture = getCategorias();

  static Future<List<Categorias>> getCategorias() async {
    const url = 'https://joseviveresmarket.000webhostapp.com/api/categorias';
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body.map<Categorias>(Categorias.fromJson).toList();


  }

  // Future<List<Categorias>> categories = catFuture;
  // By default our first item will be selected
  int selectedIndex = 0;
  int catId = 0;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: FutureBuilder<List<Categorias>>(
          future: catFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              final Categorias = snapshot.data!;
              return buildCat(Categorias);
            } else {
              return const Text('No hay productos en el inventario');
            }
          },
        ),
      ),
    );
  }

  Widget buildCat(List<Categorias> Categorias) =>
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Categorias.length,
        itemBuilder: (context, index) =>
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  catId=Categorias[index].id;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Categorias[index].categoria,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? kTextColor
                            : kTextLightColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: kDefaultPaddin / 4),
                      //top padding 5
                      height: 2,
                      width: 30,
                      color: selectedIndex == index ? Colors.black : Colors
                          .transparent,
                    )
                  ],
                ),
              ),
            ),
      );

}
