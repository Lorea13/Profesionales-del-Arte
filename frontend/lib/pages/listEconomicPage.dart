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
import 'home.dart';
import 'economicPage.dart';



class ListEconomicPage extends StatefulWidget {

  ListEconomicPage(
      {Key? key})
      : super(key: key);

  @override
  State<ListEconomicPage> createState() => _ListEconomicPageState();
}

class _ListEconomicPageState extends State<ListEconomicPage> {

  bool _isLoading = true;

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
    groupedActivities = {}; 
    // Group activities by activity type
    for (var activity in activities) {
      if (!groupedActivities.containsKey(activity.type)) {
        groupedActivities[activity.type] = [];
      }
      groupedActivities[activity.type]?.add(activity);
      
    }

  }



  Future<void> _showDeleteConfirmationDialog(BuildContext context, Activity activity) async {
    bool delete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación de borrado'),
          content: Text('¿Estás seguro de que quieres borrar esta actividad?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Borrar'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (delete == true) {
      bool success = await deleteActivity(activity.id);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('¡La actividad ha sido eliminada con éxito!'),
        ));
        setState(() {
          activities.remove(activity);
          groupedActivities[activity.type]?.remove(activity);
          if (groupedActivities[activity.type]?.isEmpty ?? true) {
            obtainGroupedActivities();
          }
          
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ha ocurrido un error al eliminar una actividad.'),
        ));
      }
    }
  }

  Future<void> _showEditActivityDialog(Activity activity) async {
    TextEditingController nameController = TextEditingController(text: activity.name);
    TextEditingController notesController = TextEditingController(text: activity.notes);
    TextEditingController hoursController = TextEditingController(text: activity.hours.toString());
    TextEditingController priceController = TextEditingController(text: activity.price.toString());
    TextEditingController ivaController = TextEditingController(text: activity.iva.toString());
    TextEditingController activityDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(activity.activityDate));
    bool invoice = activity.invoice;
    bool getPaid = activity.getPaid;

    ActivityType? selectedtype = activity.type;
    Company? selectedCompany= activity.company;

    List<DropdownMenuItem<ActivityType>> typeItems = activityTypes
      .map((activityType) => DropdownMenuItem(
            value: activityType,
            child: Text(activityType.name),
          ))
      .toList();

    List<DropdownMenuItem<Company>> companyItems = companys
      .map((company) => DropdownMenuItem(
            value: company,
            child: Text(company.name),
          ))
      .toList();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar actividad"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  controller: activityDateController,
                  decoration: InputDecoration(
                    labelText: 'Fecha (yyyy-MM-dd)',
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<ActivityType>(
                  value: selectedtype,
                  decoration: InputDecoration(
                    labelText: 'Tipo de actividad',
                  ),
                  items: typeItems,
                  onChanged: (value) {
                    setState(() {
                      selectedtype = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<Company>(
                  value: selectedCompany,
                  decoration: InputDecoration(
                    labelText: 'Empresa',
                  ),
                  items: companyItems,
                  onChanged: (value) {
                    setState(() {
                      selectedCompany = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: hoursController,
                  decoration: InputDecoration(
                    labelText: 'Horas',
                  ),
                ), 
                SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                  ),
                ), 
                SizedBox(height: 10),
                TextField(
                  controller: ivaController,
                  decoration: InputDecoration(
                    labelText: 'IVA',
                  ),
                ), 
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Factura',
                  ),
                  value: invoice ? 'Sí' : 'No',
                  items: <String>['Sí', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      invoice = newValue == 'Sí';
                    });
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Pagado',
                  ),
                  value: getPaid ? 'Sí' : 'No',
                  items: <String>['Sí', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      getPaid = newValue == 'Sí';
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: 'Notas',
                  ),
                ),              
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {

                String nameU = nameController.text.isNotEmpty ? nameController.text : "";
                DateTime activityDateU =  activityDateController.text.isNotEmpty ? DateTime.parse(activityDateController.text) : DateTime.now();
                int hoursU = hoursController.text.isNotEmpty ? int.parse(hoursController.text) : 0;
                int priceU = priceController.text.isNotEmpty ? int.parse(priceController.text) : 0;
                int ivaU = ivaController.text.isNotEmpty ? int.parse(ivaController.text) : 0;
                String notesU = notesController.text.isNotEmpty ? notesController.text : "";

                Company selectedCompanyU = selectedCompany != null ? selectedCompany! : companys.firstWhere((p) => p.id == 1);
                ActivityType selectedActivityTypeU = selectedtype != null ? selectedtype! : activityTypes.firstWhere((p) => p.id == 1);
               

              Activity updatedActivity = Activity(
                activity.id,
                selectedActivityTypeU,
                activityDateU,
                nameU,
                selectedCompanyU,
                hoursU,
                priceU,
                ivaU,
                invoice,
                getPaid,
                notesU,        
              
              );
              
              int index = activities.indexWhere((a) => a.id == activity.id);

              if (index >= 0) {
                print(activities[index].name);
              } else {
                print('Activity not found in list');
              }

              
              bool success = await updateActivity(updatedActivity);

              setState(() {
                    if (success) {
                      activities[index] =
                          updatedActivity;
                      
                      if(activity.type == updatedActivity.type){
                        int indexG = groupedActivities[activity.type]?.indexWhere((a) => a.id == activity.id) ?? -1;
                        if (indexG >= 0) {
                          groupedActivities[updatedActivity.type]?[indexG] = updatedActivity;
                        }
                        }else{
                          obtainGroupedActivities();
                        }

                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('¡La actividad ha sido modificada con éxito!'),
        ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Ha ocurrido un error al modificar la actividad.'),
                      ));
                  }
            });
                
                Navigator.of(context).pop();
              },
              child: Text("Guardar cambios"),
            ),
          ],
        );
      },
    );
}

