import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_butler/models/subscription.dart';
import 'package:gym_butler/models/user.dart';
import 'package:gym_butler/models/workout.dart';
import 'package:sprintf/sprintf.dart';

class ButlerApi {
  static Future<List<User>> getUsers() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final resp = await users.get();
    return resp.docs.map((e) => User.fromJson(e)).toList();
  }

  static Future<void> addSubscription(Subscription subscription) async {
    CollectionReference subscriptions =
        FirebaseFirestore.instance.collection('subscriptions');
    final resp = await subscriptions.add(subscription.toJson());
  }

  static Future<void> removeSubscription(Workout workout, int userId) async {
    CollectionReference subscriptions =
        FirebaseFirestore.instance.collection('subscriptions');

    final timeOfDay = TimeOfDay.fromDateTime(workout.startTime);
    final subs = await subscriptions
        .where("userId", isEqualTo: userId)
        .where("workoutTypeId", isEqualTo: workout.workoutType.id)
        .where("weekDay", isEqualTo: workout.weekday.index)
        .where("timeOfDay",
            isEqualTo: sprintf("%02i:%02i", [timeOfDay.hour, timeOfDay.minute]))
        .get();

    for (var sub in subs.docs) {
      await sub.reference.delete();
    }
  }

  static Stream<List<Subscription>> subscriptions() {
    CollectionReference subscriptions =
        FirebaseFirestore.instance.collection('subscriptions');

    return subscriptions.snapshots().map((event) =>
        event.docs.map((e) => Subscription.fromJson(e.data())).toList());
  }
}
