import 'package:flutter/material.dart';
import 'package:gym_butler/api/butler_api.dart';
import 'package:gym_butler/models/user.dart';
import 'package:gym_butler/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final usersProvider = FutureProvider<List<User>>((ref) async {
  return await ButlerApi.getUsers();
});

class Users extends ConsumerWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersFut = ref.watch(usersProvider);

    final selectedUser = ref.watch(userProvider.notifier);

    return Scaffold(
        body: usersFut.when(
            data: (users) {
              return Column(children: [
                ...users.map((user) {
                  final selected = user.id == selectedUser.state;
                  return InkWell(
                      onTap: () {
                        ref.read(userProvider.notifier).state = user.id;
                      },
                      child: Card(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        child: ListTile(
                            leading: selected
                                ? const Icon(Icons.check_circle_outline)
                                : const Text(""),
                            title: Text(user.email,
                                style: TextStyle(
                                    color: selected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground))),
                      ));
                }).toList()
              ]);
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, st) => const Text("Something went wrong")));
  }
}
