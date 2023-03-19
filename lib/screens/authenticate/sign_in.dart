import 'package:flutter/material.dart';
import 'package:lewandowski/screens/authenticate/register.dart';
import 'package:lewandowski/services/auth.dart';

import '../../shared/constants.dart';
import '../../shared/loading.dart';

    class SignIn extends StatefulWidget {
       late final Function toggleView;
       SignIn({required this.toggleView});
      @override
      State<SignIn> createState() => _SignInState();


    }

    class _SignInState extends State<SignIn> {
      final AuthService _auth = AuthService();
      final _formKey = GlobalKey<FormState>();
      String email='';
      String password = '';
      String error = '';
      bool loading = false;
      @override
      Widget build(BuildContext context) {
        return loading ? Loading() : Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            title: Text('Coffee Brew Sign in'),
            backgroundColor: Colors.grey[400],
            elevation: 0.0,
            actions: [
              FlatButton.icon(onPressed: (){
                widget.toggleView();
              }, icon: Icon(Icons.person), label: Text('Register'))
            ]
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
                    validator: (val) => val!.length <6 ? 'Enter password 6 char long' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() => password= val);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState != null){
                      _formKey.currentState?.validate();
                     setState(() => loading = true);
                      dynamic result = _auth.signInWithEmailandPassword(email, password);
                      if(result== null){
                        setState(() {
                          error = 'Could not sig in wi those credentials';
                          loading = false;
                        });
                      }
                    }
                  }, child: Text('Sign in', style: TextStyle(color: Colors.white))),
                SizedBox(height: 40),
                  Text(error, style: TextStyle(color: Colors.red[400], fontSize: 12),)
                  
                ],
              ),
              
            ),
          ),
        );
      }
    }
