import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerButtonProvider = StateProvider<bool>((ref) {
  return false;
});

final isUserSignedInStateProvider = StateProvider<bool>((ref) {
  return false;
});

