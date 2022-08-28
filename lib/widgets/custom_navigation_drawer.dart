import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constant_functions.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:share_plus/share_plus.dart';

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
            backgroundImage:NetworkImage(ConstantFunctions.getProfilePicture()),
            radius: MediaQuery.of(context).size.width/50,
          )),
          const Divider(),
          //Share the app
          ListTile(
            title: const Text('Share Liber!'),
            leading: const Icon(Icons.share),
            onTap: () {
              //go to the relevant page or do the relevant function
              Share.share(shareCouponsAreUsUrl);
            },
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //Rate the app
          ListTile(
            title: const Text('Rate Liber!'),
            leading: const Icon(Icons.star_rate_rounded),
            onTap: () {
              //go to the relevant page or do the relevant function
              showDialog(
                  context: context, 
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Rate Liber'),
                    content: Column(
                      children: [
                        Expanded(child: IconButton(onPressed: () {
                          ConstantFunctions.launchUrlFromLogic(Uri.parse(rateCouponsAreUsAppleStore));
                        }, icon:const Icon(Icons.apple))),
                        Expanded(child: IconButton(onPressed: () {
                          ConstantFunctions.launchUrlFromLogic(Uri.parse(rateCouponsAreUsGooglePlayStore));
                        }, icon:const Icon(Icons.android))),
                      ],
                    ),
                  )
              );
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
              ConstantFunctions.launchUrlFromLogic(Uri(scheme: 'mailto', path: email, query: 'Reporting a bug'));
            },
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //Contact developer
          ListTile(
            title: const Text('Contact the developer!'),
            onTap: () {
              //go to the relevant page or do the relevant function
              ConstantFunctions.launchUrlFromLogic(Uri(scheme: 'mailto', path: email, query: 'Dear CouponsAreUs developer'));
            },
            leading: const Icon(Icons.email_outlined),
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //about
          ListTile(
            title: const Text('About'),
            onTap: () {
              showDialog(
                  context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => const AlertDialog(
                  title:Text('About the developer'),
                  content:Text(aboutDeveloper),
                )
              );
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
              ConstantFunctions.signOut();
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
