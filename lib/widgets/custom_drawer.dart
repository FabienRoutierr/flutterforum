import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Accueil'),
            onTap: () {
              Navigator.pop(context); 
              if (ModalRoute.of(context)?.settings.name != '/') {
                Navigator.pushNamed(context, '/'); 
              }
            },
          ),
          ListTile(
            title: Text('Liste des Questions'),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/questions') {
                Navigator.pushNamed(context, '/questions'); 
              }
            },
          ),
        ],
      ),
    );
  }
}
