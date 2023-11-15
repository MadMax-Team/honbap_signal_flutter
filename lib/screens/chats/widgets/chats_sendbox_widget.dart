import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class ChatsSendboxWidget extends StatefulWidget {
  const ChatsSendboxWidget({super.key});

  @override
  State<ChatsSendboxWidget> createState() => _ChatsSendboxWidgetState();
}

class _ChatsSendboxWidgetState extends State<ChatsSendboxWidget> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.size48,
      margin: EdgeInsets.fromLTRB(
        Sizes.size10,
        0,
        Sizes.size10,
        MediaQuery.of(context).padding.bottom + Sizes.size10,
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
              child: TextFormField(
                controller: _textEditingController,
              ),
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
