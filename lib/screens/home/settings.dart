import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lewandowski/models/bro.dart';
import 'package:lewandowski/shared/constants.dart';
import 'package:lewandowski/shared/database.dart';
import 'package:lewandowski/shared/loading.dart';
import 'package:provider/provider.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  late String _currentName;
  late String _currentSugars;
  late int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).UserData,
      builder: (context, snapshot)  {
        if(snapshot.hasData){

          UserData? userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Update your setting', style: TextStyle(fontSize: 18),),
                SizedBox(height: 40),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Enter name'),
                  validator: (val)=> val!.isEmpty ? 'Enter name' : null,
                  onChanged: (val)=> setState(() => _currentName = val),
                ),
                SizedBox(height: 40),
                // drop down
                DropdownButtonFormField(items: sugars.map((sugar) {
                  value: _currentSugars ?? userData?.sugars;
                  Decoration: textInputDecoration;

                  return DropdownMenuItem(value: sugar,
                    child: Text('$sugar sugars'),
                  );
                }).toList(), onChanged: (val)=> setState (()=> _currentSugars = val as String)),
                //slider
                Slider(value: (_currentStrength ?? userData?.strength)as double,
                    activeColor: Colors.brown[_currentStrength ?? 100] ,
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) => setState(()=> _currentStrength= val.round())),

                RaisedButton(color: Colors.pink[400],
                  onPressed: () async {
                  if(_formKey.currentState != null){
                    _formKey.currentState?.validate();
                    await DatabaseService(uid: user.uid).updateDatabase(

                        _currentSugars ?? userData.sugar,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength);
                  }
                  Navigator.pop(context);
                  },
                  child: Text('Upadate',style: TextStyle(fontSize: 10, color: Colors.white),),
                ),
              ],
            ),

          );
        }else{
          return Loading();
        }
throw "";


      }
    );
  }
}
