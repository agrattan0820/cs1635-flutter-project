import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';

class EditProfileMore extends StatefulWidget {
  const EditProfileMore({super.key});

  @override
  State<EditProfileMore> createState() => _EditProfileMoreState();
}

class _EditProfileMoreState extends State<EditProfileMore> {
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
                onPressed: (() => GoRouter.of(context).go("/edit_profile")), 
            ),
            title: const Text('Edit Profile'),
          ),

          body: Container(
            padding: const EdgeInsets.only(left: 15, top: 20, right: 15),

            child: Column(children: const [
              SizedBox(height: 30),

              LogoutDialog(), 
              
              SizedBox(height: 30),
              
              DeleteAccountDialog(),
            ],
          )    
        ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Log out', style: TextStyle(
        fontSize: 20,
        color:Colors.black,
        ),
      ),

      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning!'),
          content: const Text('Are you sure you want to log out of Grosseries?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Delete Account', style: TextStyle(
        fontSize: 20,
        color:Colors.black
        ),
      ),

      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning!'),
          content: const Text('Are you sure you want to delete your Grosseries account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}