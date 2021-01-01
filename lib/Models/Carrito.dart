import 'package:proyectoubicua/Models/Producto.dart';

class Carrito {
  final int id;
  final Product product;
  final int idProduct;
  final int idUser;
  final int numItems;

  Carrito({this.product,this.numItems,this.idProduct,this.idUser,this.id});

  factory Carrito.fromJson(Map<String, dynamic> json) {
    return Carrito(
        id: json['id'],
        idProduct: json['producto_id'],
        idUser: json['user_id']);
  }
}