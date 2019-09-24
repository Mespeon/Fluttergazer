import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttergazer/constants.dart';

import 'package:fluttergazer/main.dart';
import 'package:fluttergazer/cards.dart';
import 'package:fluttergazer/profile.dart';
import 'package:fluttergazer/boilnierplate.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => OnboardingPage());

      case cardListings:
        return MaterialPageRoute(builder: (_) => CardListings());

      case memberProfile:
        var member = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProfilePage(member));

      case boilnierplate:
        return MaterialPageRoute(builder: (_) => Boilnierplate());

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text('Page does not exist'),
            automaticallyImplyLeading: true,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.pink[400]),
              Center(
                child: Text('Route is empty.'),
              )
            ],
          )
        ));
    }
  }
}