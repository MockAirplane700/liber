import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: CircleAvatar(
            backgroundImage: const NetworkImage('https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png'),
            radius: MediaQuery.of(context).size.width/50,
          )),
          const Divider(),
          //Share the app
          ListTile(
            title: const Text('Share the coupons are us!'),
            leading: const Icon(Icons.share),
            onTap: () {
              //go to the relevant page or do the relevant function
            },
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //Rate the app
          ListTile(
            title: const Text('Rate coupons are us!'),
            leading: const Icon(Icons.star_rate_rounded),
            onTap: () {
              //go to the relevant page or do the relevant function
            },
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //Report bugs
          ListTile(
            title: const Text('Report a bug!'),
            leading: const Icon(Icons.bug_report),
            onTap: () {
              //go to the relevant page or do the relevant function
            },
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //Contact developer
          ListTile(
            title: const Text('Contact the developer!'),
            onTap: () {
              //go to the relevant page or do the relevant function
            },
            leading: const Icon(Icons.email_outlined),
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //about
          ListTile(
            title: const Text('About'),
            onTap: () {
              //go to the relevant page or do the relevant function
            },
            leading: const Icon(Icons.info_outline),
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //sign out
          ListTile(
            title: const Text('Sign out'),
            leading: const Icon(Icons.logout),
            onTap: () {
              //go to the relevant page or do the relevant function
              Navigator.pop(context);
            },
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
