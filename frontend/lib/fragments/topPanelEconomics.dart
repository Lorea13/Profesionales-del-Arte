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
import '../pages/pausokaPage.dart';
import '../pages/erreProdukzioakPage.dart';
import '../pages/facturaPage.dart';
import '../pages/cuentaAjenaPage.dart';
import '../pages/promocionPage.dart';

Color mainColor = Color.fromARGB(255, 0, 0, 139);
Color selectedColor = Colors.black;
Color textColor = Colors.white;
Color hoverTextColor = Colors.white;

class TopPanelEconomics extends StatefulWidget {
  final int _countEconomico;

  TopPanelEconomics(this._countEconomico, {Key? key}) : super(key: key);

  @override
  State<TopPanelEconomics> createState() => _TopPanelEconomicsState();

}

class _TopPanelEconomicsState extends State<TopPanelEconomics> {

  bool _hoveringEconomico = false;
  bool _hoveringPausoka = false;
  bool _hoveringErreProdukzioak = false;
  bool _hoveringFacturas= false;
  bool _hoveringCuentaAjena = false;
  bool _hoveringPromocion = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (PointerEvent details) {
              setState(() {
                _hoveringEconomico = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringEconomico = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EconomicPage()),
                );
                               
              },
              child: Opacity(
                opacity: _hoveringEconomico ? 0.5 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: widget._countEconomico == 0 ? selectedColor : mainColor,
                  child: Center(
                    child: Text(
                      'Toda la actividad',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 10,
                        color: _hoveringEconomico ? hoverTextColor : textColor,
                      ),
                    ),
                  ),
                  ),
                ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (PointerEvent details) {
              setState(() {
                _hoveringPausoka = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringPausoka = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PausokaPage()),
                );
                               
              },
              child: Opacity(
                opacity: _hoveringPausoka ? 0.5 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: widget._countEconomico == 1 ? selectedColor : mainColor,
                  child: Center(
                    child: Text(
                      'Pausoka',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 10,
                        color: _hoveringPausoka ? hoverTextColor : textColor,
                      ),
                    ),
                  ),
                  ),
                ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (PointerEvent details) {
              setState(() {
                _hoveringErreProdukzioak = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringErreProdukzioak = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ErreProdukzioakPage()),
                );
              },
              child: Opacity(
                opacity: _hoveringErreProdukzioak ? 0.5 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: widget._countEconomico == 2 ? selectedColor : mainColor,
                  child: Center(
                    child: Text(
                      'Erre Produkzioak',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 10,
                        color: _hoveringErreProdukzioak ? hoverTextColor : textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (PointerEvent details) {
              setState(() {
                _hoveringFacturas = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringFacturas = false;
              });
            },
            child: GestureDetector(
             onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FacturaPage()),
              );
            },
              child: Opacity(
                opacity: _hoveringFacturas ? 0.5 : 1.0,
                child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._countEconomico == 3 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Facturas',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 10,
                        color: _hoveringFacturas ? hoverTextColor : textColor,
                      ),
                    ),
                  ),
                ),
              ),
              ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (PointerEvent details) {
              setState(() {
                _hoveringCuentaAjena = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringCuentaAjena = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CuentaAjenaPage()),
                );
              },
              child: Opacity(
                opacity: _hoveringCuentaAjena ? 0.5 : 1.0,
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._countEconomico == 4 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Cuenta ajena',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 10,
                        color: _hoveringCuentaAjena ? hoverTextColor : textColor,
                      ),
                    ),
                ),
                  ),
              ),
            ),
          ),
           MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (PointerEvent details) {
              setState(() {
                _hoveringPromocion = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringPromocion = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PromocionPage()),
                );
              },
              child: Opacity(
                opacity: _hoveringPromocion ? 0.5 : 1.0,
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._countEconomico == 5 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Promociones',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 10,
                        color: _hoveringPromocion ? hoverTextColor : textColor,
                      ),
                    ),
                ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
