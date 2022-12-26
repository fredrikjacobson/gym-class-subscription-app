import 'package:flutter/material.dart';

import '../api/butler_api.dart';
import '../models/subscription.dart';
import '../models/workout.dart';
import '../providers/user_provider.dart';

class GymClassCard extends StatelessWidget {
  const GymClassCard({
    Key? key,
    required this.subscriptions,
    required this.workout,
    required this.currentUserId,
  }) : super(key: key);

  final List<Subscription> subscriptions;
  final Workout workout;
  final int currentUserId;

  @override
  Widget build(BuildContext context) {
    final hasUser1 = isSubscribedToWorkout(subscriptions, workout, User1);
    final hasUser2 = isSubscribedToWorkout(subscriptions, workout, User2);

    final isSubscribedToCurrent =
        isSubscribedToWorkout(subscriptions, workout, currentUserId);

    return Card(
        color: isSubscribedToCurrent
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
        child: ListTile(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (hasUser1)
                    const Text(
                      "🏋️‍♀",
                      style: TextStyle(fontSize: 24),
                    ),
                  if (hasUser2)
                    const Text(
                      "🏋️‍♂",
                      style: TextStyle(fontSize: 24),
                    )
                ]),
            isThreeLine: true,
            title: Text(workout.toString()),
            subtitle: Text(
                [workout.dateTime()].join("\n")),
            trailing: isSubscribedToCurrent
                ? OutlinedButton(
                    onPressed: () {
                      ButlerApi.removeSubscription(workout, currentUserId);
                    },
                    child: const Text(
                      "Cancel",
                    ))
                : ElevatedButton(
                    onPressed: () {
                      ButlerApi.addSubscription(Subscription(
                          userId: currentUserId,
                          workoutTypeId: workout.workoutType.id,
                          timeOfDay: TimeOfDay.fromDateTime(workout.startTime),
                          weekDay: workout.weekday));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer),
                    child: Text(
                      "Subscribe",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ))));
  }
}

bool isSubscribedToWorkout(List<Subscription> subscriptions, Workout workout,
    [int? userId]) {
  return subscriptions.any((element) =>
      (element.timeOfDay == TimeOfDay.fromDateTime(workout.startTime) &&
          element.weekDay == workout.weekday &&
          element.workoutTypeId == workout.workoutType.id) &&
      (userId == null || element.userId == userId));
}
