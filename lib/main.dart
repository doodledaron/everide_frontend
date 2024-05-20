import 'package:everide_frontend/config/routes/go_routes.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/google_map_service_provider.dart';
import 'package:everide_frontend/src/provider/order_provider.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleMapServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: "Proxima Nova",
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor)),
        routerConfig: router,
      ),
    );
  }
}
