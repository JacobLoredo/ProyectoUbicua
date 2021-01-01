import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url =
      'http://192.168.100.63/proyecto-JacobLoredo/public/api/auth';
  final String _urlProductos =
      'http://192.168.100.63/proyecto-JacobLoredo/public/api';
  var token;
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
    var urlF = _urlProductos + apiUrl;
    print(urlF);
    return http.get(urlF);
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
