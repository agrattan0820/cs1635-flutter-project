import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grosseries/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 75),
            // Create an Account
            Text(
              "Create an Account",
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.bold,
                fontSize: 52,
              ),
            ),
            const SizedBox(height: 50),

            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "First Name",
                            ),
                            validator: firstNameValidator,
                            onSaved: ((value) =>
                                setState(() => firstNameInput = value!)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // last name textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Last Name",
                            ),
                            validator: lastNameValidator,
                            onSaved: ((value) =>
                                setState(() => lastNameInput = value!)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                            ),
                            validator: emailValidator,
                            onSaved: ((value) =>
                                setState(() => emailInput = value!)),
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
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                            validator: passwordValidator,
                            onSaved: ((value) =>
                                setState(() => passwordInput = value!)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // re-enter password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Re-Enter Password",
                            ),
                            validator: confirmPasswordValidator,
                            onSaved: ((value) =>
                                setState(() => confirmPasswordInput = value!)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // register button
                    InkWell(
                      onTap: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          _formKey.currentState?.save();

                          debugPrint(_formKey.currentState.toString());

                          var createAccountResult =
                              context.read<UserViewModel>().createAccount(
                                    firstNameInput,
                                    lastNameInput,
                                    emailInput,
                                    passwordInput,
                                    confirmPasswordInput,
                                  );

                          if (createAccountResult[0] == false) {
                            setState((() => isError = createAccountResult));
                          } else {
                            setState((() => isError = null));

                            GoRouter.of(context).go("/login");
                          }

                          debugPrint(createAccountResult.toString());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 18, 156, 57),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    isError != null
                        ? Text(
                            isError![1],
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox()
                  ],
                )),

            // first name textfield

            const SizedBox(height: 25),

            // already a member? login now!
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  // onTap: widget.showRegisterpage,
                  onTap: () => GoRouter.of(context).go("/login"),
                  child: const Text(
                    "Login now",
                    style: TextStyle(
                      color: Color.fromARGB(255, 137, 194, 153),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),

            //IMPLEMENT LATER
            // Row(children: <Widget>[
            //   Expanded(
            //     child: Container(
            //         margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            //         child: Divider(
            //           color: Colors.black,
            //           height: 36,
            //         )),
            //   ),

            //   Text("OR"),
            //   Expanded(
            //     child: Container(
            //         margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            //         child: Divider(
            //           color: Colors.black,
            //           height: 36,
            //         )),
            //   ),
            //   ]
            // ),

            // Row(
            //   children: <Widget>[Text("google, facebook, ")],
            // ),
          ],
        ))));
  }
}
