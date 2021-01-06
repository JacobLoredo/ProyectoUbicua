import 'package:flutter/material.dart';
//**Clase para poder almacenar la informacion que viene de la API correspondiente al Usuario */
//**id ->identificador del usuario */
//**name->Nombre del usuario */
//**direccion->direccion del usuario */
//**usertoken->Token de identificacion del usuario */
//**email->correo del usuario */
class Usuario {
  final int id;
  final String name, direccion,usertoken;
  final String email;

  Usuario({
    @required this.id,
    @required this.name,
    @required this.direccion,
    @required this.email,
    this.usertoken,
  });
  //**Metodo para convertir un JSON en un usuario */
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'],
        name: json['name'],
        direccion: json['direccion'],
        usertoken: json['user_token'],
        email: json['email']);
  }
}
