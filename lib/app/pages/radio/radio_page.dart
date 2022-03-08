import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({ Key? key }) : super(key: key);

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
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