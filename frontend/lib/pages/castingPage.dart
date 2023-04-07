import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/helpers/urls.dart';

import 'package:frontend/models/personType.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/models/casting.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../helpers/methods.dart';
import 'home.dart';



class CastingPage extends StatefulWidget {
  List<PersonType> personTypes;
  List<Person> people;
  List<Casting> castings;

  CastingPage(this.personTypes, this.people, this.castings,
      {Key? key})
      : super(key: key);

  @override
  State<CastingPage> createState() => _CastingPageState();
}

class _CastingPageState extends State<CastingPage> {
  Future<bool> obtainUpdatedData() async {

    Future<List<Casting>> futureCastings = getCastings(widget.people);
    widget.castings = await futureCastings;

    return true;
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, Casting casting) async {
    bool delete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación de borrado'),
          content: Text('¿Estás seguro de que quieres borrar este casting?'),
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
      bool success = await deleteCasting(casting.id);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('¡El casting ha sido eliminado con éxito!'),
        ));
        setState(() {
          widget.castings.remove(casting);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ha ocurrido un error al eliminar el casting.'),
        ));
      }
    }
  }

  Future<void> _showEditCastingDialog(Casting casting) async {
  TextEditingController nameController = TextEditingController(text: casting.name);
  TextEditingController notesController = TextEditingController(text: casting.notes);
  TextEditingController castingDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(casting.castingDate));
  bool inProcess = casting.inProcess;
  bool inPerson = casting.inPerson;

  Person? selectedCastingDirector = casting.castingDirector;
  Person? selectedDirector = casting.director;

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
                  labelText: 'Nombre',
                ),
              ),
              TextField(
                controller: castingDateController,
                decoration: InputDecoration(
                  labelText: 'Fecha (yyyy-MM-dd)',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Person>(
                value: selectedCastingDirector,
                decoration: InputDecoration(
                  labelText: 'Director de casting',
                ),
                items: castingDirectorItems,
                onChanged: (value) {
                  setState(() {
                    selectedCastingDirector = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Person>(
                value: selectedDirector,
                decoration: InputDecoration(
                  labelText: 'Director',
                ),
                items: directorItems,
                onChanged: (value) {
                  setState(() {
                    selectedDirector = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Presencial',
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
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'En proceso',
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
              casting.castingDate = DateTime.parse(castingDateController.text);
              casting.name = nameController.text;
              casting.castingDirector = selectedCastingDirector!;
              casting.director = selectedDirector!;
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
  final _castingDateController = TextEditingController();
  final _notesController = TextEditingController();
  bool _inPerson = false;
  bool _inProcess = false;

  Person? selectedCastingDirector;
  Person? selectedDirector;

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


  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Crear casting"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor introduzca un nombre';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _castingDateController,
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
              DropdownButtonFormField<Person>(
                value: selectedCastingDirector,
                decoration: InputDecoration(
                  labelText: "Director de casting",
                ),
                items: castingDirectorItems,
                onChanged: (value) {
                  setState(() {
                    selectedCastingDirector = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Person>(
                value: selectedDirector,
                decoration: InputDecoration(
                  labelText: "Director",
                ),
                items: directorItems,
                onChanged: (value) {
                  setState(() {
                    selectedDirector = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Presencial',
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
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'En proceso',
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
              SizedBox(height: 10),
              TextFormField(
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
                Casting newCasting = Casting(10,
                  DateTime.parse(_castingDateController.text),
                  _nameController.text,
                  selectedCastingDirector!,
                  selectedDirector!,
                  _inPerson,
                  _inProcess,
                  _notesController.text,
                );

                int newID = await createCasting(newCasting);

                setState(() {
                    if (newID != 0) {
                      newCasting.id = newID;
                      widget.castings.add(newCasting);
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text('Modificar'),
                          ),
                          DataColumn(
                            label: Text('Borrar'),
                          ),
                          DataColumn(
                            label: Text('Nombre'),
                          ),
                          DataColumn(
                            label: Text('Fecha'),
                          ),
                          DataColumn(
                            label: Text('Dir. casting'),
                          ),
                          DataColumn(
                            label: Text('Director'),
                          ),
                          DataColumn(
                            label: Text('Presencial'),
                          ),
                          DataColumn(
                            label: Text('En proceso'),
                          ),
                          DataColumn(
                            label: Text('Notas'),
                          ),
                        
                        ],
                        rows: widget.castings
                            .map((casting) => DataRow(cells: [
                                  DataCell(IconButton(
                                    icon: Icon(Icons.update),
                                    onPressed: () {
                                      _showEditCastingDialog(casting);
                                    },
                                  )),
                                  DataCell(IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                    _showDeleteConfirmationDialog(context, casting);
                                    },
                                )),
                                  DataCell(Text(casting.name)),
                                  DataCell(Text(DateFormat('yyyy-MM-dd').format(casting.castingDate))),
                                  DataCell(Text(casting.castingDirector.name)),
                                  DataCell(Text(casting.director.name)),
                                  DataCell(Text(casting.inPerson ? 'Sí' : 'No')),
                                  DataCell(Text(casting.inProcess ? 'Sí' : 'No')),
                                  DataCell(Text(casting.notes)),
                                  
                                ]))
                            .toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showCreateCastingDialog();
          },
          tooltip: 'Crear un nuevo casting',
          child: const Icon(Icons.add),
        ),
        
    );
  }
}