import 'package:flutter/material.dart';

import 'package:lovelive/cards.dart';
import 'package:lovelive/boilnierplate.dart';
import 'package:lovelive/constants.dart';
import 'package:lovelive/route/router.dart';

void main() => runApp(MyApp());

// The parent widget for the whole app.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}

// The root page for the app.
class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Fluttergazer')
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text('View LLSIF Members'),
                onPressed: () { Navigator.pushNamed(context, cardListings); },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('View Boilnierplate'),
                onPressed: () { Navigator.pushNamed(context, boilnierplate); },
              )
            )
          ],
        )
      )
    );
  }
}