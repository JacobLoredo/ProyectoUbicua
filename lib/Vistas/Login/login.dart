import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/Login/contrasenaolvidada/contrasenaolvidada.dart';
import 'package:proyectoubicua/Vistas/Login/registrate.dart';
import 'package:proyectoubicua/Vistas/Home/home.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/Widgets/boton.dart';
import 'package:proyectoubicua/Widgets/formError.dart';
import 'package:proyectoubicua/main.dart';
import 'package:proyectoubicua/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyloginClass extends StatelessWidget {
   static String routeName = "Vistas/Login/";
  const MyloginClass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
       // resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    Image.asset(
                      'assets/images/shop_icon.png',
                      width: 80.0,
                      height: 100.0,
                    ),
                    Text(
                      "Bienvenido",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Inicia sesión con tu correo electronico o registrate ",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.10),
                    SignForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Aun no tienes cuenta?",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16)),
                        ),
                        GestureDetector(
                          onTap: ()=>Navigator.popAndPushNamed(context, MyRegistrateClass.routeName),
                        child:Text(
                          "Registrate",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              color: colores['naranja']),
                        ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email;
  String password;
  bool recordarme = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SizedBox(
            height: getProportionateScreenHeight(0),
          ),
          Row(
            children: [
              Checkbox(
                value: recordarme,
                activeColor: colores['naranja'],
                onChanged: (value) {
                  setState(() {
                    recordarme = value;
                  });
                },
              ),
              Text("Recordar"),
              Spacer(),
              GestureDetector(
              onTap: ()=>Navigator.popAndPushNamed(context, MycontrasenaOlvidadaClass.routeName),
              child:Text(
                "Olvidaste tu contraseña?",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              ),
            ],
          ),
          FormError(errors: errors),
          MybuttonClass(
            text: "Continuar",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _login();

              }
            },
          ),
        ],
      ),
    );
  }

  void _login() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password' : password
    };

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['user_token']));
      localStorage.setString('user', json.encode(body['user']));
     
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => MyHomeClass(),
          ),
      );
    }else{
      errors.add(body['message']);
    }

    setState(() {
      _isLoading = false;
    });

  }


  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingresa tu contraseña",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconoCustumText(
          icon: Icons.lock,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(emailErrorNull)) {
          setState(() {
            errors.remove(emailErrorNull);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(emailErrorNull)) {
          setState(() {
            errors.add(emailErrorNull);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Ingresa tu email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconoCustumText(
          icon: Icons.mail_outline_outlined,
        ),
      ),
    );
  }
}

class IconoCustumText extends StatelessWidget {
  final IconData icon;
  const IconoCustumText({
    Key key,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(10),
        getProportionateScreenWidth(10),
        getProportionateScreenWidth(10),
      ),
      child: Icon(
        this.icon,
        size: getProportionateScreenWidth(35),
      ),
    );
  }
}


