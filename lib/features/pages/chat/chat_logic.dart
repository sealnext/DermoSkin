import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

part 'chat_logic.g.dart';

@riverpod
Stream<List<Room>> rooms(RoomsRef ref) {
  return FirebaseChatCore.instance.rooms();
}