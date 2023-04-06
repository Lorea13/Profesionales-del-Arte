import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/helpers/urls.dart';

import 'package:frontend/models/personType.dart';
import 'package:frontend/models/person.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../helpers/methods.dart';
import 'home.dart';



class ContactPage extends StatefulWidget {
  List<PersonType> personTypes;
  List<Person> people;

  ContactPage(this.personTypes, this.people,
      {Key? key})
      : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Future<bool> obtainUpdatedData() async {

    Future<List<Person>> futurePeople = getPeople(widget.personTypes);
    widget.people = await futurePeople;

    return true;
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, Person person) async {
    bool delete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this person?'),
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
      bool success = await deletePerson(person.id);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Person deleted successfully!'),
        ));
        setState(() {
          widget.people.remove(person);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred while deleting the person.'),
        ));
      }
    }
  }

  Future<void> _showEditPersonDialog(Person person) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactDateController = TextEditingController();
  TextEditingController contactDescriptionController = TextEditingController();
  TextEditingController projectsController = TextEditingController();
  TextEditingController webPageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  PersonType? personType;

  List<DropdownMenuItem<PersonType>> typeItems = widget.personTypes
      .map((peronType) => DropdownMenuItem(
            value: personType,
            child: Text(person.type.name),
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
                  labelText: person.name,
                ),
              ),
              TextField(
                controller: contactDateController,
                decoration: InputDecoration(
                  labelText: DateFormat('yyyy-MM-dd').format(person.contactDate),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: contactDateController,
                decoration: InputDecoration(
                labelText: DateFormat('yyyy-MM-dd').format(person.contactDate),
                ),
              ),
              DropdownButtonFormField<PersonType>(
                value: personType,
                decoration: InputDecoration(
                  labelText: person.type.name,
                ),
                items: typeItems,
                onChanged: (value) {
                  setState(() {
                    personType = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: projectsController,
                decoration: InputDecoration(
                labelText: person.projects,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: webPageController,
                decoration: InputDecoration(
                labelText: person.webPage,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                labelText: person.email,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                labelText: person.phone,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                labelText: person.notes,
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
              person.type = personType!;
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


//Falta el alert dialog de create





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text('Id'),
            ),
            DataColumn(
              label: Text('Type'),
            ),
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Text('C. Date'),
            ),
            DataColumn(
              label: Text('C. Description'),
            ),
            DataColumn(
              label: Text('Projects'),
            ),
            DataColumn(
              label: Text('WebPage'),
            ),
            DataColumn(
              label: Text('Email'),
            ),
            DataColumn(
              label: Text('Phone'),
            ),
            DataColumn(
              label: Text('Notes'),
            ),
            DataColumn(
              label: Text('Update'),
            ),
             DataColumn(
              label: Text('Delete'),
            ),
          ],
          rows: widget.people
              .map((person) => DataRow(cells: [
                    DataCell(Text(person.id.toString())),
                    DataCell(Text(person.type.name)),
                    DataCell(Text(person.name)),
                    DataCell(Text(DateFormat('yyyy-MM-dd').format(person.contactDate))),
                    DataCell(Text(person.contactDescription)),
                    DataCell(Text(person.projects)),
                    DataCell(Text(person.webPage)),
                    DataCell(Text(person.email)),
                    DataCell(Text(person.phone)),
                    DataCell(Text(person.notes)),
                    DataCell(IconButton(
                      icon: Icon(Icons.update),
                      onPressed: () {
                        _showEditPersonDialog(person);
                      },
                    )),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                       _showDeleteConfirmationDialog(context, person);
                      },
                  )),
                  ]))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         // _showCreatePersonDialog();
        },
        tooltip: 'Create a New Person',
        child: const Icon(Icons.add),
      ),
      );
  }
}