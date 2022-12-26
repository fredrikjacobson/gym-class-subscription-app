import 'package:flutter/material.dart';
import 'package:gym_butler/models/workout.dart';
import 'package:sprintf/sprintf.dart';

class Subscription {
  final int userId;
  final int workoutTypeId;
  final TimeOfDay timeOfDay;
  final Weekday weekDay;

  Subscription({
    required this.workoutTypeId,
    required this.userId,
    required this.weekDay,
    required this.timeOfDay,
  });

  factory Subscription.fromJson(dynamic json) {
    final timeOfDay = json['timeOfDay'].split(":");
    return Subscription(
        userId: json['userId'],
        weekDay: Weekday.values[json['weekDay']],
        timeOfDay: TimeOfDay(
            hour: int.parse(timeOfDay[0]), minute: int.parse(timeOfDay[1])),
        workoutTypeId: json['workoutTypeId']);
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'weekDay': weekDay.index,
        'timeOfDay': sprintf("%02i:%02i", [timeOfDay.hour, timeOfDay.minute]),
        'workoutTypeId': workoutTypeId,
      };
}
