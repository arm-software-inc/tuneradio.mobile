import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({ Key? key }) : super(key: key);

  @override
  RadioPageState createState() => RadioPageState();
}

class RadioPageState extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content(),
    );
  }

  Widget _content() {
    return Container();
  }
}