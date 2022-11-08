import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => FoodItemViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => UserViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const App());
  }
}
