import 'package:brewfirebaseapp/screens/authenticate/register.dart';
import 'package:brewfirebaseapp/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart' ;


class Authenticate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _authState();
  }

}

class _authState extends State<Authenticate> {

  bool showSignIN =true ;
  void toggleview() {
    setState(() {
      showSignIN = !showSignIN ;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: showSignIN ? SignIn(toggleview:toggleview) : Register(toggleview:toggleview),
    );
  }

}