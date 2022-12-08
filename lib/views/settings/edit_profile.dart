import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/user_bubble.dart';
import '../../models/user.dart';
import '../../view_models/user_view_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isHidden = true;

  final _formKey = GlobalKey<FormState>();

  String firstNameInput = "";
  String lastNameInput = "";
  String emailInput = "";
  String passwordInput = "";
  String confirmPasswordInput = "";

  var firstNameValidator =
      ValidationBuilder(requiredMessage: "First Name is required").build();
  var lastNameValidator =
      ValidationBuilder(requiredMessage: "Last Name is required").build();
  var emailValidator =
      ValidationBuilder(requiredMessage: "Email is required").email().build();
  var passwordValidator =
      ValidationBuilder(requiredMessage: "Password is required").build();
  var confirmPasswordValidator =
      ValidationBuilder(requiredMessage: "Confirm Password is required")
          .build();

  List? isError;

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
          onPressed: (() => GoRouter.of(context).pop()),
        ),
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: (() => GoRouter.of(context).go("/edit_profile_more")),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child:
                      //get user bubble initials
                      UserBubble(
                    user: "${currentUser!.firstName} ${currentUser.lastName}",
                    borderSize: 20,
                    textSize: 25,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    obscureText: false,
                    onSaved: ((value) =>
                        setState(() => firstNameInput = value!)),
                    validator: firstNameValidator,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "First Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: currentUser.firstName,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    obscureText: false,
                    onSaved: ((value) =>
                        setState(() => lastNameInput = value!)),
                    validator: lastNameValidator,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Last Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: currentUser.lastName,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    obscureText: false,
                    onSaved: ((value) => setState(() => emailInput = value!)),
                    validator: emailValidator,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: currentUser.email,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    obscureText: _isHidden,
                    onSaved: ((value) =>
                        setState(() => passwordInput = value!)),
                    validator: passwordValidator,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                      ),
                      labelText: "Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "**********",
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: (() => GoRouter.of(context).pop()),
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.black,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();

                          debugPrint(_formKey.currentState.toString());
                          debugPrint(firstNameInput);
                          debugPrint(lastNameInput);
                          debugPrint(emailInput);
                          debugPrint(passwordInput);

                          var editProfileResult =
                              context.read<UserViewModel>().editProfile(
                                    firstNameInput,
                                    lastNameInput,
                                    emailInput,
                                    passwordInput,
                                  );

                          _formKey.currentState?.reset();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Profile successfully edited"),
                          ));

                          debugPrint(editProfileResult.toString());
                        }
                      },
                      // ignore: sort_child_properties_last
                      child: const Text("Save",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: const Color.fromARGB(255, 18, 156, 57),
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
