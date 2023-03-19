import 'package:flutter/material.dart';
import 'package:lewandowski/models/bro.dart';
import 'package:lewandowski/screens/authenticate/authenticate.dart';
import 'package:lewandowski/screens/authenticate/sign_in.dart';
import 'package:lewandowski/screens/home/home.dart';
import 'package:provider/provider.dart';
 class Wrapper extends StatefulWidget {
   const Wrapper({Key? key}) : super(key: key);

   @override
   State<Wrapper> createState() => _WrapperState();
 }

 class _WrapperState extends State<Wrapper> {
   @override
   Widget build(BuildContext context) {
     final user = Provider.of<Bro>(context);
     print(user);
     if(user==null){
       return Authenticate();
     }else{
       return Home();
     }
   }
 }
