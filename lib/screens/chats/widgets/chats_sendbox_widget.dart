import 'package:flutter/material.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class ChatsSendboxWidget extends StatefulWidget {
  const ChatsSendboxWidget({super.key});

  @override
  State<ChatsSendboxWidget> createState() => _ChatsSendboxWidgetState();
}

class _ChatsSendboxWidgetState extends State<ChatsSendboxWidget> {
  late final TextEditingController _textEditingController;
  late final FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    print('send: ${_textEditingController.value.text}');
    _textEditingController.clear();
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
      child: TextFormField(
        controller: _textEditingController,
        focusNode: _textFocusNode,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onFieldSubmitted: (value) {
          _sendMessage();
          _textFocusNode.requestFocus();
        },
        textInputAction: TextInputAction.send,
        style: const TextStyle(
          fontSize: Sizes.size14,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: Sizes.size20),
          suffixIcon: IconButton(
            onPressed: _sendMessage,
            splashRadius: 0.001,
            icon: Icon(
              Icons.arrow_circle_right,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
