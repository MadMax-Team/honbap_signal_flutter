import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/models/chats/chat_room_model.dart';
import 'package:honbap_signal_flutter/screens/chats/widgets/chats_chatbox_widget.dart';

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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: FutureBuilder(
                future: _getChat(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var chat = snapshot.data!;
                    return ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.purple
                          ],
                          stops: [
                            0.0,
                            0.01,
                            0.99,
                            1.0
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: Gaps.v10,
                          ),
                          for (var index = 0; index < chat.length; index++)
                            ChatBox(
                              chat: chat,
                              index: index,
                              profileImage: widget.profileImage,
                              isSended: chat[index].nickname != widget.nickname,
                            ),
                          const SliverToBoxAdapter(
                            child: Gaps.v10,
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Container(
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
                    onPressed: () {
                      print('add btn clicked');
                    },
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
                      margin:
                          const EdgeInsets.symmetric(horizontal: Sizes.size10),
                      child: const Text('input'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print('send btn clicked');
                    },
                    icon: Icon(
                      Icons.arrow_circle_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
