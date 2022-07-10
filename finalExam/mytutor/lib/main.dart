import 'dart:async';

import 'package:flutter/material.dart';

import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness:Brightness.light),
      home: const MySplashScreen(title: 'MY Tutor',),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                "MY Tutor",
                style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                  ),
                ),
                CircularProgressIndicator(),
                Text("Version 0.1",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, 
                )
                )
              ],
            )
          )
        ]
      ),
    );
    
  }
}

