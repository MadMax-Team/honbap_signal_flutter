import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class ChatsSendboxWidget extends StatelessWidget {
  const ChatsSendboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.size48,
      margin: const EdgeInsets.fromLTRB(
        Sizes.size10,
        0,
        Sizes.size10,
        Sizes.size24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size24),
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size5,
            spreadRadius: Sizes.size1,
            color: Colors.grey.shade400,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            width: Sizes.size1,
            height: Sizes.size28,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: Sizes.size10),
              child: const Text('input'),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_circle_right,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
