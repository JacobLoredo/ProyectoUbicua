import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/Carrito/BodyCarrito.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/Widgets/boton.dart';
import 'package:proyectoubicua/main.dart';

class CarritoVista extends StatelessWidget {
  static String routeName = "/carrito";
  const CarritoVista({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(
                "Tu carrito",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        body: BodyCarrito(),
        bottomNavigationBar: CheckCarrito(),
      ),
    );
  }
}

class CheckCarrito extends StatelessWidget {
  const CheckCarrito({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(text: "Total: \n",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              children: [
                TextSpan(text: "\$7545",style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ))
              ]
              ),
              
            ),
            SizedBox(
              width: getProportionateScreenWidth(190),
              child: MybuttonClass(
                text: "Comprar",
                press: (){},
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
