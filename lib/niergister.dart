import 'package:flutter/material.dart';

import 'package:fluttergazer/components/registrationform.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niergister'),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue[700],
      ),
      body: SafeArea(
        bottom: true,
        maintainBottomViewPadding: true,
        child: RegistrationForm()
      )
    );
  }
}