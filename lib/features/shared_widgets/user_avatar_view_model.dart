import 'package:dermo/logic/data_objects/entities/user/user_avatar.dart';
import 'package:flutter/material.dart';

class UserAvatarViewModel {
  final UserAvatar avatar;
  static const String _defaultAvatar = "assets/images/guest.png";

  const UserAvatarViewModel({required this.avatar});

  ImageProvider avatarImageProvider() {
    switch (avatar.type) {
      case AvatarType.url:
        return NetworkImage(avatar.image!);
      case AvatarType.localImage:
        return AssetImage(avatar.image!);
      default:
        return const AssetImage(_defaultAvatar);
    }
  }
}
