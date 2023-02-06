import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateCard extends StatefulWidget {
  const StateCard({
    Key? key,
    required this.name,
    required this.tag,
    required this.temperature,
    required this.location
  }) : super(key: key);

  final String name;
  final List<String> tag;
  final double temperature;
  final String location;

  @override
  State<StateCard> createState() => _StateCardState();
}

class _StateCardState extends State<StateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow( //그림자
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.1,
            offset: Offset(0,5),
          ),
        ],
        borderRadius: BorderRadius.circular(10), //모서리를 둥글게
      ),
      child: Row(
        children: [
          Text('data')
        ],
      ),
    );
  }
}
