import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/food_category_view_model.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';
import 'package:flutter_application_1/view_models/user_view_model.dart';
import 'package:flutter_application_1/views/add_food_category.dart';
import 'package:flutter_application_1/views/add_food_item_detail.dart';
import 'package:flutter_application_1/views/app_scaffold.dart';
import 'package:flutter_application_1/views/food_list_view.dart';
import 'package:flutter_application_1/views/user_auth/login.dart';
import 'package:flutter_application_1/views/item_details_view.dart';
import 'package:flutter_application_1/views/user_auth/create_account.dart';
import 'package:flutter_application_1/views/user_auth/profile.dart';
import 'package:flutter_application_1/views/user_auth/welcome.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FoodListEntryViewModel>(
        create: (_) => FoodListEntryViewModel(),
      ),
      ChangeNotifierProvider<FoodItemViewModel>(
        create: (_) => FoodItemViewModel(),
      ),
      ChangeNotifierProvider<FoodCategoryViewModel>(
        create: (_) => FoodCategoryViewModel(),
      ),
      ChangeNotifierProvider<UserViewModel>(
        create: (_) => UserViewModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Grosseries',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        // scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/welcome', //welcome screen for onboarding
    routes: [
      ShellRoute(
          builder: (context, state, child) {
            return AppScaffold(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FoodListView(),
              ),
            ),
            GoRoute(
                path: '/add_item',
                pageBuilder: (context, state) => const NoTransitionPage(
                      child: AddFoodCategoryView(),
                    ),
                routes: [
                  GoRoute(
                    path: "details/:item",
                    builder: ((context, state) {
                      return const AddFoodDetailView();
                    }),
                  ),
                ]),
            GoRoute(
                path: '/item_details/:id',
                builder: (BuildContext context, GoRouterState state) {
                  return ItemDetailsView(id: state.params['id']);
                })
          ]),
      GoRoute(
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/create_account',
        builder: (BuildContext context, GoRouterState state) {
          return const CreateAccountPage();
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        },
      ),
    ],
  );
}
