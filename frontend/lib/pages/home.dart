import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/helpers/urls.dart';

import 'package:frontend/models/personType.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/casting.dart';
import 'package:frontend/models/company.dart';
import 'package:frontend/models/activityType.dart';
import 'package:frontend/models/activity.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../fragments/topPanel.dart';
import '../helpers/methods.dart';
import 'castingPage.dart';
import 'directorPage.dart';
import 'contactPage.dart';
import 'castingDirectorPage.dart';
import 'theatreCompanyPage.dart';
import 'managerPage.dart';
import 'productionCompanyPage.dart';


class Home extends StatefulWidget {
  

  Home({Key? key})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

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

    await Future.delayed(const Duration(seconds: 1));

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

  Future<bool> obtainUpdatedData() async {
    Future<List<Person>> futurePeople = getPeople(personTypes);
    people = await futurePeople;

    Future<List<Casting>> futureCastings = getCastings(people);
    castings = await futureCastings;

    Future<List<Activity>> futureActivities = getActivities(activityTypes, companys);
    activities = await futureActivities;

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopPanel(0),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text('Castings'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CastingPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Contactos'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Contactos de directores'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DirectorPage()),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de directores de casting'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CastingDirectorPage()),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de compañías de teatro'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TheatreCompanyPage()),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de productoras'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductionCompanyPage()),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de representatnes'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManagerPage()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}