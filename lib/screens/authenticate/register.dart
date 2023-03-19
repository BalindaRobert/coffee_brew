import 'package:flutter/material.dart';
import 'package:lewandowski/screens/authenticate/sign_in.dart';
import 'package:lewandowski/services/auth.dart';
import 'package:lewandowski/shared/loading.dart';

import '../../shared/constants.dart';
class Register extends StatefulWidget {

  late final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email ='';
  String password ='';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Coffee Brew Register'),
        backgroundColor: Colors.grey[400],
        elevation: 0.0,
        actions: [
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          }, icon: Icon(Icons.person), label: Text('SignIn'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
            key: _formKey,
          child: Column(
            children: [
              SizedBox(height:20),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter Email' : null,
                onChanged: (val){
                  setState(() => email=val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length <6 ? 'Enter password 6 char long' : null,
                onChanged: (val){
                  setState(() => password= val);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){
                if(_formKey.currentContext != null){
                  _formKey.currentState?.validate();
                  setState(()=> loading = true);
                  dynamic result = _auth.registerWithEmailandPassword(email, password);
                  if(result==null){
                    setState((){
                      error='please supply a valid email';
                     loading = false;
                    });
                  }
                }
              }, child: Text('Register', style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );;
  }
}
