import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/Producto.dart';
import 'package:proyectoubicua/Vistas/Home/botonCarrito.dart';
import 'package:proyectoubicua/Vistas/Producto/body.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';

class MyProductoVistaClass extends StatefulWidget {
  const MyProductoVistaClass({Key key}) : super(key: key);
  static String routeName = "/productoVista";

  @override
  _MyProductoVistaClassState createState() => _MyProductoVistaClassState();
}

class _MyProductoVistaClassState extends State<MyProductoVistaClass> {
  @override
  Widget build(BuildContext context) {
    final DetallesProducto arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        centerTitle:true ,
        title: Text(
          "Producto",
          style:TextStyle(fontSize: 30,color:Colors.white,fontWeight: FontWeight.bold),
          
        ),
       
        backgroundColor: colores['naranja'],
        leading: SizedBox(
          height: getProportionateScreenWidth(40),
          width: getProportionateScreenHeight(40),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: BotonReturn(
              icon: Icons.arrow_back,
              press: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Body(product: arguments.product,user: arguments.idUser,),
    );
  }
}

class BotonReturn extends StatelessWidget {
  const BotonReturn({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);
  final IconData icon;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      
      onPressed: press,
      child: Icon(this.icon),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    );
  }
}

class DetallesProducto {
  final Product product;
  final int idUser;
  DetallesProducto({@required this.product,@required this.idUser,});
}
