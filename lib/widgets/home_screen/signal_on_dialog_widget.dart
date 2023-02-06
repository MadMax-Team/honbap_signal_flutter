import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignalOnDialog extends StatefulWidget {
  const SignalOnDialog({Key? key}) : super(key: key);

  @override
  State<SignalOnDialog> createState() => _SignalOnDialogState();
}

class _SignalOnDialogState extends State<SignalOnDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffF2F2F2),
      elevation: 0,
      content: Container(
          child: Text('test'),
      ),
    );
  }
}
