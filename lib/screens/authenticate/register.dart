import 'package:brewfirebaseapp/shared/constants.dart';
import 'package:brewfirebaseapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewfirebaseapp/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleview;

  Register({this.toggleview});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _regState();
  }
}

// ignore: camel_case_types
class _regState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  // text field state
  String email = '';
  String error = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text("Sign Up to Brew Crew"),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleview();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign In'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecororation.copyWith(hintText: 'Email'),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter an Email';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: textInputDecororation.copyWith(
                            hintText: 'Password'),
                        validator: (val) {
                          if (val.length < 6) {
                            return 'Password must be more than 6 characters';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true, //password
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            //print(email);
                            //print(password);
                            dynamic result = await _auth
                                .registerInwithemailndPass(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please Supply a valid email';
                              });
                              print(error);
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                        ),
                      )
                    ],
                  ),
                )));
  }
}
