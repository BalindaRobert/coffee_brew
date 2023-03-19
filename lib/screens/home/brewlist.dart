import 'package:flutter/material.dart';
import 'package:lewandowski/models/brews.dart';
import 'package:provider/provider.dart';
import 'brew_tile.dart';
class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<Brews>(context);

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (BuildContext context, int index) {
      return BrewTile(brews: brews[index]);
    },)
    ;
  }
}
