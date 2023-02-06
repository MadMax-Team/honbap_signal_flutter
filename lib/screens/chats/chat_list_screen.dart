import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honbap_signal_flutter/models/chats/chat_list_model.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_chatcard_widget.dart';
import 'package:honbap_signal_flutter/tools/push_new_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // TEST CODE
  Future<List<ChatListModel>> _getChatList() async {
    List<ChatListModel> chatList = [];
    final String response =
        await rootBundle.loadString('assets/test/chat_list.json');
    final data = await json.decode(response);

    for (var chat in data['chats']) {
      chatList.add(ChatListModel.fromJson(chat));
    }

    return chatList;
  }
  //====================-

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '쪽지함',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: FutureBuilder(
          future: _getChatList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  for (var chat in snapshot.data!)
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () => PushNewScreen.openChatRoom(
                          nickname: chat.nickname,
                          profileImage: chat.profileImage,
                          context: context,
                        ),
                        child: ChatCard(chat: chat),
                      ),
                    ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
