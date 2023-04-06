import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/home.dart';

import '../helpers/CustomPageRoute.dart';
import '../pages/Decisions.dart';
import '../pages/Graphics.dart';
import '../pages/Sales.dart';
import '../pages/Settings.dart';
import '../pages/Warehouse.dart';

Color mainColor = Colors.purple;
Color selectedColor = const Color.fromARGB(201, 155, 39, 176);
Color textColor = Colors.white;

class TopPanel extends StatelessWidget {
  final int _count;

  const TopPanel(this._count, {Key? key}) : super(key: key);

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
                Navigator.push(context, CustomPageRoute(child: const Home()));
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
                    context, CustomPageRoute(child: const Warehouse()));
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
                Navigator.push(context, CustomPageRoute(child: const Sales()));
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
                    context, CustomPageRoute(child: const Graphics()));
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
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, CustomPageRoute(child: const Decisions()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.12,
                color: _count == 4 ? selectedColor : mainColor,
                child: Icon(
                  Icons.balance_rounded,
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
                    context, CustomPageRoute(child: const Settings()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.height * 0.12,
                color: _count == 5 ? selectedColor : mainColor,
                child: Icon(
                  Icons.settings_rounded,
                  size: MediaQuery.of(context).size.width / 1000 * 32,
                  color: textColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
