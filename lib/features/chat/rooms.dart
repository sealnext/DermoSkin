import 'package:auto_route/annotations.dart';
import 'package:dermo/features/chat/chat.dart';
import 'package:dermo/features/chat/chat2.dart';
import 'package:dermo/features/chat/chat3.dart';
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
  static const List<ChatRoom> chatRooms = [
    ChatRoom(
        name: 'Group of 3',
        lastMessage: 'John Doe: Nice ☺️',
        avatarUrl: 'https://i.pravatar.cc/100?img=1'),
    ChatRoom(
        name: 'Ion Popa',
        lastMessage: 'Ai vazut ce s-a intamplat?',
        avatarUrl: 'https://i.pravatar.cc/100?img=7'),
    ChatRoom(
        name: 'Matei Dumitru',
        lastMessage: 'Buna ziua!',
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
              if (index == 0) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ChatPage(),
                ));
              } else if (index == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ChatPage2(),
                ));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ChatPage3(),
                ));
              }
            },
          );
        },
      ),
    );
  }
}
