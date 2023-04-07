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
  bool _isLoading = true;

  bool _hoveringHome = false;
  bool _hoveringEconomic = false;
  bool _hoveringCasting = false;
  bool _hoveringContacts = false;

  List<PersonType> personTypes = [];
    List<Person> people = [];
    List<Casting> castings = [];
    List<Company> companys = [];
    List<ActivityType> activityTypes = [];
    List<Activity> activities = [];

  /// Obtención de los datos
  ///
  /// Este método llama a 6 métodos, uno por cada tabla de la base de datos, para obtener toda la información que haya. Cada método hará una petición a la API. Después espera 10 segundos, y cambia la variable isLoading a false, con lo que indicará que se ha cargado toda la info correctamente y saldrá de la página de carga
  obtainDataApi() async {
    await obtainPersonTypes();
    await obtainPeople();
    await obtainCastings();
    await obtainCompanys();
    await obtainActivityTypes();
    await obtainActivities();

    setState(() {
      _isLoading = false;
    });

  }

  ///Obtiene todos los tipos de persona
  ///
  ///Llama al método de /helpers/methods getPersonTypes, que nos retorna una lista de los tipos de personas, futurePersonType. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de tipos de personas [personTypes] que contendrá todos los tipos de personas de la base de datos.
  obtainPersonTypes() async {
    Future<List<PersonType>> futurePersonTypes = getPersonTypes();

    personTypes = await futurePersonTypes;
  }

  ///Obtiene todas las personas
  ///
  ///Llama al método de /helpers/methods getPeople, que nos retorna una lista de personas, futurePeople. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de personas [people] que contendrá todas las personas de la base de datos.
  obtainPeople() async {
    Future<List<Person>> futurePeople = getPeople(personTypes);

    people = await futurePeople;
  }

  ///Obtiene todas los castings
  ///
  ///Llama al método de /helpers/methods getCastings, que nos retorna una lista de castings, futureCastings. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de castings [castings] que contendrá todos los castings de la base de datos.
  obtainCastings() async {
    Future<List<Casting>> futureCastings = getCastings(people);

    castings = await futureCastings;
  }

  ///Obtiene todas los companies
  ///
  ///Llama al método de /helpers/methods getCompanys, que nos retorna una lista de companys, futureCompanys. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de companys [companys] que contendrá todos los companys de la base de datos.
  obtainCompanys() async {
    Future<List<Company>> futureCompanys = getCompanys();

    companys = await futureCompanys;
  }

  ///Obtiene todas los activityTypes
  ///
  ///Llama al método de /helpers/methods getActivityTypes, que nos retorna una lista de activityTypes, futureActivityTypes. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de activityTypes [activityTypes] que contendrá todos los activityTypes de la base de datos.
  obtainActivityTypes() async {
    Future<List<ActivityType>> futureActivityTypes = getActivityTypes();

     activityTypes = await futureActivityTypes;
  }

  ///Obtiene todas los activities
  ///
  ///Llama al método de /helpers/methods getActivities, que nos retorna una lista de activities, futureActivities. Es un Future List porque, al ser una petición API, no se obtendrá respuesta al momento. Retorna dicha lista de activities [activities] que contendrá todos los activities de la base de datos.
  obtainActivities() async {
    Future<List<Activity>> futureActivities = getActivities(activityTypes, companys);

    activities = await futureActivities;
  }

  @override
  Widget build(BuildContext context) {
    obtainDataApi();
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
                  MaterialPageRoute(builder: (context) => Home(personTypes, people, castings, companys, activityTypes, activities)),
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
                  MaterialPageRoute(builder: (context) => EconomicPage(activityTypes, activities, companys)),
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
                MaterialPageRoute(builder: (context) => CastingPage(personTypes, people, castings)),
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
                  MaterialPageRoute(builder: (context) => ContactPage(personTypes, people, castings)),
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
