import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/Producto.dart';
import 'package:proyectoubicua/Vistas/Producto/DetallesProducto.dart';
import 'package:proyectoubicua/Vistas/Producto/ProductoImagen.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/Widgets/boton.dart';
import 'package:proyectoubicua/main.dart';

class Body extends StatelessWidget {
  final Product product;
  const Body({Key key, @required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductoImagen(product: product),
          DetallesProducto(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "\$${product.price}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(64),
                  ),
                  child: Text(
                    product.description,
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(180),
                        ),
                        Text(
                          "Ver más detalles",
                          style: TextStyle(
                            color: colores['naranja'],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 14,
                          color: colores['naranja'],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          MybuttonClass(
            text: "Agregar al Carrito",
            press: () {},
          ),
        ],
      ),
    );
  }
}
