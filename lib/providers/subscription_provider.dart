import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/butler_api.dart';

final subscriptionStreamProvider = StreamProvider.autoDispose((ref) {
  return ButlerApi.subscriptions();
});
