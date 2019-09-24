import 'package:flutter/material.dart';
import 'package:fluttergazer/components/drawer.dart';

// Routing
import 'package:fluttergazer/constants.dart';
import 'package:fluttergazer/route/router.dart';

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
      drawer: TheDrawer(),
      appBar: AppBar(
        title: Text('Fluttergazer', style: TextStyle(color: Colors.pink[400])),
        elevation: 0.0,
        backgroundColor: Colors.white10,
        iconTheme: IconThemeData(color: Colors.pink[400]),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: 
            ListBody(
              children: <Widget>[
                Center(child: Icon(Icons.info_outline, color: Colors.pink[200], size: 40.0,)),
                Center(child: Text('Open the drawer to begin.')),
              ],
            ),
            color: Colors.white10
          )
        ],
      )
      // body: Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Center(
      //         child: RaisedButton(
      //           child: Text('View LLSIF Members'),
      //           onPressed: () { Navigator.pushNamed(context, cardListings); },
      //         ),
      //       ),
      //       Center(
      //         child: RaisedButton(
      //           child: Text('View Boilnierplate'),
      //           onPressed: () { Navigator.pushNamed(context, boilnierplate); },
      //         )
      //       )
      //     ],
      //   )
      // )
    );
  }
}