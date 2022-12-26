import 'dart:convert';

import 'package:gym_butler/models/workout.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class GymApi {
  final String baseUrl;

  GymApi({required this.baseUrl});

  Future<List<Workout>> getWorkouts() async {
    final today = DateTime.now();

    final uri = Uri.parse(
        '$baseUrl/workout/get/all?fromDate=${today.toString().substring(0, 10)}&toDate=${today.add(const Duration(days: 8)).toString().substring(0, 10)}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      List<dynamic> workoutsJson = json['workouts'];
      final workouts = workoutsJson.map((w) => Workout.fromJson(w)).toList();

      return workouts.where((element) => element.siteId == 1).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }
}

final gymApiProvider = Provider((ref) {
  return GymApi(baseUrl: "");
});
