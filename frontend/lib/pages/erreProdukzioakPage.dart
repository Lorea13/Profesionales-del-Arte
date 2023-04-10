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
import '../fragments/topButton.dart';
import 'listErreProdukzioakPage.dart';



class ErreProdukzioakPage extends StatefulWidget {

  ErreProdukzioakPage(
      {Key? key})
      : super(key: key);

  @override
  State<ErreProdukzioakPage> createState() => _ErreProdukzioakPageState();
}

class _ErreProdukzioakPageState extends State<ErreProdukzioakPage> {

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

  List<Company> companys = [];
  List<ActivityType> activityTypes = [];
  List<Activity> activities = [];
  List<Activity> activitiesErreProdukzioak = [];
  Map<ActivityType, List<Activity>> groupedActivities = {};
  Map<String, int> groupedActivitiesDate = {};

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

    for(var activity in activities){
      if(activity.company.id == 2 && activity.price != 0){
        activitiesErreProdukzioak.add(activity);
      }
    }

    
    // Group activities by activity type
    for (var activity in activitiesErreProdukzioak) {
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

      if(!groupedActivitiesDate.containsKey(activity.activityDate.year.toString())){
        groupedActivitiesDate[activity.activityDate.year.toString()] = 0;
      }
      groupedActivitiesDate[activity.activityDate.year.toString()] = (groupedActivitiesDate[activity.activityDate.year.toString()] ?? 0) + 1;
      
    }

    if(totalWorkedHours == 0){
      mediumPricePerHour = 0;
    }else{
      mediumPricePerHour = totalMoneyEarned / totalWorkedHours;
    }

    if(totalHourAnual == 0){
      mediumPricePerHourAnual = 0;
    }else{
      mediumPricePerHourAnual = totalPriceAnual / totalHourAnual;
    }

    if(totalHourMonth == 0){
      mediumPricePerHourMonth = 0;
    }else{
      mediumPricePerHourMonth = totalPriceMonth / totalHourMonth;
    }

  }

  @override
  Widget build(BuildContext context) {
    
     if (_isLoading) {
      obtainDataApi();
    }
    return Scaffold(
      body: _isLoading
          ? Container()
          :Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TopPanel(1),
                  TopPanelEconomics(2),
                  TopButton(ErreProdukzioakPage(), ListErreProdukzioakPage()),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 50.0),
                        Expanded(
                          child: Center(
                            child: Container(
                                child: Column(
                                    children: [
                                      SizedBox(width: 15.0),
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.26,
                                          
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
                                                        'Actividades por año',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: groupedActivitiesDate.length,
                                                    itemBuilder: (context, String) {
                                                      var yearString = groupedActivitiesDate.keys.toList()[String];
                                                      int activityNumber = groupedActivitiesDate[yearString] ?? 0;
                                                      return ListTile(
                                                        title: Text("Actividades del año "+yearString),
                                                        trailing: Text(activityNumber.toString()),
                                                            
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),

                            
                          
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                        ),
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
                  SizedBox(height: 25.0),
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
                                    itemCount: activitiesErreProdukzioak.length,
                                    itemBuilder: (context, index) {
                                      var activity = activitiesErreProdukzioak[index];
                                      if (activity.getPaid) {
                                        return SizedBox.shrink();
                                      }
                                      return ListTile(
                                        title: Text(activity.name),
                                        subtitle: Text("Precio: "+activity.price.toString()+"€"),
                                        
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
                                        'Tipo de actividades',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: groupedActivities.length,
                                    itemBuilder: (context, index) {
                                      var type = groupedActivities.keys.toList()[index];
                                      int typeNumber = groupedActivities[type]?.length ?? 0;
                                      return ListTile(
                                        title: Text(type.name),
                                        trailing: Text(typeNumber.toString()),
                                            
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
                                    itemCount: activitiesErreProdukzioak.length > 7 ? 7 : activitiesErreProdukzioak.length,
                                    itemBuilder: (context, index) {
                                      var activity = activitiesErreProdukzioak[index];
                                      return ListTile(
                                        title: Text(activity.name),
                                        subtitle: Text("Precio: "+activity.price.toString()+"€"),
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
                  SizedBox(height: 30.0),
                ],
              ),
          ),
    );
  }
}