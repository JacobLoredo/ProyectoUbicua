import 'package:flutter/material.dart';
//**Clase para poder almacenar la informacion que viene de la API correspondiente a la Producto */
//**id ->identificador del Producto */
//**title->Nombre del producto */
//**description -> Descripcion del producto  */
//**cantidad->Cantidad total disponible del producto */
//**images -> Direccion URL de la imagen*/
//**Price->Precio del producto */
//**isFavourite -> Bool para indicar si es producto es favorito o no*/
//**isPopular->Bool para indicar si es producto es popular o no */
class Product {
  final int id;
  final String title, description;
  final int cantidad;
  final String images;
  final List<Color> colors;
  final String price;
  bool isFavourite, isPopular;
  Product({
    this.cantidad,
    @required this.id,
    @required this.images,
    this.colors,
    
    this.isFavourite = false,
    this.isPopular =true,
    @required this.title,
    @required this.price,
    @required this.description,
  });
  //**Metodo para convertir un JSON en un producto */
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        images: json['Url_imag'],
        title: json['Nombre'],
        colors: json['colores'],
        price: json['Precio'],
        cantidad: json['Cantidad'],
        description: json['Descripcion']);
  }
}
