import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lovelive/constants.dart';

import 'package:lovelive/main.dart';
import 'package:lovelive/cards.dart';
import 'package:lovelive/profile.dart';
import 'package:lovelive/boilnierplate.dart';

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
          body: Text('No route specified for this path.')
        ));
    }
  }
}