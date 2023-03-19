import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.brown[100],
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.brown[100],
        ),
      ),
    );
  }
}
