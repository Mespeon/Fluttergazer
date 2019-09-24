import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttergazer/components/drawer.dart';
import 'dart:convert';

import 'package:fluttergazer/model/auth_model.dart';
import 'package:fluttergazer/services/lovelive_services.dart';

class Boilnierplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TheDrawer(),
      appBar: AppBar(
        title: Text('Boilnierplate'),
        backgroundColor: Colors.blue[700],
        automaticallyImplyLeading: true,
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
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loginController.addListener(_printLatestValue);
    _passwordController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print('Email: ' + _loginController.text);
    print('Password: ' + _passwordController.text);
  }

  Future<void> createAlertDialog(title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () { Navigator.of(context).pop(); },
            )
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(20),
        elevation: 1.0,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusColor: Colors.blue,
                    labelText: 'Email',
                    icon: Icon(Icons.email, color: Colors.grey[400])
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'An email is required.';
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusColor: Colors.blue,
                    labelText: 'Password',
                    icon: Icon(Icons.vpn_key, color: Colors.grey[400])
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password.';
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
                    onPressed: () { 
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Pushing registration form.'),)); 
                    },
                    textColor: Colors.deepPurple[500]
                  ),
                  RaisedButton(
                    color: Colors.pink[700],
                    textColor: Colors.white,
                    child: Text('Login'),
                    onPressed: () async { 
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Logging in.')));

                        // LOGIN PROCESS
                        // Encode the credentials and pass it to the Login class/model
                        Login credentials = new Login(email: _loginController.text, password: _passwordController.text);

                        // Call the login function then print the response
                        await login('login', credentials).then((response) {
                          Scaffold.of(context).removeCurrentSnackBar();

                          var data = json.decode(response.body);
                          if (data['msg'] != null) {
                            createAlertDialog('Oops!', data['msg']);
                          }
                          else if (data['token'] != null) {
                            createAlertDialog('Success', data['token']);
                          }
                        }).catchError((ex) {
                          print(ex);
                        });
                      }
                    },
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