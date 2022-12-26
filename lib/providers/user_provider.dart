import 'package:hooks_riverpod/hooks_riverpod.dart';

const User1 = 1;
const User2 = 2;
final userProvider = StateProvider<int>((ref) {
  return User1;
});
