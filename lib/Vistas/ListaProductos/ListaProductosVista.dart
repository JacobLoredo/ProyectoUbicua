import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/Home/barraBusqueda.dart';
import 'package:proyectoubicua/Vistas/Home/botonCarrito.dart';
import 'package:proyectoubicua/Vistas/ListaProductos/ListProductos.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';

class ListaProductos extends StatefulWidget {
   static String routeName = "/ListaProductos";
  const ListaProductos({Key key}) : super(key: key);

  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: <Widget>[
          BarraBusqueda(),
          BotonCarrito(),
        ],
        backgroundColor: colores['naranja'],
      ),
      body: SingleChildScrollView(
              child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20),
                  vertical: getProportionateScreenHeight(2),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    
                    ListProducts(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}