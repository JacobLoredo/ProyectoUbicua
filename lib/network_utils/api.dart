import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//**Clase que permite la conexion con la API */
class Network {
  final String _url =
      'http://192.168.100.63/proyecto-JacobLoredo/public/api/auth';
  var token;
  String urlProductos = 'http://192.168.100.63/proyecto-JacobLoredo/public/api';
  String urlImagenesProductos =
      'http://192.168.100.63/proyecto-JacobLoredo/public';
  // ignore: unused_element
  //**Funcion que regresa el token del usuario */
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('user_token'))['user_token'];
    print("hola" + token);
  }
//**Funcion que registra a un usuario en la aplicacion */
  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }
//**Funcion que trae los productos */
  Future<http.Response> productos(apiUrl) {
    var urlF = urlProductos + apiUrl;

    return http.get(urlF);
  }
//**Funcion que agrega un producto al carrito del usuario */
  agregarproductos(data, apiUrl) async {
    var fullUrl = urlProductos + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }
//**Funcion que elimina un producto al carrito del usuario */
  eliminarproductos(data, apiUrl) async {
    var fullUrl = urlProductos + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }
//**Funcion que confirma la compra de un usuario */
  confirmarproductos(data, apiUrl) async {
    var fullUrl = urlProductos + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }
//**Funcion que obtiene toda la informacion del usuario por medio del token*/
  usuario(data, apiUrl) async {
    var urlF = urlProductos + apiUrl;
    return await http.post(urlF,
        body: jsonEncode(data).replaceAll('\\"', ""), headers: _setHeaders());
  }
//**Funcion que obtiene el carrito del usuario*/
  carritos(apiUrl) async {
    var urlF = urlProductos + apiUrl;
    return await http.get(urlF);
  }
//**Funcion regresa la url */
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    // await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }
//**Encabezdos necesarios para las peticiones POST */
  _setHeaders() => {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
