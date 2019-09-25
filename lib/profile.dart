import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Sliver Grids
// Demo for Slivers
class ProfilePage extends StatelessWidget {
  final member;
  ProfilePage(this.member);

  final _topHeader = TextStyle(color: Colors.grey[700], fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.w700);
  final _secondaryHeader = TextStyle(color: Colors.grey[700], fontFamily: 'Roboto', fontSize: 18, fontWeight: FontWeight.w700);
  final _subHeader = TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey[500]);


  @override
  Widget build(BuildContext context) {
    var imageData;
    if (member['data']['cardPhoto'] == 'https://raw.githubusercontent.com/Mespeon/Sibyl-S2-Backend/master/psychopass/resources/') {
      imageData = 'https://firebasestorage.googleapis.com/v0/b/otonokizaka-3a6d9.appspot.com/o/default.jpg?alt=media&token=b8736d57-e915-41f4-8f68-9ace1496c45e';
    }
    else {
      imageData = member['data']['cardPhoto'];
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pink[500],
            pinned: true,
            floating: false,
            expandedHeight: 200,
            elevation: 2.0,
            automaticallyImplyLeading: true,
            flexibleSpace: FlexibleSpaceBar(
              background: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  child: ShaderMask(
                    child: Image.network(imageData, fit: BoxFit.cover),
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Hero(
                        tag: member['group'] + member['index'],
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pink,
                              image: DecorationImage(
                                image: NetworkImage(imageData),
                                fit: BoxFit.cover,
                                alignment: Alignment.center
                              )
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget> [
                              Text(member['data']['name'], style: _topHeader),
                              Text(member['data']['voice'], style: _subHeader)
                            ]
                          ),
                        )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Description', style: _secondaryHeader),
                      Divider(thickness: 1.0,),
                      Text(member['data']['description'])
                    ],
                  ),
                )
              ]
            ),
          ),
          SliverFillRemaining(
            child: Container()
          )
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