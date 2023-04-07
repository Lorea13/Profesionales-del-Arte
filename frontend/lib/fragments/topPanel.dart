import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/home.dart';

import '../helpers/mehotds.dart';
import '../pages/contactPage.dart';
import '../pages/economicPage.dart';
import '../pages/home.dart';
import '../pages/castinPage.dart';

Color mainColor = Colors.purple;
Color selectedColor = const Color.fromARGB(201, 155, 39, 176);
Color textColor = Colors.white;

class TopPanel extends StatelessWidget {
  final int _count;
  List<PersonType> personTypes;
  List<Person> people;
  List<Casting> castings;
  List<Company> companys;
  List<ActivityType> activityTypes;
  List<Activity> activities;

  const TopPanel(this._count, this.personTypes, this.people, this.castings, this.companys, this.activityTypes, this.activities,
  {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, Home(personTypes, people, castings, companys, activityTypes, activities));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.12,
                color: _count == 0 ? selectedColor : mainColor,
                child: Icon(
                  Icons.home_rounded,
                  size: MediaQuery.of(context).size.width / 1000 * 32,
                  color: textColor,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, EconomicPage(activityTypes, activities, companys));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.12,
                color: _count == 1 ? selectedColor : mainColor,
                child: Icon(
                  Icons.warehouse_rounded,
                  size: MediaQuery.of(context).size.width / 1000 * 32,
                  color: textColor,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CastingPage(personTypes, people, castings));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.12,
                color: _count == 2 ? selectedColor : mainColor,
                child: Icon(
                  Icons.attach_money_rounded,
                  size: MediaQuery.of(context).size.width / 1000 * 32,
                  color: textColor,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, ContactPage(personTypes, people, castings));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.12,
                color: _count == 3 ? selectedColor : mainColor,
                child: Icon(
                  CupertinoIcons.graph_square_fill,
                  size: MediaQuery.of(context).size.width / 1000 * 32,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
