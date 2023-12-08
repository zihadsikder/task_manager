import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationkey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context)  {
    return GetMaterialApp(
      navigatorKey: navigationkey,
        home: const SplashScreen(),
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
            textTheme: const TextTheme(
                titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            )),

            primarySwatch: Colors.green,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
            ))),
        initialBinding: ControllerBinder(),
    );
  }


}

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
  }
}
