import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/helpers/urls.dart';

import 'package:frontend/models/company.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../helpers/methods.dart';
import '../fragments/topPanel.dart';
import '../fragments/topButton.dart';
import 'home.dart';



class CompanyPage extends StatefulWidget {

  CompanyPage(
      {Key? key})
      : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {

  bool _isLoading = true;

  List<Company> companys = [];

  obtainDataApi() async {
    await obtainCompanys();

    setState(() {
      _isLoading = false;
    });
  }

   obtainCompanys() async {
    Future<List<Company>> futureCompanys = getCompanys();

    companys = await futureCompanys;
  }

  Future<bool> obtainUpdatedData() async {

    Future<List<Company>> futureCompanys = getCompanys();

    companys = await futureCompanys;

    return true;
  }



  Future<void> _showDeleteConfirmationDialog(BuildContext context, Company company) async {
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
      bool success = await deleteCompany(company.id);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('¡La compañía ha sido eliminado con éxito!'),
        ));
        setState(() {
          companys.remove(company);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ha ocurrido un error al eliminar la compañia.'),
        ));
      }
    }
  }






  Future<void> _showEditCompanyDialog(Company company) async {
    TextEditingController nameController = TextEditingController(text: company.name);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar compañia"),
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

                Company updatedCompany = Company(
                      company.id,
                      nameController.text);
                  bool success = await updateCompany(updatedCompany);

                  setState(() {
                    if (success) {
                      companys[companys.indexOf(company)] =
                          updatedCompany;
                    }
                  });

                  Navigator.pop(context);   
               
              },
              child: Text("Guardar cambios"),
            ),
          ],
        );
      },
    );
}

Future<void> _showCreateCompanyDialog(int nextCompanyId) async {
  final _nameController = TextEditingController();
 


  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Crear compañia"),
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
                Company newCompany = Company(
                  nextCompanyId,
                  _nameController.text,
                 
                );

                int newID = await createCompany(newCompany);

                setState(() {
                    if (newID != 0) {
                      newCompany.id = newID;
                      companys.add(newCompany);
                    }
                  });

                Navigator.of(context).pop();
                await obtainUpdatedData();
                
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
                                  label: Text('Id'),
                                ),
                                DataColumn(
                                  label: Text('Nombre'),
                                ),
                                
                              ],
                              rows: companys
                                  .map((company) => DataRow(cells: [
                                        DataCell(IconButton(
                                          icon: Icon(Icons.update),
                                          onPressed: () {
                                            _showEditCompanyDialog(company);
                                          },
                                        )),
                                        DataCell(IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                          _showDeleteConfirmationDialog(context, company);
                                          },
                                      )),
                                        DataCell(Text(company.id.toString())),
                                        DataCell(Text(company.name)),
                                        
                                        
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
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showCreateCompanyDialog(companys.last.id + 1);
          },
          tooltip: 'Crear una nueva actividad',
          child: const Icon(Icons.add),
      
         ),
        
    );
  }
}