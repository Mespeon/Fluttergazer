import 'package:flutter/material.dart';

class Boilnierplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boilnierplate'),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoginForm()
        ],
      )
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        elevation: 2.0,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  onChanged: (value) { print(value); },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    labelText: 'Email'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter something!!!';
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  onChanged: (value) { print(value); },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    labelText: 'Password'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter sumthin\'.';
                    }
                    return null;
                  },
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('Register'),
                    onPressed: () { print('Register'); },
                  ),
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: () { print('Logging in.'); },
                  )
                ],
              )
            ],
          )
        )
      )
    );
  }
}