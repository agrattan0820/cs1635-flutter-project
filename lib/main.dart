import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:grosseries/view_models/food_category_view_model.dart';
import 'package:grosseries/view_models/food_list_entry_view_model.dart';
import 'package:grosseries/view_models/food_item_view_model.dart';
import 'package:grosseries/view_models/user_view_model.dart';
import 'package:grosseries/views/add_food_category.dart';
import 'package:grosseries/views/add_food_item_detail.dart';
import 'package:grosseries/views/app_scaffold.dart';
import 'package:grosseries/views/food_list_view.dart';
import 'package:grosseries/views/settings/edit_profile.dart';
import 'package:grosseries/views/settings/edit_profile_more.dart';
import 'package:grosseries/views/settings/manage_reminders.dart';
import 'package:grosseries/views/user_auth/login.dart';
import 'package:grosseries/views/item_details_view.dart';
import 'package:grosseries/views/user_auth/create_account.dart';
import 'package:grosseries/views/settings/profile.dart';
import 'package:grosseries/views/user_auth/welcome.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  AwesomeNotifications().initialize(
    "resource://drawable/res_app_icon",
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.yellow[800],
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.yellow[800],
        importance: NotificationImportance.High,
      ),
    ],
    debug: true,
  );
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
      debugShowCheckedModeBanner: false, //remove DEBUG banner
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
              path: '/edit_profile',
              builder: (BuildContext context, GoRouterState state) {
                return const EditProfile();
              },
            ),
            GoRoute(
              path: '/edit_profile_more',
              builder: (BuildContext context, GoRouterState state) {
                return const EditProfileMore();
              },
            ),
            GoRoute(
              path: '/manage_reminders',
              builder: (BuildContext context, GoRouterState state) {
                return const ManageReminders();
              },
            ),
            GoRoute(
                path: '/item_details/:id',
                builder: (BuildContext context, GoRouterState state) {
                  return ItemDetailsView(id: state.params['id']);
                }),
            GoRoute(
              path: '/profile',
              builder: (BuildContext context, GoRouterState state) {
                return const ProfilePage();
              },
            ),
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
    ],
  );
}
