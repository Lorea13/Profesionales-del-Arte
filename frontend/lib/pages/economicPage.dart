import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/helpers/urls.dart';

import 'package:frontend/models/company.dart';
import 'package:frontend/models/activityType.dart';
import 'package:frontend/models/activity.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../helpers/methods.dart';
import '../fragments/topPanel.dart';
import '../fragments/topPanelEconomics.dart';
import 'home.dart';



class EconomicPage extends StatefulWidget {

  EconomicPage(
      {Key? key})
      : super(key: key);

  @override
  State<EconomicPage> createState() => _EconomicPageState();
}

class _EconomicPageState extends State<EconomicPage> {

  bool _isLoading = true;

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

  List<Company> companys = [];
  List<ActivityType> activityTypes = [];
  List<Activity> activities = [];
  Map<ActivityType, List<Activity>> groupedActivities = {};

  obtainDataApi() async {
    await obtainCompanys();
    await obtainActivityTypes();
    await obtainActivities();
    await obtainGroupedActivities();

    setState(() {
      _isLoading = false;
    });
  }

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

    Future<List<Activity>> futureActivities = getActivities(activityTypes, companys);
    activities = await futureActivities;

    return true;
  }

  obtainGroupedActivities() async {
    
    // Group activities by activity type
    for (var activity in activities) {
      if (!groupedActivities.containsKey(activity.type)) {
        groupedActivities[activity.type] = [];
      }
      groupedActivities[activity.type]?.add(activity);

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
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  TopPanel(1),
                  TopPanelEconomics(0),
                  Expanded(
                      child: Row(
                        children: [
                          SingleChildScrollView(
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
                                  children: <Widget>[
                                    TableCell(
                                      child: Text(''),
                                    ),
                                    TableCell(
                                      child: Text('Total'),
                                    ),
                                    TableCell(
                                      child: Text('Anual'),
                                    ),
                                    TableCell(
                                      child: Text('Mes'),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    TableCell(
                                      child: Text('Dinero ganado'),
                                    ),
                                    TableCell(
                                      child: Text(totalMoneyEarned.toString()+"€"),
                                    ),
                                    TableCell(
                                      child: Text(totalPriceAnual.toString()+"€"),
                                    ),
                                    TableCell(
                                      child: Text(totalPriceMonth.toString()+"€"),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    TableCell(
                                      child: Text('Horas trabajadas'),
                                    ),
                                    TableCell(
                                      child: Text(totalWorkedHours.toString()+"h"),
                                    ),
                                    TableCell(
                                      child: Text(totalHourAnual.toString()+"h"),
                                    ),
                                    TableCell(
                                      child: Text(totalHourMonth.toString()+"h"),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    TableCell(
                                      child: Text('Precio por hora'),
                                    ),
                                    TableCell(
                                      child: Text(mediumPricePerHour.toStringAsFixed(2)+"€/h"),
                                    ),
                                    TableCell(
                                      child: Text(mediumPricePerHourAnual.toStringAsFixed(2)+"€/h"),
                                    ),
                                    TableCell(
                                      child: Text(mediumPricePerHourMonth.toStringAsFixed(2)+"€/h"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                ],
              ),
          ),
    );
  }
}