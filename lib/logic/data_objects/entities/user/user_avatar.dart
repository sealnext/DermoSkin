import 'package:flutter/material.dart';

enum AvatarType { url, localImage, none }

@immutable
class UserAvatar {
  final String? image;
  final AvatarType type;

  UserAvatar([String imagePathOrUrl = ""])
      : image = imagePathOrUrl,
        type = getAvatarType(imagePathOrUrl);

  static AvatarType getAvatarType(String pathOrUrl) {
    if (pathOrUrl.isEmpty) {
      return AvatarType.none;
    }

    return Uri.tryParse(pathOrUrl)?.hasScheme ?? false
        ? AvatarType.url
        : AvatarType.localImage;
  }
}
