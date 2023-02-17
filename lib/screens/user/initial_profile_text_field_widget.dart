import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({
    required this.hintWord,
    Key? key
  }) : super(key: key);

  final String hintWord;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintWord,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 9, 10, 10),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          color: Color(0xff737373),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(width: 1, color: Color(0xffE1E1E1)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(width: 1, color: Color(0xffE1E1E1)),
        ),
      ),
    );
  }
}
