import 'package:flutter/material.dart';
import 'brewlist.dart';
import 'package:lewandowski/models/brews.dart';
class BrewTile extends StatelessWidget {

final Brews brews;
BrewTile({required this.brews});
  @override
  Widget build(BuildContext context) {
    return Padding(padding:  EdgeInsets.only(top: 8),
    child: Card(
      margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30, backgroundColor: Colors.brown[brews.strength],
        ),
        title: Text(brews.name),
        subtitle: Text('Takes ${brews.sugars} sugar(s)'),
      ),
    ),);
  }
}
