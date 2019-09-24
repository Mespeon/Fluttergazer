import 'package:flutter/material.dart';
import 'package:fluttergazer/constants.dart';

class TheDrawer extends StatelessWidget {
  final TextStyle _drawerParentHeader = TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.w700);

  // Create the list tile item in the drawer
  createDrawerItem(icon, iconColoration, String title, String subtitle, context, String route) {
    return ListTile(
      leading: Icon(icon, color: iconColoration),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        if (route == homeRoute) {
          print('Popuntil');
          Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
        }
        else {
          print('popAndPush');
          Navigator.popAndPushNamed(context, route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Container(
              color: Colors.pink[500],
              child: Center(
                child: Text('Fluttergazer', style: _drawerParentHeader)
              )
            )
          ),
          createDrawerItem(Icons.home, Colors.grey[500], 'Home', '', context, homeRoute),
          createDrawerItem(Icons.favorite, Colors.pink[500], 'LL! SIF Members', 'using Sibyl API', context, cardListings),
          createDrawerItem(Icons.developer_mode, Colors.blue[500], 'Boilnierplate', 'using Boilnerplate API', context, boilnierplate),
          createDrawerItem(Icons.directions, Colors.grey[500], 'GetStylin Flight', 'using Hero animations', context, getstylinHero),
          createDrawerItem(Icons.directions, Colors.grey[500], 'Stargazer Flight', 'using Hero animations', context, stargazerHero)
        ],
      ),
    );
  }
}