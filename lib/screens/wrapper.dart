import 'package:brewfirebaseapp/models/user.dart';
import 'package:brewfirebaseapp/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either home or authenticate
    return user == null ? Authenticate() : Home();
  }
}

//auth changes stream _ we are goin to use a Provider Package it is a Google recommended sol
//for auth change operathions
//this can be done using wrapping our myapp widget in a Provider
//and supply the stream to this provider and then we can user that status in our widget HttpRequestEventTarget
