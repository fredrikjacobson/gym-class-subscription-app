import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_butler/api/butler_api.dart';
import 'package:gym_butler/models/subscription.dart';
import 'package:gym_butler/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/gym_class_card.dart';
import '../components/loading_indicator.dart';
import '../components/weekday_tab_bar.dart';
import '../providers/workouts_provider.dart';

class Workouts extends HookConsumerWidget {
  const Workouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutsProvider);
    final currentUserId = ref.watch(userProvider);
    final subscriptionStream = useStream(ButlerApi.subscriptions());
    final List<Subscription> subscriptions =
        subscriptionStream.hasData ? subscriptionStream.data ?? [] : [];

    final tabController = useTabController(initialLength: 7);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: workouts.when(
                data: (workouts) {
                  final filteredWorkouts = workouts
                      .where((element) =>
                          element.weekday.index == tabController.index + 1)
                      .toList();
                  return ListView.builder(
                      itemCount: filteredWorkouts.length,
                      itemBuilder: (context, index) {
                        final workout = filteredWorkouts[index];
                        return GymClassCard(
                            subscriptions: subscriptions,
                            workout: workout,
                            currentUserId: currentUserId);
                      });
                },
                loading: () => const LoadingIndicator(),
                error: (err, st) => const Text("Could not fetch workouts"))),
        WeekdayTabBar(tabController: tabController),
      ],
    );
  }
}
