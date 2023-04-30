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

import '../models/company.dart';
import '../models/activityType.dart';
import '../models/activity.dart';

import 'package:frontend/pages/economicPage.dart';
import 'package:frontend/pages/listEconomicPage.dart';
import '../pages/pausokaPage.dart';
import '../pages/listPausokaPage.dart';
import '../pages/erreProdukzioakPage.dart';
import '../pages/listErreProdukzioakPage.dart';
import '../pages/facturaPage.dart';
import '../pages/listFacturaPage.dart';
import '../pages/cuentaAjenaPage.dart';
import '../pages/listCuentaAjenaPage.dart';
import '../pages/promocionPage.dart';
import '../pages/listPromocionPage.dart';


Color mainColor = Colors.black;
Color selectedColor = Colors.black;
Color textColor = Colors.white;
Color hoverTextColor = Colors.white;

class TopButton extends StatefulWidget {
  final StatefulWidget paginaContraria;
  final String textPaginaContraria;

  TopButton(this.paginaContraria, this.textPaginaContraria, {Key? key}) : super(key: key);

  @override
  State<TopButton> createState() => _TopButtonState();

}

class _TopButtonState extends State<TopButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            ElevatedButton(
              child: Text(widget.textPaginaContraria),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.paginaContraria),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 0, 204, 102),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.all<Color>(
                  Colors.transparent, // remove ripple effect on hover
                ),
                mouseCursor: MaterialStateProperty.all<MouseCursor>(
                  MouseCursor.defer, // default cursor when not hovered
                ),
                elevation: MaterialStateProperty.all<double>(0), // remove button elevation
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ),
            ),



            
            SizedBox(width: 50.0),
            
          ],
      ),
    );
  }
}
