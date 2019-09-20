import 'package:flutter/material.dart';
import 'package:lovelive/model/sif_model.dart';
import 'package:lovelive/services/lovelive_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('Go to sample API call'),
          onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardListings())); },
        )
      )
    );
  }
}

// Stateful Widget for the actual Card List
class CardList extends StatefulWidget {
  @override
  CardListState createState() => CardListState();
}

// CardListState
class CardListState extends State<CardList> {
//  List<String> memberCards = List();

  @override
  Widget build(BuildContext context) {
     return ListView(
       children: [
         Center(
           child: FutureBuilder(
             future: getMembers(),
             builder: (context, snapshot) {
               List<Widget> dataMembers = List<Widget>();
               if (snapshot.hasData) {
                 for (var i = 0; i <= snapshot.data.data.muse.length - 1; i++) {
                   var mem = snapshot.data.data.muse[i].toJson();
                   print('${mem}');
                   dataMembers.add(
                       Text('${mem['name']}' + ' ' + '${mem['voice']}')
                   );
                 }

                 return Column(
                   children: dataMembers
                 );
               }
               else if (snapshot.hasError){
                 return Text('${snapshot.error}');
               }
               return CircularProgressIndicator();
             }
           )
         )
       ]
     );
   }
}

class CardListings extends StatelessWidget {
  deserializeData(muse, aqours) {
    List members = new List();

    for (var m=0; m <= muse.length - 1; m++) {
      var member = muse[m].toJson();
      members.add(member);
    }

    for (var a=0; a <= aqours.length - 1; a++) {
      var member = aqours[a].toJson();
      members.add(member);
    }

    print('From deserializeData: $members');

    return members;
  }

  Widget setTextWidgets(List<String> data) {
    return new Row(children:
      data.map((member) => new Text(member)).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members')
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: CardList()
              )
          )
        ]
      )
    );
  }
}

// Sliver Grids
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            floating: false,
            expandedHeight: 300,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () { Navigator.pop(context); },
              color: Colors.pink[500]
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: Center(
                  child: Text('u\'s', style: TextStyle(color: Colors.pink[500], fontSize: 56, fontWeight: FontWeight.w500))
                )
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1
            ),
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('Grid item $index', style: TextStyle(fontFamily: 'Roboto'))
                  );
                },
            childCount: 20
            ),
          ),
        ],
      )
    );
//    return CustomScrollView(
//      slivers: [
//        SliverAppBar(
//          backgroundColor: Colors.pink[500],
//          pinned: true,
//          floating: false,
//          expandedHeight: 300,
//          title: Text('Lovelive', style: TextStyle(color: Colors.white)),
//          flexibleSpace: FlexibleSpaceBar(
//            background: Container(
//              color: Colors.white,
//              child: Center(
//                child: Text('u\'s', style: TextStyle(color: Colors.blueGrey[800], fontSize: 40, fontWeight: FontWeight.w500))
//              )
//            ),
//          ),
//        ),
//        SliverFixedExtentList(
//          itemExtent: 50,
//          delegate: SliverChildBuilderDelegate(
//              (BuildContext context, int index) {
//                return Container(
//                  alignment: Alignment.center,
//                  color: Colors.white,
//                  child: Text('Item $index', style: TextStyle(fontSize: 12, fontFamily: 'Roboto'))
//                );
//              }
//          )
//        )
//      ]
//    );
  }
}