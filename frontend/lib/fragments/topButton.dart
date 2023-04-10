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


Color mainColor = Color.fromARGB(255, 0, 0, 139);
Color selectedColor = Colors.black;
Color textColor = Colors.white;
Color hoverTextColor = Colors.white;

class TopButton extends StatefulWidget {
  final StatefulWidget paginaResumen;
  final StatefulWidget paginaListado;

  TopButton(this.paginaResumen, this.paginaListado, {Key? key}) : super(key: key);

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
              child: Text('Resumen de la actividad'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.paginaResumen),
                );
              },
            ),
            SizedBox(width: 20.0),
            ElevatedButton(
              child: Text('Listado de actividades'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.paginaListado),
                );
              },
            ),
            SizedBox(width: 50.0),
            
          ],
      ),
    );
  }
}
