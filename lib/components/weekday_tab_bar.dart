import 'package:flutter/material.dart';

class WeekdayTabBar extends StatelessWidget {
  const WeekdayTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(
            icon: Text(
          "1",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
        Tab(
            icon: Text(
          "2",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
        Tab(
            icon: Text(
          "3",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
        Tab(
            icon: Text(
          "4",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
        Tab(
            icon: Text(
          "5",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
        Tab(
            icon: Text(
          "6",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
        Tab(
            icon: Text(
          "7",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
      ],
    );
  }
}
