import "package:flutter/material.dart";
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../view_models/user_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  final _formKey = GlobalKey<FormState>();

  String emailInput = "";
  String passwordInput = "";

  var emailValidator =
      ValidationBuilder(requiredMessage: "Email is required").email().build();
  var passwordValidator =
      ValidationBuilder(requiredMessage: "Password is required").build();

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //app logo
              Image.asset(
                'assets/icons/groceries_icon.png',
                height: 150,
                width: 150,
              ),
              // const SizedBox(height: 20),

              //app name
              Text(
                "Grosseries",
                style: GoogleFonts.bebasNeue(
                  fontWeight: FontWeight.bold,
                  fontSize: 52,
                ),
              ),

              //tagline
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  "Eat your groceries before they become gross-eries ;)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // username textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      validator: emailValidator,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 18, 156, 57),
                        ),
                      ),
                      onSaved: (value) => setState(() {
                        emailInput = value!;
                      }),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      obscureText: _isHidden,
                      validator: passwordValidator,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 18, 156, 57),
                          ),
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          )),
                      onSaved: (value) => setState(() {
                        passwordInput = value!;
                      }),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //new sign in button
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                      onTap: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          _formKey.currentState?.save();

                          debugPrint(_formKey.currentState.toString());

                          var loginResult = context.read<UserViewModel>().login(
                                emailInput,
                                passwordInput,
                              );

                          if (loginResult == false) {
                            setState((() => isError = true));
                          } else {
                            setState((() => isError = false));

                            GoRouter.of(context).go("/");
                          }

                          debugPrint(loginResult.toString());
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 18, 156, 57),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                              child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ))))),
              const SizedBox(height: 8),
              isError == true
                  ? const Text(
                      "Account not found, please try again",
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              const SizedBox(height: 25),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an Account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    // onTap: widget.showRegisterpage,
                    onTap: () => GoRouter.of(context).go("/create_account"),
                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                        color: Color.fromARGB(255, 137, 194, 153),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ))));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
