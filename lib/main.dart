import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gym_butler/api/gym_api.dart';
import 'package:gym_butler/color_schemes.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/users.dart';
import 'screens/workouts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = dotenv.env['FIRESTORE_USER']!;
  final pw = dotenv.env['FIRESTORE_PW']!;
  final baseUrl = dotenv.env['GYM_BASE_URL']!;

  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user, password: pw);
  runApp(ProviderScope(
    overrides: [gymApiProvider.overrideWithValue(GymApi(baseUrl: baseUrl))],
    child: const GymButler(),
  ));
}

class GymButler extends StatelessWidget {
  const GymButler({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Globo Gym Subscription',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          primaryColor: darkColorScheme.primary,
          accentColor: darkColorScheme.secondary),
      home: Builder(
          builder: (context) => DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: TabBar(
                      tabs: [
                        Tab(
                            icon: Icon(
                          Icons.sticky_note_2_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                        Tab(
                            icon: Icon(
                          Icons.supervised_user_circle_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                      ],
                    ),
                    title: const Text("Globo Gym"),
                  ),
                  body: const TabBarView(
                    children: [Workouts(), Users()],
                  ),
                ),
              )),
    );
  }
}
