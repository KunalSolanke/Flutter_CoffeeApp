import 'package:brewfirebaseapp/models/brew.dart';
import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart' ;

import 'brew_tile.dart';


class BrewList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _brewlistState();
  }

}

class _brewlistState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews =Provider.of<List<Brew>>(context) ?? [];

//    brews.forEach((brew){
//      print(brew.name) ;
//      print(brew.sugars) ;
//      print(brew.strength) ;
//    }) ;

    return ListView.builder(
    itemCount: brews.length,
    itemBuilder: (context,index){
      return BrewTile(brew:brews[index]) ;

    }) ;
  }

}