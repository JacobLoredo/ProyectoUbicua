import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyectoubicua/Models/Producto.dart';
import 'package:proyectoubicua/Models/Usuario.dart';
import 'package:proyectoubicua/Vistas/Carrito/CarritoVista.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';
import 'package:proyectoubicua/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyCarrito extends StatefulWidget {
  const BodyCarrito({Key key}) : super(key: key);

  @override
  _BodyCarritoState createState() => _BodyCarritoState();
}

class _BodyCarritoState extends State<BodyCarrito> {
  List<Product> demoProducts = new List<Product>();

  Future<List<Product>> fetchProductos() async {
    var productos = new List<Product>();
    var res = await Network().productos('/listproductos');
    var body = json.decode(res.body);

    if (body['success']) {
      for (var produ in body['productos']) {
        productos.add(Product.fromJson(produ));
      }

      return productos;
    } else {
      throw Exception('Failed to load Producto');
    }
  }

  List<Usuario> usuarios = new List<Usuario>();

  Future<List<Usuario>> fetchUsuario() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String t = localStorage.getString('token');
    var data = {'token': t.toString()};

    // localStorage.setString('token', json.encode(body['token']));
    var usuario = new List<Usuario>();
    var res = await Network().usuario(data, '/getuser');
    var body = json.decode(res.body);
    print(body['user']['id']);
    if (body['success']) {
      usuario.add(Usuario.fromJson(body['user']));

      return usuario;
    } else {
      throw Exception('Failed to load Usuario');
    }
  }

  List<Product> carritos = new List<Product>();
  int user = 0;
  Future<List<Product>> fetchCarrito() async {
    var carro = new List<Product>();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String t = localStorage.getString('token');
    var data = {'token': t.toString()};

    // localStorage.setString('token', json.encode(body['token']));
    var usuario = new List<Usuario>();
    var res2 = await Network().usuario(data, '/getuser');
    var body2 = json.decode(res2.body);
    var res = await Network().carritos('/carrito/${body2['user']['id']}');
    user = body2['user']['id'];
    var body = json.decode(res.body);
    double aux = 0;
    print(body);
    if (body['success']) {
      for (var produ in body['productos']) {
        carro.add(Product.fromJson(produ));
        aux += double.parse(produ['Precio']);
      }

      key.currentState.setState(() {
        total = aux;
      });
      return carro;
    } else {
      throw Exception('Failed to load Producto');
    }
  }

  @override
  void initState() {
    setState(() {
      total = 0;
    });
    fetchProductos().then((value) {
      setState(() {
        demoProducts.clear();
        demoProducts.addAll(value);
      });
    });

    fetchCarrito().then((value) {
      setState(() {
        carritos.clear();
        carritos.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...List.generate(
          carritos.length,
          (index) {
            // total += double.parse(carritos[index].price);
            if (carritos[index].isPopular)
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(5),
                ),
                child: ProductoCarrito(
                  carrito: carritos[index],
                  function: initState,

                ),
              );

            return SizedBox.shrink(); // here by default width and height is 0
          },
        ),
        //ProductoCarrito(),
      ],
    );
  }
}

class ProductoCarrito extends StatelessWidget {
  const ProductoCarrito({
    Key key,
    this.function,
    this.carrito,
  }) : super(key: key);
  final Product carrito;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ProductoEnCarrito(
      carrito: this.carrito,
      function:this.function,
    );
  }
}

class ProductoEnCarrito extends StatelessWidget {
  const ProductoEnCarrito({
    this.carrito,
    this.function,
    Key key,
  }) : super(key: key);
  final Product carrito;
  final Function function;
  @override
  Widget build(BuildContext context) {
    Network imagen = new Network();
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
              child: Image.network(imagen.urlImagenesProductos+ carrito.images),
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(180),
              child: Tooltip(
                message: "${carrito.title}",
                child: Text(
                  "${carrito.title}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(
                text: "\$${carrito.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: colores['naranja']))),
          ],
        ),
        SizedBox(
          height: getProportionateScreenWidth(50),
          width: getProportionateScreenHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: BotonEliminar(
              icon: SvgPicture.asset("assets/icons/Trash.svg"),
              press: () => eliminarCarrito(context, carrito.id,function),
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

void eliminarCarrito(BuildContext context, int producto,Function function) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  String t = localStorage.getString('token');
  var data = {'token': t.toString()};
  var res2 = await Network().usuario(data, '/getuser');
  var body2 = json.decode(res2.body);
  var data2 = {
    'name': "",
  };
  var res = await Network().eliminarproductos(
      data2, '/EliminarCarrito/${body2['user']['id']}/$producto');
  var body = json.decode(res.body);
  print(body);
  if (body['success']) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Eliminado con exito!!")));
    function();
  }
}
