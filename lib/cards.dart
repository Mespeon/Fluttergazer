import 'package:flutter/material.dart';
import 'package:lovelive/model/sif_model.dart';
import 'package:lovelive/services/lovelive_services.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:lovelive/profile.dart';

import 'constants.dart';


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
  final _groupHeader = TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.grey[700]);

  createHeader(data) {
    return Container(
      child: Text('$data', style: _groupHeader),
      padding: EdgeInsets.only(left: 12, top: 12, bottom: 8),
      alignment: Alignment.centerLeft,
    );
  }

  createCards(data) {
    var imageData;
    if (data['cardPhoto'] == 'https://raw.githubusercontent.com/Mespeon/Sibyl-S2-Backend/master/psychopass/resources/') {
      imageData = 'https://firebasestorage.googleapis.com/v0/b/otonokizaka-3a6d9.appspot.com/o/default.jpg?alt=media&token=b8736d57-e915-41f4-8f68-9ace1496c45e';
    }
    else {
      imageData = data['cardPhoto'];
    }

    return Card(
      margin: EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
      elevation: 2.0,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, memberProfile, arguments: data);
        },
        splashColor: Colors.pink[500].withAlpha(70),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 80,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                placeholderScale: 1 / 1,
                image: '$imageData',
                fit: BoxFit.cover
              )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left:8, bottom: 4),
                      child: Text('${data['name']}', style: _cardTitle, textAlign: TextAlign.left)
                    )
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 8, bottom: 4),
                      child: Text('${data['voice']}', style: _cardSubtitle, textAlign: TextAlign.left,)
                    )
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // Returns a ListView that will hold a List of Columns containing Text
    // with values from the API.
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future: getMembers(),
          builder: (context, snapshot) {
            List<Widget> dataMembers = List<Widget>();
            if (snapshot.hasData) {
              var muses = snapshot.data.data.muse;
              var aqours = snapshot.data.data.aqours;
              var museMap = muses.asMap();
              var aqoursMap = aqours.asMap();

              // Add Muses
              museMap.forEach((i, element) {
                var data = element.toJson();
                if (i == 0) {
                  dataMembers.add(createHeader('Muse'));
                }

                dataMembers.add(createCards(data));
              });

              // Add Aqours
              aqoursMap.forEach((i, element) {
                var data = element.toJson();
                if (i == 0) {
                  dataMembers.add(createHeader('Aqours'));
                }

                dataMembers.add(createCards(data));
              });

              if (dataMembers.length == 0) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text('No data.')
                  )
                );
              }
              else {
                return Column(children: dataMembers);
              }
            }
            else if (snapshot.hasError) {
              return Text('No data.');
            }
            return LinearProgressIndicator();
          }
        )
      ],
    );
  }
}

// The CardListings page; this returns a basic Scaffold widget
// containing the stateful CardList ListView widget.
class CardListings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () { print('More on AppBar pressed'); },
          )
        ],
      ),
      body: Center(
        child: CardList()
      ),
    );
  }
}

// The Popup Menu widget
enum SifOptions {muse, aqours, nijigasaki}
// class CardsPopupMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<SifOptions>(
//       elevation: 1.0,
//       tooltip: 'View another group',
//       onCanceled: () { print('Nothing selected.'); },
//       onSelected: (SifOptions result) { print(result); },
//       itemBuilder: (BuildContext context) {
//         return 
//       }
//     );
//   }
// }