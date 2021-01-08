import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';
//**Clase que construye una barra de busqueda con su diseño correspondiete */
class BarraBusqueda extends StatelessWidget {
  const BarraBusqueda({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(5),
        vertical: getProportionateScreenHeight(10),
      ),
      child: Container(
          width: SizeConfig.screenWidth * 0.75,
          decoration: BoxDecoration(
            color: colores['gris'],
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            onChanged: (value) {
              //buscar producto
            },
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Buscar producto",
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.black45,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(12),
                )),
          )),
    );
  }
}