import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class RoomTile extends StatelessWidget {
  final types.Room room;

  const RoomTile({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(room.users.first.firstName ?? 'Guest'),
      onTap: () {
        // Handle room tap, navigate, open chat, etc.
      },
    );
  }
}