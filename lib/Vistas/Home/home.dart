import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyectoubicua/Models/Usuario.dart';
import 'package:proyectoubicua/Vistas/Home/Productos.dart';
import 'package:proyectoubicua/Vistas/Home/barraBusqueda.dart';
import 'package:proyectoubicua/Vistas/Home/botonCarrito.dart';
import 'package:proyectoubicua/Vistas/Home/categorias.dart';
import 'package:proyectoubicua/Vistas/Login/login.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/main.dart';
import 'package:proyectoubicua/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
//**Clase donde se muestra la pagina principal.*/
class MyHomeClass extends StatefulWidget {
  //**Nombre de la ruta donde se ubica la vista home*/
  static String routeName = "/home";
  const MyHomeClass({Key key}) : super(key: key);

  @override
  _MyHomeClassState createState() => _MyHomeClassState();
}
//**Clase que crea el estado donde se cargan las categorias y los productos provenietes de la API*/

class _MyHomeClassState extends State<MyHomeClass> {
  List<Usuario> usuarios = new List<Usuario>();
//**Funcion que realiza la peticion de usuario a la API por medio del token almacenado en el storege */
  Future<List<Usuario>> fetchUsuario() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String t = localStorage.getString('token');
    var data = {'token': t.toString()};

    // localStorage.setString('token', json.encode(body['token']));
    var usuario = new List<Usuario>();
    var res = await Network().usuario(data, '/getuser');
    var body = json.decode(res.body);

    if (body['success']) {
      usuario.add(Usuario.fromJson(body['user']));

      return usuario;
    } else {
      throw Exception('Failed to load Usuario');
    }
  }
//**Funcion que inicia el estado del Widget */
  @override
  void initState() {
    fetchUsuario().then((value) {
      setState(() {
        usuarios.addAll(value);
      });
    });

    super.initState();
  }
//**Widget donde se construye cada uno de los elementos de la vista */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          BarraBusqueda(),
          BotonCarrito(),
        ],
        backgroundColor: colores['naranja'],
      ),
      body: SingleChildScrollView(
              child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20),
                  vertical: getProportionateScreenHeight(2),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    TituloSeccion(
                      text: "Categorias",
                      press: () {},
                    ),
                    Categorias(),
                    PopularProducts(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      drawer: buildDrawer(context),
    );
  }
//**Funcion que contruye y regresa el Drawer de la vista */
  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: DrawerHeader(
              margin: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 0,
                ),
                leading: Icon(
                  Icons.account_circle,
                  size: 60,
                  color: Colors.white,
                ),
                title: Text(
                  
                  'Hola ${usuarios.length==0 ?"":usuarios[0].name}',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              decoration: BoxDecoration(
                color: colores['naranja'],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text('Configuracion'),
              onTap: () {
               
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text('Editar Perfil'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text('Cerrar Sesion'),
              onTap: () {
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
//**Clase que contruye un titulo con si link para redirigir a otra vista */
class TituloSeccion extends StatelessWidget {
  const TituloSeccion({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Text("Ver más"),
          ),
        ],
      ),
    );
  }
}

void logout() async {
  
  var res = await Network().productos('/listproductos');
  var body = json.decode(res.body);
  if (body['success']) {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    MaterialPageRoute(builder: (context) => MyloginClass());
  }
}
