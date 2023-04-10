import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:frontend/helpers/urls.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../helpers/methods.dart';


Color mainColor = Color.fromARGB(255, 0, 0, 139);
Color selectedColor = Colors.black;
Color textColor = Colors.white;
Color hoverTextColor = Colors.white;

class TopWelcome extends StatefulWidget {

  TopWelcome( {Key? key}) : super(key: key);

  @override
  State<TopWelcome> createState() => _TopWelcomeState();

}

class _TopWelcomeState extends State<TopWelcome> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              child: Text('¡Bienvenida, Lorea! Aquí te mostramos un resumen de tu actividad.'),
              
              
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 139),
                textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 1000 * 13,
                ),
              ),
            ),
            SizedBox(width: 50.0),
            
          ],
      ),
    );
  }
}
