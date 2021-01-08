import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/Carrito/BodyCarrito.dart';
import 'package:proyectoubicua/Vistas/Home/home.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/Widgets/boton.dart';
import 'package:proyectoubicua/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

//**Variable para actualizar el precio total */
double total = 0;
GlobalKey key = GlobalKey<CheckCarritoState>();
//**Clase para crear la vista del producto */
class CarritoVista extends StatefulWidget {
  static String routeName = "/carrito";

  const CarritoVista({Key key}) : super(key: key);

  @override
  _CarritoVistaState createState() => _CarritoVistaState();
}
//**Clase para crear el estado del carrito */
class _CarritoVistaState extends State<CarritoVista> {
  void initState() {
    super.initState();
  }

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
        bottomNavigationBar: CheckCarrito(
          key: key,
          
        ),
      ),
    );
  }
}
//**Clase para crear el boton de confirmar compra */
class CheckCarrito extends StatefulWidget {
  const CheckCarrito({
    Key key,
    
  }) : super(key: key);
 
  @override
  CheckCarritoState createState() => CheckCarritoState();
}
//**Clase para mostrar el precio y el botn de confirmarc ompra */
class CheckCarritoState extends State<CheckCarrito> {
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                  text: "Total: \n",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                        text: "\$${total.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ))
                  ]),
            ),
            SizedBox(
              width: getProportionateScreenWidth(190),
              child: MybuttonClass(
                text: "Comprar",
                press: () => confirmarCompra(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//**Funcion que hace la peticion API para confirmar la compra */
void confirmarCompra(BuildContext context) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  String t = localStorage.getString('token');
  var data = {'token': t.toString()};
  var res2 = await Network().usuario(data, '/getuser');
  var body2 = json.decode(res2.body);
  var data2 = {
    'name': "",
  };
  print(body2['user']['id']);
  var res = await Network()
      .eliminarproductos(data2, '/Compra/${body2['user']['id']}');
  var body = json.decode(res.body);
  print(body);
  if (body['success']) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Compra Realizada!!")));
   
     await Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => MyHomeClass(),
          ),
      );
  }
}
