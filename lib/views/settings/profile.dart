import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grosseries/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

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
    User? currentUser = context.watch<UserViewModel>().currentUser;

    return Scaffold(
        backgroundColor: Colors.yellow[200],
        body: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //get user bubble initials
            UserBubble(
              user: "${currentUser!.firstName} ${currentUser.lastName}",
              borderSize: 20,
              textSize: 25,
            ),

            //display name of user:
            Text(
              "${currentUser.firstName} ${currentUser.lastName}",
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 30),

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
                const Text(
                  "Account ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go("/edit_profile"),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),

            // //Household - Send Invite
            //NOTE: will not be included in the final deliverable as we chose to not move forward with implementing household-related tasks due to time constraints (explained in deliverable 3 demo)
            // const Divider(
            //   height: 20,
            //   thickness: 1,
            //   indent: 20,
            //   endIndent: 20,
            //   color: Colors.black,
            // ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     const Text("Household ",
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //         ),
            //     ),

            //     GestureDetector(
            //       onTap: () => GoRouter.of(context).go("/household_send_invite"),
            //       child: const Text(
            //         "Send Invite",
            //           style: TextStyle(
            //         color: Colors.grey,
            //         fontWeight: FontWeight.bold,
            //       ),
            //       ),
            //     )
            //   ],
            // ),

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
                const Text(
                  "Expiration Date ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).go("/manage_reminders"),
                  child: const Text(
                    "Manage Reminders",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
        ))));
  }
}
