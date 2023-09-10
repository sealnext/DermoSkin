import 'package:auto_route/annotations.dart';
import 'package:dermo/features/chat/chat.dart';
import 'package:flutter/material.dart';

class ChatRoom {
  final String name;
  final String lastMessage;
  final String avatarUrl;

  const ChatRoom(
      {required this.name, required this.lastMessage, required this.avatarUrl});
}

@RoutePage()
class RoomsPage extends StatelessWidget {
  static const _chatPage = ChatPage();
  static const List<ChatRoom> chatRooms = [
    ChatRoom(
        name: 'Group of 3',
        lastMessage: 'John Doe: Nice ☺️',
        avatarUrl: 'https://i.pravatar.cc/100?img=1'),
    ChatRoom(
        name: 'Ion Popa',
        lastMessage: 'Did you watch the game?',
        avatarUrl: 'https://i.pravatar.cc/100?img=7'),
    ChatRoom(
        name: 'Matei Dumitru',
        lastMessage: 'Flutter 2.5 is out!',
        avatarUrl: 'https://i.pravatar.cc/100?img=3'),
  ];

  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Rooms'),
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chatRooms[index].avatarUrl),
            ),
            title: Text(chatRooms[index].name),
            subtitle: Text(chatRooms[index].lastMessage),
            trailing: Text('1$index:3$index AM'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => _chatPage,
              ));
            },
          );
        },
      ),
    );
  }
}
