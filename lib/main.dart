

import 'package:flutter/material.dart';
import 'package:lewandowski/models/bro.dart';
import 'package:lewandowski/services/auth.dart';
import 'package:lewandowski/wrapper.dart';
import 'package:lewandowski/models/bro.dart';
import 'package:lewandowski/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Bro?>.value(
        value: AuthService().user,
      initialData: Bro(uid: ''),
      child: MaterialApp(
 home: Wrapper(),
      ),
    );

  }
}

