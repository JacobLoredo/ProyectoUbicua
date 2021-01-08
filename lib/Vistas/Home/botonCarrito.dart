import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/Carrito/CarritoVista.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';
//**Clase que construye un boton con el icono de carrito y la funcionalidad de redireccionar a otra vista */
class BotonCarrito extends StatelessWidget {
  const BotonCarrito({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.pushNamed(context,CarritoVista.routeName),
      child: Container(
        height: getProportionateScreenHeight(46),
        width: getProportionateScreenWidth(46),
        decoration: BoxDecoration(
          color: colores['gris'],
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}