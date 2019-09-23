import 'package:flutter/material.dart';

// Sliver Grids
// Demo for Slivers
class ProfilePage extends StatelessWidget {
  final member;
  ProfilePage(this.member);

  @override
  Widget build(BuildContext context) {
    var imageData;
    if (member['cardPhoto'] == 'https://raw.githubusercontent.com/Mespeon/Sibyl-S2-Backend/master/psychopass/resources/') {
      imageData = 'https://firebasestorage.googleapis.com/v0/b/otonokizaka-3a6d9.appspot.com/o/default.jpg?alt=media&token=b8736d57-e915-41f4-8f68-9ace1496c45e';
    }
    else {
      imageData = member['cardPhoto'];
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pink[500],
            pinned: true,
            floating: true,
            expandedHeight: 200,
            elevation: 5.0,
            automaticallyImplyLeading: true,
            title: Text(member['name']),
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
          SliverFillRemaining(child: Container(
            child: Hero(
              tag: 'thumbnailHero',
              child: Image.network(imageData)
            )
          ),)
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