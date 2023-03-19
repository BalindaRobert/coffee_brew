import 'package:flutter/material.dart';
import 'package:lewandowski/models/brews.dart';
import 'package:lewandowski/screens/home/settings.dart';
import 'package:lewandowski/shared/database.dart';
import 'package:provider/provider.dart';
import 'brewlist.dart';

import '../../services/auth.dart';

class Home extends StatelessWidget {

final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void settingspanel() {
      showModalBottomSheet (context: context, builder: (context){
        return Container(
          padding: EdgeInsets.all(40),
          child:Settings(),
        );
      });
    }

    return StreamProvider<Brews>.value(
      value: DatabaseService().brews,
      initialData: DatabaseService(uid: ''),
      child: Scaffold(
        backgroundColor: Colors.brown[40],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: [FlatButton.icon(onPressed: ()async{
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('Logout')),
          FlatButton.icon(onPressed: ()=> settingspanel(), icon: Icon(Icons.settings), label: Text('settings'))],
        ),
        body: BrewList(),
      ),
    );
  }
}
