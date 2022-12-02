import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';

import '../../components/user_bubble.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 1,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black ),
              onPressed: (() => GoRouter.of(context).go("/profile")), 
          ),

          title: const Text('Edit Profile'),

          actions: [
            IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black ),
              onPressed: (() => GoRouter.of(context).go("/edit_profile_more")), 
          ),
          ],
        ),

        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },

            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: const [                      
                      UserBubble(user: "Jennifer Zheng", borderSize: 20, textSize: 25),
                    ],
                  )
                ),
                const SizedBox(height: 30),

                buildTextField("First Name", "Jennifer", false),
                buildTextField("Last Name", "Zheng", false),
                buildTextField("Email", "jennifer.zheng@pitt.edu", false),
                buildTextField("Password", "************", true),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      // ignore: sort_child_properties_last
                      child: const Text("Cancel", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color:Colors.black
                        )
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      // ignore: sort_child_properties_last
                      child: const Text("Save", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color:Colors.white
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        primary: const Color.fromARGB(255, 18, 156, 57),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),
                  ],
                )
              ]
            )
          )
        )
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField ? 
            IconButton(
              icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
              onPressed: () {
                setState(() {
                  isObscurePassword = !isObscurePassword;
                });
              },
          ): null,

          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )
        ),
      )
    );
  }
  
}

