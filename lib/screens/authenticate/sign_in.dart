import 'package:brewfirebaseapp/services/auth.dart';
import 'package:brewfirebaseapp/shared/constants.dart';
import 'package:brewfirebaseapp/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleview;

  SignIn({this.toggleview});

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false ;

  // text field state
  String email = '';
  String error = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text("Sign In to Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.toggleview();
                },
                icon: Icon(Icons.person),
                label: Text('Register'))
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
                    decoration: textInputDecororation.copyWith(hintText :'Email'),
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
                    decoration: textInputDecororation.copyWith(hintText: 'Password'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter an Email';
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
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          loading= true ;
                        });
                        //print(email);
                        //print(password);
                        dynamic result =
                            await _auth.signInwithemailndPass(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Invalid Credentials';
                            loading=false ;
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

//inorder to use instanse of a class we need a instance of the class
