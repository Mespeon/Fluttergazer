import 'package:flutter/material.dart';
import 'package:lovelive/model/sif_model.dart';
import 'package:lovelive/services/lovelive_services.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

// The parent widget for the whole app.
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

// The root page for the app.
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

// Stateful Widget for the actual Card List;
// this will serve as a child of the stateless widget
// CardListings, which will serve as a container for the state.
class CardList extends StatefulWidget {
  @override
  CardListState createState() => CardListState();
}

// CardListState - CardList's state
class CardListState extends State<CardList> {
  // The widget that will be returned by the state
  // after it initializes and finishes its async data request.

  final _cardTitle = TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 18, color: Colors.grey[700]);
  final _cardSubtitle = TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey[400]);
  final _cardButton = TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 12, color: Colors.pink[500]);

  @override
  Widget build(BuildContext context) {
    // Returns a ListView that will hold a List of Columns containing Text
    // with values from the API.
     return Center(
       child: ListView(
       children: [
         Center(
            child: FutureBuilder(
              future: getMembers(),
              builder: (context, snapshot) {
                List<Widget> dataMembers = List<Widget>();
                if (snapshot.hasData) {
                  for (var i = 0; i <= snapshot.data.data.muse.length - 1; i++) {
                    var mem = snapshot.data.data.muse[i].toJson();
//                   print('$mem');
                    dataMembers.add(
                      Card(
                        margin: EdgeInsets.all(10),
                        elevation: 5.0,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          splashColor: Colors.pink[500].withAlpha(50),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  placeholderScale: 1 / 1,
                                  image: '${mem['cardPhoto']}',
                                )
                              ),
                              Container(
                                child: ListTile(
                                  title: Text('${mem['name']}', style: _cardTitle),
                                  subtitle: Text('${mem['voice']}', style: _cardSubtitle),
                                  trailing: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(member: mem)));
                                    },
                                    child: Text('View Profile', style: _cardButton)
                                  ),
                                )
                              ),
                            ],
                          )
                        )
                      )
                    );
                  }

                  return Column(
                    children: dataMembers
                  );
                }
                else if (snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                return Container (
                  child: Center(
                    child: LinearProgressIndicator()
                  )
                );
              }
            )
          )
        ]
      )
    );
  }
}

// The CardListings page; this returns a basic Scaffold widget
// containing the stateful CardList ListView widget.
class CardListings extends StatelessWidget {
//  deserializeData(muse, aqours) {
//    List members = new List();
//
//    for (var m=0; m <= muse.length - 1; m++) {
//      var member = muse[m].toJson();
//      members.add(member);
//    }
//
//    for (var a=0; a <= aqours.length - 1; a++) {
//      var member = aqours[a].toJson();
//      members.add(member);
//    }
//
//    print('From deserializeData: $members');
//
//    return members;
//  }
//
//  Widget setTextWidgets(List<String> data) {
//    return new Row(children:
//      data.map((member) => new Text(member)).toList()
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members')
      ),
      body: Center(
        child: CardList()
      ),
    );
  }
}

// Sliver Grids
// Demo for Slivers
class ProfilePage extends StatelessWidget {
  final member;
  ProfilePage({this.member});

  @override
  Widget build(BuildContext context) {
    print(member);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pink[500],
            pinned: true,
            floating: true,
            expandedHeight: 300,
            elevation: 5.0,
            automaticallyImplyLeading: true,
            title: Text(member['name']),
            flexibleSpace: FlexibleSpaceBar(
              background: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  child: ShaderMask(
                    child: Image.network(member['cardPhoto'], fit: BoxFit.cover),
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.grey[700].withAlpha(80), Colors.grey[900].withAlpha(90)],
                        stops: [0.0, 0.5],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                  )
                ),
              ),
            ),
          ),
          SliverFillRemaining(child: Container(),)
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