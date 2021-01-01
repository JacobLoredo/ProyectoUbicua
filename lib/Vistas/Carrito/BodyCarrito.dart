import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyectoubicua/Models/Carrito.dart';
import 'package:proyectoubicua/Vistas/Producto/productoVista.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';

class BodyCarrito extends StatelessWidget {
  const BodyCarrito({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        ProductoCarrito(),
      ],
    );
  }
}

class ProductoCarrito extends StatelessWidget {
  const ProductoCarrito({
    Key key, this.carrito,
  }) : super(key: key);
  final Carrito carrito;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/images/ps4_console_white_1.png"),
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre del producto",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10,),
            Text.rich(TextSpan(
                text: "\$",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colores['naranja']))),
          ],
        ),
        SizedBox(
          height: getProportionateScreenWidth(50),
          width: getProportionateScreenHeight(120),
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: BotonEliminar(
              icon: SvgPicture.asset("assets/icons/Trash.svg"),
              press: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}
class BotonEliminar extends StatelessWidget {
  const BotonEliminar({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);
  final SvgPicture icon;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      
      onPressed: press,
      child: this.icon,
      color: Color(0xFFFFE6E6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}