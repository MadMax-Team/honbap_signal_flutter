import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honbap_signal_flutter/models/chats/chat_room_model.dart';
import 'package:honbap_signal_flutter/widgets/chats_screen/chats_chatbox_widget.dart';

class ChatRoomScreen extends StatefulWidget {
  final String nickname, profileImage;

  const ChatRoomScreen({
    super.key,
    required this.nickname,
    required this.profileImage,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  // TEST CODE
  Future<List<ChatRoomModel>> _getChat() async {
    List<ChatRoomModel> chatList = [];
    final String response =
        await rootBundle.loadString('assets/test/${widget.nickname}.json');
    final data = await json.decode(response);

    for (var chat in data['chats']) {
      chatList.add(ChatRoomModel.fromJson(chat));
    }

    return chatList;
  }
  //====================-

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.nickname,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder(
              future: _getChat(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var chat = snapshot.data!;
                  return CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      ),
                      for (var index = 0; index < chat.length; index++)
                        ChatBox(
                          chat: chat,
                          index: index,
                          profileImage: widget.profileImage,
                          isSended: chat[index].nickname != widget.nickname,
                        ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 10),
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
          const SizedBox(
            height: 50,
            child: Text('채팅입력창'),
          ),
        ],
      ),
    );
  }
}
