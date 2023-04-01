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
  Home(this.personTypes, this.people, this.castings,
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