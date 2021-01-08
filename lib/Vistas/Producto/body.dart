import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/Producto.dart';
import 'package:proyectoubicua/Vistas/Producto/DetallesProducto.dart';
import 'package:proyectoubicua/Vistas/Producto/ProductoImagen.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/Widgets/boton.dart';
import 'package:proyectoubicua/main.dart';
import 'package:proyectoubicua/network_utils/api.dart';
//**Clase Body para la vista de un producto individual */
class Body extends StatefulWidget {
  //**Producto de la vista */
  final Product product;
  //**Id del usuario que esta en la aplicacion*/
  final int user;
  //**Constructor del boby */
  const Body({Key key, @required this.product, @required this.user})
      : super(key: key);
//**Creacion del estado del body */
  @override
  _BodyState createState() => _BodyState();
}
//**Clase que construye todos los elementos para mostrar en el body de la vista */
class _BodyState extends State<Body> {
  int maxl = 4;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductoImagen(product: widget.product),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Disponible: ${widget.product.cantidad}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          DetallesProducto(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "\$${widget.product.price}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    widget.product.title,
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
                    widget.product.description,
                    maxLines: maxl,
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
            height: 30,
          ),
          MybuttonClass(
            text: "Agregar al Carrito",
            press: () =>
                agregarCarrito(context, widget.user, widget.product.id),
          ),
        ],
      ),
    );
  }
}
 //**Funcion que hace la peticion a la API para dar de alta el producto en tu carrito */
void agregarCarrito(BuildContext context, int user, int producto) async {
  var data = {
    'name': "",
  };
  var res = await Network().agregarproductos(data, '/carrito/$user/$producto');
  var body = json.decode(res.body);
  print(body);
  if (body['success']) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Agregado con exito!!")));
  }
}
