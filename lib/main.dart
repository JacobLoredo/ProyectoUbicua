import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoubicua/Vistas/Login/login.dart';
import 'package:proyectoubicua/Vistas/routs.dart';
import 'package:proyectoubicua/Vistas/theme.dart';

void main() {
  runApp(MyApp());
}
final colores = {
  "naranja": Color(0xFFFF8056),
  "gris":Color(0xFFF6F6F4),
};
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String emailErrorNull = "Por favor ingresa tu Email";
const String kInvalidEmailError = "Por favor ingresa un Email valido";
const String kPassNullError = "Ingresa tu contraseña";
const String kShortPassError = "Tu contraseña es demasiado corta,\n debe contener 8 caracteres";
const String kMatchPassError = "Tu contraseña no coincide";
const String kuserNameError = "Por favor ingresa un nombre de usuario";
const String kuserDirecionError = "Por favor ingresa una direccion";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: colores['naranja'],
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Ubicua Proyecto',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: MyloginClass(),
      routes: routes,
    );
  }
}
