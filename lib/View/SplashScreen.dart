import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipeapp/View/HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 3),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("Welcome to recipe app",style: TextStyle(fontSize: 20),),
              )
            ],
          ),
    );
  }
}
