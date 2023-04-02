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

import '../helpers/methods.dart';



class Home extends StatefulWidget {
  List<PersonType> personTypes;
  List<Person> people;
  List<Casting> castings;
  List<Company> companys;
  List<ActivityType> activityTypes;
  List<Activity> activities;

  Home(this.personTypes, this.people, this.castings, this.companys, this.activityTypes, this.activities,
      {Key? key})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<bool> obtainUpdatedData() async {
    Future<List<Person>> futurePeople = getPeople(widget.personTypes);
    widget.people = await futurePeople;

    Future<List<Casting>> futureCastings = getCastings(widget.people);
    widget.castings = await futureCastings;

    return true;
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, Casting casting) async {
    bool delete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this casting?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (delete == true) {
      bool success = await deleteCasting(casting.id);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Casting deleted successfully!'),
        ));
        setState(() {
          widget.castings.remove(casting);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred while deleting the casting.'),
        ));
      }
    }
  }

  Future<void> _showEditCastingDialog(Casting casting) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool inProcess = false;
  bool inPerson = false;

  Person? castingDirector;
  Person? director;

  List<DropdownMenuItem<Person>> castingDirectorItems = widget.people
      .where((person) => person.type!.name == "castingDirector")
      .map((person) => DropdownMenuItem(
            value: person,
            child: Text(person.name),
          ))
      .toList();

  List<DropdownMenuItem<Person>> directorItems = widget.people
      .where((person) => person.type!.name == "director")
      .map((person) => DropdownMenuItem(
            value: person,
            child: Text(person.name),
          ))
      .toList();

  castingDirectorItems.insert(
      0,
      DropdownMenuItem(
        value: null,
        child: Text('Seleccione un casting director'),
      ));

  directorItems.insert(
      0, DropdownMenuItem(value: null, child: Text('Seleccione un director')));

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Editar casting"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                ),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date (yyyy-MM-dd)',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Person>(
                value: castingDirector,
                decoration: InputDecoration(
                  labelText: "Director de casting",
                ),
                items: castingDirectorItems,
                onChanged: (value) {
                  setState(() {
                    castingDirector = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Person>(
                value: director,
                decoration: InputDecoration(
                  labelText: "Director",
                ),
                items: directorItems,
                onChanged: (value) {
                  setState(() {
                    director = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'In Person',
                ),
                value: inPerson ? 'Sí' : 'No',
                items: <String>['Sí', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    inPerson = newValue == 'Sí';
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'In Process',
                ),
                value: inProcess ? 'Sí' : 'No',
                items: <String>['Sí', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    inProcess = newValue == 'Sí';
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  labelText: "Notas",
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
              casting.date = DateTime.parse(dateController.text);
              casting.name = nameController.text;
              casting.castingDirector = castingDirector!;
              casting.director = director!;
              casting.inPerson = inPerson;
              casting.inProcess = inProcess;
              casting.notes = notesController.text;

              bool success = await updateCasting(casting);
              
              Navigator.of(context).pop();
              await obtainUpdatedData();
            },
            child: Text("Guardar cambios"),
          ),
        ],
      );
    },
  );
}


/// setState(() {
  ///if (success) {
 /// widget.dinosaurs[widget.dinosaurs.indexOf(dinosaur)] = updatedDinosaur;
    ///                }
       ///           }



 ///if (delete == true) {
     /// bool success = deleteCasting(casting.id);

    ///  if (success) {
   ///     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      ///    content: Text('Casting deleted successfully!'),
     ///   ));
    ///    setState(() {
       ///   widget.castings.remove(casting);
  ///      });
  ///    } else {
   ///     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
   ///       content: Text('An error occurred while deleting the casting.'),
   ///     ));
  ///    }
  ///  }







Future<void> _showCreateCastingDialog() async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();
  bool _inPerson = false;
  bool _inProcess = false;
  Person? _castingDirector;
  Person? _director;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Create Casting"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid date';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Date (yyyy-MM-dd)',
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<Person>(
                value: _castingDirector,
                items: widget.people
                    .map<DropdownMenuItem<Person>>((Person value) {
                  return DropdownMenuItem<Person>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (Person? newValue) {
                  setState(() {
                    _castingDirector = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Director de casting',
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<Person>(
                value: _director,
                items: widget.people
                    .map<DropdownMenuItem<Person>>((Person value) {
                  return DropdownMenuItem<Person>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (Person? newValue) {
                  setState(() {
                    _director = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Director',
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'In Person',
                ),
                value: _inPerson ? 'Sí' : 'No',
                items: <String>['Sí', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _inPerson = newValue == 'Sí';
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'In Process',
                ),
                value: _inProcess ? 'Sí' : 'No',
                items: <String>['Sí', 'No']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _inProcess = newValue == 'Sí';
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Create'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Casting newCasting = Casting(widget.castings.length + 1,
                  DateTime.parse(_dateController.text),
                  _nameController.text,
                  _castingDirector!,
                  _director!,
                  _inPerson,
                  _inProcess,
                  _notesController.text,
                );

                await createCasting(newCasting);

                setState(() {
                  widget.castings.add(newCasting);
                });

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text('Id'),
            ),
            DataColumn(
              label: Text('Date'),
            ),
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Text('Casting Director'),
            ),
            DataColumn(
              label: Text('Director'),
            ),
            DataColumn(
              label: Text('InPerson'),
            ),
            DataColumn(
              label: Text('InProcess'),
            ),
            DataColumn(
              label: Text('Notes'),
            ),
          ],
          rows: widget.castings
              .map((casting) => DataRow(cells: [
                    DataCell(Text(casting.id.toString())),
                    DataCell(Text(DateFormat('yyyy-MM-dd').format(casting.date))),
                    DataCell(Text(casting.name)),
                    DataCell(Text(casting.castingDirector.name)),
                    DataCell(Text(casting.director.name)),
                    DataCell(Text(casting.inPerson ? 'Sí' : 'No')),
                    DataCell(Text(casting.inProcess ? 'Sí' : 'No')),
                    DataCell(Text(casting.notes)),
                  ]))
              .toList(),
        ),
      ),
      
      );
  }
}