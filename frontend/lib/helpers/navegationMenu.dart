import 'package:flutter/material.dart';

class NavigationDrawerX extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavigationItemSelected;

  NavigationDrawerX({
    required this.currentIndex,
    required this.onNavigationItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Profesionales de las artes escenicas'),
          ),
          ListTile(
            title: Text('Inicio'),
            onTap: () {
              onNavigationItemSelected(0);
              Navigator.pop(context);
            },
            tileColor:
                currentIndex == 0 ? Colors.blue.withOpacity(0.5) : null,
            selected: currentIndex == 0,
          ),
          ListTile(
            title: Text('Casting'),
            onTap: () {
              onNavigationItemSelected(1);
              Navigator.pop(context);
            },
            tileColor:
                currentIndex == 1 ? Colors.blue.withOpacity(0.5) : null,
            selected: currentIndex == 1,
          ),
          ListTile(
            title: Text('Economico'),
            onTap: () {
              onNavigationItemSelected(2);
              Navigator.pop(context);
            },
            tileColor:
                currentIndex == 2 ? Colors.blue.withOpacity(0.5) : null,
            selected: currentIndex == 2,
          ),
          ListTile(
            title: Text('Contactos'),
            onTap: () {
              onNavigationItemSelected(3);
              Navigator.pop(context);
            },
            tileColor:
                currentIndex == 3 ? Colors.blue.withOpacity(0.5) : null,
            selected: currentIndex == 3,
          ),
        ],
      ),
    );
  }
}
