import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../view_models/user_view_model.dart';
import 'package:grosseries/components/input_qty.dart';

class ManageReminders extends StatefulWidget {
  const ManageReminders({super.key});

  @override
  State<ManageReminders> createState() => _ManageRemindersState();
}

class _ManageRemindersState extends State<ManageReminders> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<UserViewModel>().currentUser;
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 1,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black),
            onPressed: (() => GoRouter.of(context).go("/profile")),
          ),
          title: const Text('Manage Reminders'),
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: SwitchListTile(
                    title: const Text(
                        'Turn on push notifications and always cook your food before it expires.',
                        style: TextStyle(fontSize: 15)),
                    value: currentUser!.notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        currentUser.notificationsEnabled = value;
                        context
                            .read<UserViewModel>()
                            .userDatabase[currentUser.email]!
                            .notificationsEnabled = value;
                      });
                    })),
            const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                    "When would you like to receive a reminder that your items are about to expire?",
                    style: TextStyle(fontSize: 15))),
            InputQty(
              initVal: currentUser.notificationDayAmount,
              minVal: 0,
              maxVal: 100,
              onQtyChanged: (val) {
                currentUser.notificationDayAmount = val!.toInt();
                context
                    .read<UserViewModel>()
                    .userDatabase[currentUser.email]!
                    .notificationDayAmount = val.toInt();
              },
              id: currentUser.id,
              view: 'manage-reminders',
            ),
            const Text("days")
          ],
        ));
  }
}
