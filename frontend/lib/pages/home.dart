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

  final formatter = NumberFormat('#,##0.00', 'es');

  int totalMoneyEarned = 0;
  int totalWorkedHours = 0;
  double mediumPricePerHour = 0;

  var now = DateTime.now();

  int totalPriceAnual = 0;
  int totalHourAnual = 0;
  double mediumPricePerHourAnual = 0;

  int totalPriceMonth = 0;
  int totalHourMonth = 0;
  double mediumPricePerHourMonth = 0;

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
    await obtainCalculations();

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

   obtainCalculations() async {
    
    // Group activities by activity type
    for (var activity in activities) {

      totalMoneyEarned += activity.price;
      totalWorkedHours += activity.hours;

      if (activity.activityDate.year == now.year) {
        totalPriceAnual += activity.price;
        totalHourAnual += activity.hours;
      }

      if (activity.activityDate.month == now.month &&
          activity.activityDate.year == now.year) {
        totalPriceMonth += activity.price;
        totalHourMonth += activity.hours;
      }
      
    }
    mediumPricePerHour = totalMoneyEarned / totalWorkedHours;
    mediumPricePerHourAnual = totalPriceAnual / totalHourAnual;
    mediumPricePerHourMonth = totalPriceMonth / totalHourMonth;

  }


  @override
  Widget build(BuildContext context) {
     if (_isLoading) {
      obtainDataApi();
    }
    return Scaffold(
      body: _isLoading
          ? Container()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TopPanel(0),
                  SizedBox(height: 80.0),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 50.0),
                        Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.15,
                                
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(56),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15.0),
                                        Text('¡Bienvenida Lorea!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                        
                                        Text('Aquí te mostramos un',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                        Text('resumen de tu actividad.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                      ],
                                    ),
                                  ),

                              
                            
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Expanded(
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Table(
                                  columnWidths: <int, TableColumnWidth>{
                                    0: FixedColumnWidth(200.0),
                                    1: FixedColumnWidth(100.0),
                                    2: FixedColumnWidth(100.0),
                                    3: FixedColumnWidth(100.0),
                                  },
                                  children: <TableRow>[
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                      ),
                                      children: <Widget>[
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Resumen económico',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Total',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              now.year.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "0" + now.month.toString() + " / " + now.year.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Dinero ganado'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(formatter.format(totalMoneyEarned) + "€"),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(formatter.format(totalPriceAnual) + "€"),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(formatter.format(totalPriceMonth) + "€"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Horas trabajadas'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(totalWorkedHours.toString() + "h"),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(totalHourAnual.toString() + "h"),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(totalHourMonth.toString() + "h"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: <Widget>[
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Precio por hora'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(formatter.format(mediumPricePerHour) + "€/h"),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(formatter.format(mediumPricePerHourAnual) + "€/h"),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(formatter.format(mediumPricePerHourMonth) + "€/h"),
                                          ),
                                        ),
                                      ],
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
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 50.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),  
                                    padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Actividades pendientes de cobrar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: activities.length,
                                    itemBuilder: (context, index) {
                                      var activity = activities[index];
                                      if (activity.getPaid) {
                                        return SizedBox.shrink();
                                      }
                                      return ListTile(
                                        title: Text(activity.name),
                                        subtitle: Text("Precio: "+activity.price.toString()),
                                        trailing: activity.invoice
                                            ? Text('')
                                            : Icon(Icons.receipt),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),  
                                    padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Castings en proceso',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: castings.length,
                                    itemBuilder: (context, index) {
                                      var casting = castings[index];
                                      if (!casting.inProcess) {
                                        return SizedBox.shrink();
                                      }
                                      return ListTile(
                                        title: Text(casting.name),
                                        subtitle: Text(DateFormat('yyyy-MM-dd').format(casting.castingDate)),
                                        trailing: casting.inPerson
                                            ? Icon(Icons.person)
                                            : Icon(Icons.videocam),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 19,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),  
                                    padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Actividades recientes',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: activities.length > 7 ? 7 : activities.length,
                                    itemBuilder: (context, index) {
                                      var activity = activities[index];
                                      return ListTile(
                                        title: Text(activity.name),
                                        subtitle: Text("Precio: "+activity.price.toString()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 50.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 55.0),
                  
        ],
      ),
          ),
    );
  }
}