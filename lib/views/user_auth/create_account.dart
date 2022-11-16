import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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

            // first name textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "First Name",
                    ),
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Last Name",
                    ),
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Re-Enter Password",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),


            // register button
            InkWell(
              onTap: () => GoRouter.of(context).go("/login"),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 156, 57),
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
            const SizedBox(height: 25),

            // already a member? login now!
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an Account? ",
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
        )
      )
    )
    );
  }
}

