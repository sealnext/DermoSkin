import 'package:dermo/logic/data_objects/entities/user/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserAvatarViewModel {
  final UserAvatar avatar;
  static const String _defaultAvatar = "assets/images/your_local_image.svg";

  UserAvatarViewModel(this.avatar);

  Widget display() {
    switch (avatar.type) {
      case AvatarType.url:
        return Image.network(avatar.image!);
      case AvatarType.localImage:
        return SvgPicture.asset(avatar.image!);
      default:
        return SvgPicture.asset(_defaultAvatar);
    }
  }
}
