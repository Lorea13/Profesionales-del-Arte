import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:frontend/models/user.dart';
import '../helpers/methods.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    bool _isDataLoading = true;

    List<User> users = [];


    obtainDataApi() async {
    await obtainUsers();

    setState(() {
      _isLoading = false;
    });

  }

  ///Obtiene todos los tipos de persona
  ///
  ///Llama al método de /helpers/methods getPersonTypes, que nos retorna una lista de los tipos de personas, futurePersonType. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de tipos de personas [personTypes] que contendrá todos los tipos de personas de la base de datos.
  obtainUsers() async {
    Future<List<User>> futureUsers = getUsers();
    users = await futureUsers;
  }


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    User defaultUser = User(0, "", ""); // A default user object with empty strings for name and password
    User userMatch = users.firstWhere(
    (user) => user.name == username && user.pass == password,
    orElse: () => defaultUser,
  );


    if (userMatch!=null) {
      // Login successful, navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        );
    }
    setState(() {
      _isLoading = false;
    });
  }

@override
Widget build(BuildContext context) {
  if (_isDataLoading) {
    obtainDataApi();
  }
  return Scaffold(
    body: _isLoading
        ? Container()
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Sistema de gestión de la información",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    "del arte escénico",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                SizedBox(height: 36.0),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.person,
                    size: 64.0,
                  ),
                ),
                SizedBox(height: 26.0),
                Card(
  elevation: 4.0,
  margin: EdgeInsets.all(16.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: BorderSide(color: Colors.blue, width: 2.0),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
     child: Container(
                    width: MediaQuery.of(context).size.width / 4,
    child: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Usuario',
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
            obscureText: true,
          ),
          SizedBox(height: 16.0),
          if (_isLoading)
            CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
        ],
      ),
    ),
  ),
  ),
),

              ],
            ),
          ),
  );
}

}
