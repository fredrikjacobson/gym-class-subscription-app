import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/gym_api.dart';
import '../models/workout.dart';

final workoutsProvider = FutureProvider.autoDispose<List<Workout>>((ref) async {
  final gymApi = ref.watch(gymApiProvider);
  return await gymApi.getWorkouts();
});
