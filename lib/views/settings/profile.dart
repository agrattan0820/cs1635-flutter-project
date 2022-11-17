import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/user_bubble.dart';
import '../../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        backgroundColor: Colors.yellow[200],
        body: SafeArea(
            child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
              //get user bubble + name? how do i do that? 
            // UserBubble(user: user),


          //Account - Edit Profile
            const Divider(
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Account ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go("/edit_profile"),
                  child: const Text(
                    "Edit Profile",
                     style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                )
              ],
            ),

          //Household - Send Invite
            const Divider(
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Household ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                ),
                
                GestureDetector(
                  onTap: () => GoRouter.of(context).go("/household_send_invite"),
                  child: const Text(
                    "Send Invite",
                     style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                )
              ],
            ),

          //Expiration Date - Manage Reminders
            const Divider(
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Expiration Date ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                ),
                
                GestureDetector(
                  onTap: () => GoRouter.of(context).go("/manage_reminders"),
                  child: const Text(
                    "Manage Reminders",
                     style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                )
              ],
            ),
            
            const Divider(
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),
          ],
         )
        )
      )
   );
  }
}