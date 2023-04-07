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



class EconomicPage extends StatefulWidget {
  List<ActivityType> activityTypes;
  List<Activity> activities;
  List<Company> companys;

  EconomicPage(this.activityTypes, this.activities, this.companys,
      {Key? key})
      : super(key: key);

  @override
  State<EconomicPage> createState() => _EconomicPageState();
}

class _EconomicPageState extends State<EconomicPage> {
  Future<bool> obtainUpdatedData() async {

    Future<List<Activity>> futureActivities = getActivities(widget.activityTypes, widget.companys);
    widget.activities = await futureActivities;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    )
  }
}