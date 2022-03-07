import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/movie/presentation/pages/movies_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  GetIt.I.isReady<SharedPreferences>().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'movies list',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
      ),
      home: const MoviesListScreen(),
    );
  }
}