Future<void> _showCreateActivityDialog(int nextActivityId) async {
  final _nameController = TextEditingController();
  final _activityDateController =
    TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  final _notesController = TextEditingController();
  final _hoursController = TextEditingController();
  final _priceController = TextEditingController();
  final _ivaController = TextEditingController();

  bool _invoice = false;
  bool _getPaid = false;

  ActivityType? selectedtype;
  Company? selectedCompany;

  List<DropdownMenuItem<ActivityType>> typeItems = activityTypes
      .map((activityType) => DropdownMenuItem(
            value: activityType,
            child: Text(activityType.name),
          ))
      .toList();

    List<DropdownMenuItem<Company>> companyItems = companys
      .map((company) => DropdownMenuItem(
            value: company,
            child: Text(company.name),
          ))
      .toList();


  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Crear actividad"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor introduzca un nombre de actividad';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _activityDateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor introduzca una fecha valida';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Fecha (yyyy-MM-dd)',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<ActivityType>(
                  value: selectedtype,
                  decoration: InputDecoration(
                    labelText: 'Tipo de actividad',
                  ),
                  items: typeItems,
                  onChanged: (value) {
                    setState(() {
                      selectedtype = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<Company>(
                  value: selectedCompany,
                  decoration: InputDecoration(
                    labelText: 'Empresa',
                  ),
                  items: companyItems,
                  onChanged: (value) {
                    setState(() {
                      selectedCompany = value;
                    });
                  },
                ),
                SizedBox(height: 10),
              TextField(
                  controller: _hoursController,
                  decoration: InputDecoration(
                    labelText: 'Horas',
                  ),
                ), 
                SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                  ),
                ), 
                SizedBox(height: 10),
                TextField(
                  controller: _ivaController,
                  decoration: InputDecoration(
                    labelText: 'IVA',
                  ),
                ), 
              
              DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Factura',
                  ),
                  value: _invoice ? 'Sí' : 'No',
                  items: <String>['Sí', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _invoice = newValue == 'Sí';
                    });
                  },
                ),
                SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Pagado',
                  ),
                  value: _getPaid ? 'Sí' : 'No',
                  items: <String>['Sí', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _getPaid = newValue == 'Sí';
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    labelText: 'Notas',
                  ),
                ), 
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Crear'),
            onPressed: () async {

                String nameU = _nameController.text.isNotEmpty ? _nameController.text : "";
                DateTime activityDateU =  _activityDateController.text.isNotEmpty ? DateTime.parse(_activityDateController.text) : DateTime.now();
                int hoursU = _hoursController.text.isNotEmpty ? int.parse(_hoursController.text) : 0;
                int priceU = _priceController.text.isNotEmpty ? int.parse(_priceController.text) : 0;
                int ivaU = _ivaController.text.isNotEmpty ? int.parse(_ivaController.text) : 0;
                String notesU = _notesController.text.isNotEmpty ? _notesController.text : "";

                Company selectedCompanyU = selectedCompany != null ? selectedCompany! : companys.firstWhere((p) => p.id == 1);
                ActivityType selectedActivityTypeU = selectedtype != null ? selectedtype! : activityTypes.firstWhere((p) => p.id == 1);
               

              Activity newActivity = Activity(
                nextActivityId,
                selectedActivityTypeU,
                activityDateU,
                nameU,
                selectedCompanyU,
                hoursU,
                priceU,
                ivaU,
                _invoice,
                _getPaid,
                notesU,        
              
              );


              int newID = await createActivity(newActivity);

                setState(() {
                    if (newID != 0) {
                      newActivity.id = newID;
                      activities.add(newActivity);
                      if(groupedActivities.containsKey(newActivity.type)){
                        groupedActivities[newActivity.type]?.add(newActivity);
                    }else{
                        obtainGroupedActivities();
                      }
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('¡La actividad ha sido creada con éxito!'),
        ));
                    }else{
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ha ocurrido un error al crear la actividad.'),
        ));
                    }
                  });

                Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TopPanel(1),
                  TopPanelEconomics(0),
                  TopButton(EconomicPage(), "Resumen de la actividad"),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: ListView.builder(
                        itemCount: groupedActivities.length,
                        itemBuilder: (context, index) {
                          var type = groupedActivities.keys.toList()[index];
                          var activitiesByType = groupedActivities[type];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Text(type.name, style: TextStyle(fontSize: 24)),
                              SizedBox(height: 8),
                                DataTable(
                                  columns: const [
                                    DataColumn(
                                      label: Text('Modificar'),
                                    ),
                                    DataColumn(
                                      label: Text('Borrar'),
                                    ),
                                    DataColumn(label: Text('Nombre')),
                                    DataColumn(label: Text('Cliente')),
                                    DataColumn(label: Text('Fecha')),
                                    DataColumn(label: Text('Horas')),
                                    DataColumn(label: Text('Precio')),
                                    DataColumn(label: Text('IVA')),
                                    DataColumn(label: Text('Factura')),
                                    DataColumn(label: Text('Pagado')),
                                    DataColumn(label: Text('Notas')),
                                  ],
                                  rows: activities.where((activity) => activity.type!.id == type.id)
                                  .map<DataRow>((activity) {
                                    return DataRow(cells: [
                                        DataCell(IconButton(
                                            icon: Icon(Icons.update),
                                            onPressed: () {
                                              _showEditActivityDialog(activity);
                                            },
                                          )),
                                          DataCell(IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                            _showDeleteConfirmationDialog(context, activity);
                                            },
                                        )),
                                      DataCell(Text(activity.name)),
                                      DataCell(Text(activity.company.name)),
                                      DataCell(Text(DateFormat('yyyy-MM-dd').format(activity.activityDate))),
                                      DataCell(Text(activity.hours.toString())),
                                      DataCell(Text(activity.price.toString())),
                                      DataCell(Text(activity.iva.toString())),
                                      DataCell(Text(activity.invoice ? 'Sí' : 'No')),
                                      DataCell(Text(activity.getPaid ? 'Sí' : 'No')),
                                      DataCell(Text(activity.notes)),
                                    ]);
                                  }).toList() ?? [],
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showCreateActivityDialog(activities.last.id + 1);
          },
          tooltip: 'Crear una nueva actividad',
          child: const Icon(Icons.add),
      
        
          ),
    );
  }
}