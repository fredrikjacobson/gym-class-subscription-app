import 'package:flutter/material.dart';
import 'package:gym_butler/screens/workouts.dart';
import 'package:sprintf/sprintf.dart';

class WorkoutType {
  final String name;
  final int id;
  final String? description;

  WorkoutType(
      {required this.name, required this.id, required this.description});

  factory WorkoutType.fromJson(dynamic json) {
    return WorkoutType(
      id: json['id'],
      description: json['description'],
      name: json['name'],
    );
  }
}

class Staff {
  final String firstName;
  final String lastName;

  Staff({required this.firstName, required this.lastName});

  String toString() => "$firstName $lastName";

  factory Staff.fromJson(dynamic json) {
    return Staff(
      firstName: json['firstname'],
      lastName: json['lastname'],
    );
  }
}

const weekDay = {
  Weekday.Monday: "Måndag",
  Weekday.Tuesday: "Tisdag",
  Weekday.Wednesday: "Onsdag",
  Weekday.Thursday: "Torsdag",
  Weekday.Friday: "Fredag",
  Weekday.Saturday: "Lördag",
  Weekday.Sunday: "Söndag"
};

enum Weekday {
  NoDay,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

class Workout {
  final int id;
  final int numQueue;
  final Weekday weekday;
  final DateTime startTime;
  final DateTime endTime;
  final String? extraTitle;
  final WorkoutType workoutType;
  final List<Staff> staffs;
  final int siteId;

  String toString() {
    final name = "${workoutType.name} - $extraTitle";
    if (name.endsWith("- ")) {
      return name.replaceAll("- ", " - ");
    } else {
      return name;
    }
  }

  String dateTime() => [
        weekday.toString().split(".").last,
        sprintf("%01i:%02i", [startTime.hour, startTime.minute])
      ].join(" - ");

  factory Workout.fromJson(dynamic json) {
    return Workout(
        id: json['id'],
        numQueue: json['numQueue'],
        startTime: DateTime.parse(json['startTime']),
        weekday: Weekday.values[DateTime.parse(json['startTime']).weekday],
        endTime: DateTime.parse(json['endTime']),
        extraTitle: json['extra_title'],
        workoutType: WorkoutType.fromJson(json['workoutType']),
        staffs: json['staffs'] != null
            ? (json['staffs'] as List<dynamic>)
                .map((s) => Staff.fromJson(s))
                .toList()
            : [],
        siteId: json['site_id']);
  }

  Workout({
    required this.numQueue,
    required this.startTime,
    required this.endTime,
    required this.extraTitle,
    required this.workoutType,
    required this.staffs,
    required this.id,
    required this.weekday,
    required this.siteId,
  });
}
