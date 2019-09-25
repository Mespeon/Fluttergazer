import 'package:flutter/material.dart';

class HeroFlyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white10,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.pink[500]),
      ),
      body: Container(
        child: Hero(
          tag: 'samplehero',
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              color: Colors.pink[500]
            ),
          )
        )
      )
    );
  }
}