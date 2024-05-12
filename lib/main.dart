import 'package:everide_frontend/config/routes/go_routes.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Proxima Nova"),
        routerConfig: router,
      ),
    );
  }
}
