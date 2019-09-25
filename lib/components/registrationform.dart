import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _registrationFormKey = GlobalKey<FormState>();
  TextEditingController _registrationFormController = TextEditingController();

  TextStyle _header = TextStyle(color: Colors.grey[700], fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.w500);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        Form(
          key: _registrationFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Register', style: _header,)
            ],
          )
        )
      ],
    );
  }
}