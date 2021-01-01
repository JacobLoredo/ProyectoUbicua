import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/Producto.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';

class ProductoImagen extends StatefulWidget {
  const ProductoImagen({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductoImagenState createState() => _ProductoImagenState();
}

class _ProductoImagenState extends State<ProductoImagen> {
  int imagenSeleccionada = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: getProportionateScreenWidth(238),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(widget.product.images[imagenSeleccionada]),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagenesPrevia(0),
          ],
        )
      ],
    );
  }
   GestureDetector imagenesPrevia(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          imagenSeleccionada = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        padding: EdgeInsets.all(getProportionateScreenHeight(6)),
        height: getProportionateScreenHeight(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          border: Border.all(
              color: imagenSeleccionada == index
                  ? colores['naranja']
                  : Colors.transparent),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(widget.product.images),
      ),
    );
  }
}