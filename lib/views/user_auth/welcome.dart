import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor: Colors.white,
          body: SafeArea(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //grocery image
              Image.asset(
                  'assets/grocery_family.jpg', 
                  height: 400,
                  width: 500,
              ),

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
              const Text(
                "Eat your groceries before they become gross-eries ;)",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 50),
              
              //Get Started
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                    onTap: () => GoRouter.of(context).go("/create_account"),
                    child: Container(
                      padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 18, 156, 57),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        )
                      )
                  )
                )
              ),
              const SizedBox(height: 25),

              //Log In 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                    onTap: () => GoRouter.of(context).go("/login"),
                    child: Container(
                      padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 137, 194, 153),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                        )
                      )
                  )
                )
              ),
              const SizedBox(height: 25),
            ],
          )
          )
        )
      );
  }       
}
