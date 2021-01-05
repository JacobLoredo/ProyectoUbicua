import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/Producto.dart';
import 'package:proyectoubicua/Models/Usuario.dart';
import 'package:proyectoubicua/Vistas/Home/CartaProdcuto.dart';
import 'package:proyectoubicua/Vistas/Home/home.dart';
import 'package:proyectoubicua/Vistas/Producto/productoVista.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'dart:convert';
import 'package:proyectoubicua/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  List<Product> demoProducts = new List<Product>();
  int usuario1;
  Future<List<Product>> fetchProductos() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String t = localStorage.getString('token');
    var data = {'token': t.toString()};

    // localStorage.setString('token', json.encode(body['token']));
    var usuario = new List<Usuario>();
    var res2 = await Network().usuario(data, '/getuser');
    var body2 = json.decode(res2.body);
    usuario1 = body2['user']['id'];
    var productos = new List<Product>();
    var res = await Network().productos('/listproductos');
    var body = json.decode(res.body);

    if (body['success']) {
      for (var produ in body['productos']) {
        productos.add(Product.fromJson(produ));
      }

      return productos;
    } else {
      throw Exception('Failed to load Producto');
    }
  }

  @override
  void initState() {
    fetchProductos().then((value) {
      setState(() {
        demoProducts.addAll(value);
      });
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    Random random = new Random();
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: TituloSeccion(text: "Populares", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  demoProducts[index].isPopular=random.nextBool();
                  if (demoProducts[index].cantidad>0&&demoProducts[index].isPopular)
                    return ProductCard(
                      product: demoProducts[index],
                      press: () => Navigator.pushNamed(
                          context, MyProductoVistaClass.routeName,
                          arguments: DetallesProducto(
                              product: demoProducts[index], idUser: usuario1)),
                    );

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
