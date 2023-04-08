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

import 'package:frontend/pages/castingDirectorPage.dart';
import '../pages/directorPage.dart';
import '../pages/theatreCompanyPage.dart';
import '../pages/productionCompanyPage.dart';
import '../pages/managerPage.dart';

Color mainColor = Color.fromARGB(255, 0, 0, 139);
Color selectedColor = Colors.black;
Color textColor = Colors.white;
Color hoverTextColor = Colors.gray;

class TopPanelContacts extends StatefulWidget {
  final int _countContacts;

  TopPanelContacts(this._countContacts, {Key? key}) : super(key: key);

  @override
  State<TopPanelContacts> createState() => _TopPanelContactsState();

}

class _TopPanelContactsState extends State<TopPanelContacts> {

  
  bool _hoveringCastingDirector = false;
  bool _hoveringDirector = false;
  bool _hoveringTheatreCompany = false;
  bool _hoveringProduction = false;
  bool _hoveringManager = false;

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
                _hoveringCastingDirector = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringCastingDirector = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CastingDirectorPage()),
                );
                               
              },
              child: Opacity(
                opacity: _hoveringCastingDirector ? 0.5 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: widget._count == 0 ? selectedColor : mainColor,
                  child: Center(
                    child: Text(
                      'Directores de casting',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 12,
                        color: _hoveringCastingDirector ? hoverTextColor : textColor,
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
                _hoveringDirector = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringDirector = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DirectorPage()),
                );
              },
              child: Opacity(
                opacity: _hoveringDirector ? 0.5 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: widget._count == 1 ? selectedColor : mainColor,
                  child: Center(
                    child: Text(
                      'Directores',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 12,
                        color: _hoveringDirector ? hoverTextColor : textColor,
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
                _hoveringTheatreCompany = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringTheatreCompany = false;
              });
            },
            child: GestureDetector(
             onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TheatreCompanyPage()),
              );
            },
              child: Opacity(
                opacity: _hoveringTheatreCompany ? 0.5 : 1.0,
                child: Container
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._count == 2 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Compañías de teatro',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 12,
                        color: _hoveringTheatreCompany ? hoverTextColor : textColor,
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
                _hoveringProduction = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringProduction = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductionCompanyPage()),
                );
              },
              child: Opacity(
                opacity: _hoveringProduction ? 0.5 : 1.0,
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._count == 3 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Productoras audiovisuales',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 12,
                        color: _hoveringProduction ? hoverTextColor : textColor,
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
                _hoveringManager = true;
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                _hoveringManager = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManagerPage()),
                );
              },
              child: Opacity(
                opacity: _hoveringManager ? 0.5 : 1.0,
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height * 0.08,
                color: widget._count == 3 ? selectedColor : mainColor,
                child: Center(
                    child: Text(
                      'Representantes',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 1000 * 12,
                        color: _hoveringManager ? hoverTextColor : textColor,
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
