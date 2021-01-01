import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyectoubicua/Vistas/Login/login.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';
import 'package:proyectoubicua/Widgets/boton.dart';
import 'package:proyectoubicua/Widgets/formError.dart';
import 'package:proyectoubicua/main.dart';
import 'package:proyectoubicua/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRegistrateClass extends StatelessWidget {
  static String routeName = "Vistas/Login";
  const MyRegistrateClass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrarme"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyloginClass()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                  Text(
                    "Registra tu cuenta",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "Completa los datos para poder registrarte",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  RegistrarmeForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),

                  SizedBox(height: getProportionateScreenHeight(20)),
                  Text(
                    'Terminos y condiciones',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegistrarmeForm extends StatefulWidget {
  @override
  _RegistrarmeFormState createState() => _RegistrarmeFormState();
}

class _RegistrarmeFormState extends State<RegistrarmeForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String name;
  String password;

  // ignore: non_constant_identifier_names
  String conform_password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          MybuttonClass(
            text: "Continuar",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _register();
                // if all are valid then go to success screen
                //Navigator.pushNamed(context, MyloginClass.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirma tu contraseña",
        hintText: "Re-Ingresa tu contraseña",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconoCustumText(
          icon: Icons.lock_outline_rounded,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingresa tu contraseña",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconoCustumText(icon: Icons.lock_outline_rounded),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: emailErrorNull);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
        //print(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: emailErrorNull);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        email = value;
        return null;
        // return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Ingresa tu correo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconoCustumText(
          icon: Icons.mail_outline_outlined,
        ),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kuserNameError);
        } else {
          removeError(error: kuserNameError);
        }
        name = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kuserNameError);
          return "";
        }

        name = value;
        return null;
      },
      decoration: InputDecoration(
        labelText: "Usuario",
        hintText: "Ingresa tu usuario",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconoCustumText(
          icon: Icons.perm_identity_outlined,
        ),
      ),
    );
  }

  void _register() async {
    var data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': conform_password
    };
    var res = await Network().authData(data, '/signup');
    var body = json.decode(res.body);
    if (body['errors'] != null) {
      addError(error: kInvalidEmailError);
    }
    print(body['token'].toString());
    if (body['success']==true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));

      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  MyloginClass()),
      );
    }
  }
}
