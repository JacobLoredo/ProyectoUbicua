import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/Producto.dart';
import 'package:proyectoubicua/Vistas/Home/CartaProdcuto.dart';
import 'package:proyectoubicua/Vistas/Home/home.dart';
import 'package:proyectoubicua/Vistas/Producto/productoVista.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'dart:convert';
import 'package:proyectoubicua/network_utils/api.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  List<Product> demoProducts = new List<Product>();

  Future<List<Product>> fetchProductos() async {
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
                  if (demoProducts[index].isPopular)
                    return ProductCard(
                      product: demoProducts[index],
                      press: () => Navigator.pushNamed(
                          context, MyProductoVistaClass.routeName,
                          arguments:
                              DetallesProducto(product: demoProducts[index])),
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
