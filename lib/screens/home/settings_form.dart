import 'package:brewfirebaseapp/models/user.dart';
import 'package:brewfirebaseapp/services/database.dart';
import 'package:brewfirebaseapp/shared/constants.dart';
import 'package:brewfirebaseapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _settingsState();
  }
}

class _settingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _sugars = ['0', '1', '2', '3', '4'];

  String _currentName;

  String _currentSugars;

  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Userdata>(
        stream: DatabaseService(uid: user.uid).userdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Userdata userdata = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Text("Update Your Brew settings",
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userdata.name,
                    decoration:
                        textInputDecororation.copyWith(hintText: 'Name'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter a Name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecororation,
                    items: _sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars "),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentSugars = val;
                      });
                    },
                    value: _currentSugars ?? userdata.sugars,
                  ),
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        _currentstrength = val.round();
                      });
                    },
                    value: (_currentstrength ?? userdata.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentstrength ?? userdata.strength],
                    inactiveColor:
                        Colors.brown[_currentstrength ?? userdata.strength],
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userdata.sugars,
                            _currentName ?? userdata.name,
                            _currentstrength ??
                                userdata.strength); // ?? null aware operator
//                        print(_currentName);
//                        print(_currentstrength);
//                        print(_currentSugars);
                        Navigator.pop(context);
                      }
                    },
                  )
                ]));
          } else {
            return Loading();
          }
        });
  }
}