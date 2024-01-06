import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({required this.hintWord, this.setter, Key? key})
      : super(key: key);

  final String hintWord;
  final Function(String)? setter;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (text) {
        widget.setter?.call(text);
      },
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: Sizes.size11,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: widget.hintWord,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Sizes.size11,
          color: Color(0xff737373),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            width: Sizes.size1,
            color: Colors.black,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            width: Sizes.size1,
            color: Color(0xffE1E1E1),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            width: Sizes.size1,
            color: Color(0xffE1E1E1),
          ),
        ),
      ),
    );
  }
}
