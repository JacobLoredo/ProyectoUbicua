import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/CategoriaP.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';
import 'package:proyectoubicua/network_utils/api.dart';

class Categorias extends StatefulWidget {
  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  List<CategoriP> demoCategorias = new List<CategoriP>();
  int usuario1;
  Future<List<CategoriP>> fetchProductos() async {
    var categorias = new List<CategoriP>();
    var res = await Network().productos('/listcategorias');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      for (var produ in body['categorias']) {
        categorias.add(CategoriP.fromJson(produ));
      }

      return categorias;
    } else {
      throw Exception('Failed to load Producto');
    }
  }

  @override
  void initState() {
    fetchProductos().then((value) {
      setState(() {
        demoCategorias.addAll(value);
      });
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categorias = [
      {"icon": Icon(Icons.local_restaurant_outlined,color: colores['naranja'],), "text": "Flash Deal"},
      {"icon": Icon(Icons.wine_bar_outlined,color: colores['naranja']), "text": "Bill"},
      {"icon": Icon(Icons.local_drink_rounded,color: colores['naranja']), "text": "Game"},
      {"icon": Icon(Icons.medical_services_outlined,color: colores['naranja']), "text": "Daily Gift"},
      {"icon": Icon(Icons.restaurant_rounded), "text": "More"},
    ];
    
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          demoCategorias.length,
          (index) => CategoryCard(
            icon: categorias[index]["icon"],
            text: demoCategorias[index].nombre,
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              
              child: icon,
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center,maxLines: 2,)
          ],
        ),
      ),
    );
  }
}
