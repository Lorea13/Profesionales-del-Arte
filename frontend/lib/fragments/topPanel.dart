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

import '../models/personType.dart';
import '../models/person.dart';
import '../models/casting.dart';
import '../models/company.dart';
import '../models/activityType.dart';
import '../models/activity.dart';

import 'package:frontend/pages/home.dart';
import '../pages/contactPage.dart';
import '../pages/economicPage.dart';
import '../pages/castingPage.dart';
import '../pages/companyPage.dart';

Color mainColor = Colors.blue;
Color selectedColor = Color.fromARGB(255, 0, 0, 139);
Color textColor = Colors.white;
Color hoverTextColor = Colors.black;

class TopPanel extends StatefulWidget {
  final int _count;

  TopPanel(this._count, {Key? key}) : super(key: key);

  @override
  State<TopPanel> createState() => _TopPanelState();

}

class _TopPanelState extends State<TopPanel> {
  
  bool _hoveringHome = false;
  bool _hoveringEconomic = false;
  bool _hoveringCasting = false;
  bool _hoveringContacts = false;

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
                _hoveringHome = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringHome = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                               
              },
              child: Opacity(
                opacity: _hoveringHome ? 0.5 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: widget._count == 0 ? selectedColor : mainColor,
                  child: Center(
                    child: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 14,
                        color: _hoveringHome ? hoverTextColor : textColor,
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
                _hoveringEconomic = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringEconomic = false;
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
                opacity: _hoveringEconomic ? 0.5 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: widget._count == 1 ? selectedColor : mainColor,
                  child: Center(
                    child: Text(
                      'Economico',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 14,
                        color: _hoveringEconomic ? hoverTextColor : textColor,
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
                _hoveringCasting = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringCasting = false;
              });
            },
            child: GestureDetector(
             onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CastingPage()),
              );
            },
              child: Opacity(
                opacity: _hoveringCasting ? 0.5 : 1.0,
                child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._count == 2 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Casting',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 14,
                        color: _hoveringCasting ? hoverTextColor : textColor,
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
                _hoveringContacts = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringContacts = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
              child: Opacity(
                opacity: _hoveringContacts ? 0.5 : 1.0,
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._count == 3 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Contactos',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 14,
                        color: _hoveringContacts ? hoverTextColor : textColor,
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
