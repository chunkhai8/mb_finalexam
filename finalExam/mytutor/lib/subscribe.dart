import 'package:flutter/material.dart';


class Subscribe extends StatefulWidget {
  const Subscribe({Key? key}) : super(key: key);

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Subscribe'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
    );
  }
}