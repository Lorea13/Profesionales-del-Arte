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

import '../fragments/topPanel.dart';
import '../fragments/topPanelContacts.dart';
import 'home.dart';



class CastingDirectorPage extends StatefulWidget {
    

  CastingDirectorPage(
      {Key? key})
      : super(key: key);

  @override
  State<CastingDirectorPage> createState() => _CastingDirectorPageState();
}

class _CastingDirectorPageState extends State<CastingDirectorPage> {

  bool _isLoading = true;

    List<PersonType> personTypes = [];
    List<Person> people = [];
    List<Casting> castings = [];

  obtainDataApi() async {
    await obtainPersonTypes();
    await obtainPeople();
    await obtainCastings();

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

 
  Future<bool> obtainUpdatedData() async {

    Future<List<Person>> futurePeople = getPeople(personTypes);
    people = await futurePeople;

    return true;
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, Person person) async {
    bool delete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación de borrado'),
          content: Text('¿Estás seguro de que quieres borrar esta persona?'),
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
      bool success = await deletePerson(person.id);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('¡La Persona ha sido eliminada con éxito!'),
        ));
        setState(() {
          people.remove(person);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ha ocurrido un error al eliminar la persona.'),
        ));
      }
    }
  }

  Future<void> _showEditPersonDialog(Person person) async {
  TextEditingController nameController = TextEditingController(text: person.name);
  TextEditingController contactDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(person.contactDate));
  TextEditingController contactDescriptionController = TextEditingController(text: person.contactDescription);
  TextEditingController projectsController = TextEditingController(text: person.projects);
  TextEditingController webPageController = TextEditingController(text: person.webPage);
  TextEditingController emailController = TextEditingController(text: person.email);
  TextEditingController phoneController = TextEditingController(text: person.phone);
  TextEditingController notesController = TextEditingController(text: person.notes);
  PersonType? selectedPersonType = person.type;

  List<DropdownMenuItem<PersonType>> typeItems = personTypes
      .map((personType) => DropdownMenuItem(
            value: personType,
            child: Text(personType.name),
          ))
      .toList();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Editar persona"),
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
                controller: contactDateController,
                decoration: InputDecoration(
                  labelText: 'Fecha (yyyy-MM-dd)',
                ),
              ),
              TextField(
                controller: contactDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Decripcion de la fecha',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<PersonType>(
                value: selectedPersonType,
                decoration: InputDecoration(
                  labelText: 'Tipo de persona',
                ),
                items: typeItems,
                onChanged: (value) {
                  setState(() {
                    selectedPersonType = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: projectsController,
                decoration: InputDecoration(
                labelText: 'Proyectos',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: webPageController,
                decoration: InputDecoration(
                labelText: 'Pagina web',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                labelText: 'Email',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                labelText: 'Telefono',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                labelText: 'Notas',
                ),
              ),
              SizedBox(height: 10),
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
              person.type = selectedPersonType!;
              person.contactDate = DateTime.parse(contactDateController.text);
              person.contactDescription = contactDescriptionController.text;
              person.projects = projectsController.text;
              person.webPage = webPageController.text;
              person.email = emailController.text;
              person.phone = phoneController.text;
              person.notes = notesController.text;

              bool success = await updatePerson(person);
              
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





Future<void> _showCreatePersonDialog() async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactDateController = TextEditingController();
  final _contactDescriptionController = TextEditingController();
  final _projectsController = TextEditingController();
  final _webPageController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  PersonType? selectedPersonType;

  List<DropdownMenuItem<PersonType>> typeItems = personTypes
      .map((personType) => DropdownMenuItem(
            value: personType,
            child: Text(personType.name),
          ))
      .toList();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Crear contacto"),
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
                controller: _contactDateController,
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
              DropdownButtonFormField<PersonType>(
                value: selectedPersonType,
                decoration: InputDecoration(
                  labelText: 'Tipo de persona',
                ),
                items: typeItems,
                onChanged: (value) {
                  setState(() {
                    selectedPersonType = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _projectsController,
                decoration: InputDecoration(
                labelText: 'Proyectos',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _webPageController,
                decoration: InputDecoration(
                labelText: 'Pagina web',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                labelText: 'Email',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                labelText: 'Telefono',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                labelText: 'Notas',
                ),
              ),
              SizedBox(height: 10),
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
                Person newPerson = Person(100,
                  selectedPersonType!,
                  _nameController.text,
                  DateTime.parse(_contactDateController.text),
                  _contactDescriptionController.text,
                  _projectsController.text,
                  _webPageController.text,
                  _emailController.text,
                  _phoneController.text,
                  _notesController.text,
                );

                int newID = await createPerson(newPerson);

                setState(() {
                    if (newID != 0) {
                      newPerson.id = newID;
                      people.add(newPerson);
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
          ? Column()
          : Column(
              children: [
                TopPanel(3),
                TopPanelContacts(1),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child:  DataTable(
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
                                label: Text('Fecha c.'),
                              ),
                              DataColumn(
                                label: Text('Descripcion c.'),
                              ),
                              DataColumn(
                                label: Text('Proyectos'),
                              ),
                              DataColumn(
                                label: Text('Web'),
                              ),
                              DataColumn(
                                label: Text('Email'),
                              ),
                              DataColumn(
                                label: Text('Tel'),
                              ),
                              DataColumn(
                                label: Text('Notas'),
                              ),
                            ],
                            rows: people.where((person) => person.type!.name == "castingDirector")
                                .map((person) => DataRow(cells: [
                                      DataCell(IconButton(
                                        icon: Icon(Icons.update),
                                        onPressed: () {
                                          _showEditPersonDialog(person);
                                        },
                                      )),
                                      DataCell(IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                        if(!castings.any((casting) => casting.director?.id == person.id || casting.castingDirector?.id == person.id)) {
                                            _showDeleteConfirmationDialog(context, person);
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('No se puede eliminar este contacto porque tiene un casting asociado.'),
                                            ));
                                            }
                                        },
                                    )),
                                      DataCell(Text(person.name)),
                                      DataCell(Text(DateFormat('yyyy-MM-dd').format(person.contactDate))),
                                      DataCell(Text(person.contactDescription)),
                                      DataCell(Text(person.projects)),
                                      DataCell(Text(person.webPage)),
                                      DataCell(Text(person.email)),
                                      DataCell(Text(person.phone)),
                                      DataCell(Text(person.notes)),
                                      
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         _showCreatePersonDialog();
        },
        tooltip: 'Crear una nueva persona',
        child: const Icon(Icons.add),
      ),
      );
  }
}

 