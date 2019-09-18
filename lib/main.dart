import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
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

// The Cards
// This will be a stateful Widget as it is updated by the API.
//class CardRoll extends StatefulWidget {
//  @override
//  CardRollState createState() => CardRollState();
//}
//
//class CardRollState extends State<CardRoll> {
//  @override
//  void initState() {
//    super.initState();
//    post =
//  }
//}

//class Character {
//  String name;
//  String desc;
//  String cardPhoto;
//  String cv;
//
//  Character({this.name, this.desc, this.cardPhoto, this.cv});
//}
//
//Future<List<Character>> getCharacterData() async {
//  final response = await http.get('https://marknolledo.pythonanywhere.com/sibyl/ionic/stargazer');
////  print(response.body);
//
//  final responseJson = json.decode(response.body.toString());
//  print(responseJson);
//
//  List characters = json.decode(response.body.toString());
//  List<Character> characterList = createCharacterList(characters);
//  return characterList;
//}
//
//List<Character> createCharacterList(List data) {
//  List<Character> list = new List();
//
//  for (int i = 0; i < data.length; i++) {
//    String name = data[i]['name'];
//    print(data[i]);
//    Character char = new Character(name: name);
//    list.add(char);
//  }
//
//  return list;
//}

//class Quote {
//  final List<String> members;
//
//  Quote({this.members});
//
//  factory Quote.fromJson(Map<String, dynamic> json) {
//    final dataLength = json['data']['Muse'].length;
//    print(json['data']['Muse'].length);
//
//    return Quote(name: json['data']['Muse'][0]['name']);
//  }
//}

class Groups {
  List<String> muse;
  List<String> aqours;

  Groups({this.muse, this.aqours});

  factory Groups.fromJson(Map<String, dynamic> json) {
    return Groups(
        muse: json['data']['Muse'],
        aqours: json['data']['Aqours']
    );
  }
}

class Members {
  Groups name;
  String desc;
  String cv;
  Groups memberData;

  Members({
    this.name,
    this.desc,
    this.cv,
    this.memberData
  });

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      memberData: Groups.fromJson(json['data']['Muse'])
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
          onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => RandomGets())); },
        )
      )
    );
  }
}

class RandomGets extends StatelessWidget {
//  Future<Groups> getMembers() async {
//    String url = 'https://marknolledo.pythonanywhere.com/sibyl/ionic/stargazer';
//    final response = await http.get(url);
////    print(response.body);
//
//    if (response.statusCode == 200) {
//      return Groups.fromJson(json.decode(response.body));
//    }
//    else {
//      print(Exception);
//      throw Exception('Failed to load post.');
//    }
//  }

  callAPI() {

  }

  createCards(muse, aqours) {
    List members = new List();
    Container group = new Container();

    for (var m=0; m <= muse.length - 1; m++) {
      var member = muse[m].toJson();
      members.add(member);
    }

    for (var a=0; a <= aqours.length - 1; a++) {
      var member = aqours[a].toJson();
      members.add(member);
    }

    return Container(
      child:
        Text(members[0].toString())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body:Center(
          child: FutureBuilder<Stargazer>(
              future: getMembers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                        child: Column(
                          children: [
                        createCards(snapshot.data.data.muse, snapshot.data.data.aqours)
                          ]
                        )
                    ),
                  );
                }
                else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              }
          )
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