import 'package:brewfirebaseapp/models/brew.dart';
import 'package:flutter/material.dart' ;


class BrewTile extends StatelessWidget {
  final Brew brew ;
  BrewTile({this.brew}) ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top:10.0),
      child:Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/disposable-cup-on-brown-wooden-table-3646103.jpg'),
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],

          ),
          title:Text(brew.name),
          subtitle: Text('takes ${brew.sugars} sugars'),
        ),
      )
    );
  }

}