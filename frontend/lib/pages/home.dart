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
  int _currentIndex = 0;

  void _onNavigationItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopPanel(0, widget.personTypes, widget.people, widget.castings, widget.companys, widget.activityTypes, widget.activities),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text('Castings'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CastingPage(widget.personTypes, widget.people, widget.castings)),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Contactos'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage(widget.personTypes, widget.people, widget.castings)),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Contactos de directores'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DirectorPage(widget.personTypes, widget.people, widget.castings)),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de directores de casting'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CastingDirectorPage(widget.personTypes, widget.people, widget.castings)),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de compañías de teatro'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TheatreCompanyPage(widget.personTypes, widget.people, widget.castings)),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de productoras'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductionCompanyPage(widget.personTypes, widget.people, widget.castings)),
                );
              },
            ),
            SizedBox(height: 20),
             ElevatedButton(
              child: Text('Contactos de representatnes'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductionCompanyPage(widget.personTypes, widget.people, widget.castings)),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}