import 'package:brewfirebaseapp/models/brew.dart';
import 'package:brewfirebaseapp/screens/home/brew_list.dart';
import 'package:brewfirebaseapp/screens/home/settings_form.dart';
import 'package:brewfirebaseapp/services/auth.dart';
import 'package:brewfirebaseapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brewfirebaseapp/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingspanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Settings(),
            );
          });
    }

    // TODO: implement build
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Container(
        child: Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              title: Text("Brew Crew"),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Logout")),
                FlatButton.icon(
                  icon: Icon(Icons.settings),
                  label: Text("settings"),
                  onPressed: () {
                    _showSettingspanel();
                  },
                )
              ], //actions appear in appbar as to add some clickability
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/coffee-beans-closeup-photography-867466.jpg'),
                      fit: BoxFit.cover ,
                    )),

                child: BrewList())),
      ),
    );
  }
}

//we will set up a stram for the user document changes
