import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/Carrito/CarritoVista.dart';
import 'package:proyectoubicua/Vistas/ListaProductos/ListaProductosVista.dart';
import 'package:proyectoubicua/Vistas/Login/contrasenaolvidada/contrasenaolvidada.dart';
import 'package:proyectoubicua/Vistas/Home/home.dart';
import 'package:proyectoubicua/Vistas/Login/login.dart';
import 'package:proyectoubicua/Vistas/Login/registrate.dart';
import 'package:proyectoubicua/Vistas/Producto/productoVista.dart';
//**Lista con las rutas de cada una de las vistas */
final Map<String, WidgetBuilder> routes = {
  MyloginClass.routeName:(context) => MyloginClass(),
  MycontrasenaOlvidadaClass.routeName: (context) => MycontrasenaOlvidadaClass(),
  MyRegistrateClass.routeName:(context) => MyRegistrateClass(),
  MyHomeClass.routeName:(context) => MyHomeClass(),
  MyProductoVistaClass.routeName:(context) => MyProductoVistaClass(),
  CarritoVista.routeName:(context) => CarritoVista(),
  ListaProductos.routeName:(context) => ListaProductos(),
};
