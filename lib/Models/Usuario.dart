import 'package:flutter/material.dart';

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
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'],
        name: json['name'],
        direccion: json['direccion'],
        usertoken: json['user_token'],
        email: json['email']);
  }
}
