import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url =
      'http://192.168.100.63/proyecto-JacobLoredo/public/api/auth';
  var token;
  String urlProductos = 'http://192.168.100.63/proyecto-JacobLoredo/public/api';
  String urlImagenesProductos =
      'http://192.168.100.63/proyecto-JacobLoredo/public';
  // ignore: unused_element
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('user_token'))['user_token'];
    print("hola" + token);
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  Future<http.Response> productos(apiUrl) {
    var urlF = urlProductos + apiUrl;

    return http.get(urlF);
  }

  agregarproductos(data, apiUrl) async {
    var fullUrl = urlProductos + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  eliminarproductos(data, apiUrl) async {
    var fullUrl = urlProductos + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  confirmarproductos(data, apiUrl) async {
    var fullUrl = urlProductos + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  usuario(data, apiUrl) async {
    var urlF = urlProductos + apiUrl;
    return await http.post(urlF,
        body: jsonEncode(data).replaceAll('\\"', ""), headers: _setHeaders());
  }

  carritos(apiUrl) async {
    var urlF = urlProductos + apiUrl;
    return await http.get(urlF);
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    // await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
