import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liber/custom_objects/constant_functions.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/tiktoker.dart';
import 'package:share_plus/share_plus.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<TikToker> tikTokers = ConstantFunctions.getTikTokers();
  List<String> aboutDeveloperMediaList = [
    // website
    'https://crow-hexahedron-rmrf.squarespace.com/',
    // tiktok
    'https://www.tiktok.com/@mockairplane700',
    // instagram
    'https://www.instagram.com/promethues97/',
    // youtube
    'https://www.youtube.com/channel/UC9wKe8g-hvuhZkWNTxrLGqw',
    // linkedIn
    'https://www.linkedin.com/in/mthandazo-edwin-siziba-3a31139a',
    // twitter
    'https://twitter.com/Mockairplane700',
    // github
    'https://github.com/MockAirplane700'
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: CircleAvatar(
            radius: MediaQuery.of(context).size.width/50,
            backgroundColor: Colors.white,
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/coupons-are-us.appspot.com/o/Liber%20logo.png?alt=media&token=4965c137-e0da-41cd-b985-3835fa214116'),
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
          // const Divider(),
          // //Rate the app
          // ListTile(
          //   title: const Text('Rate Liber!'),
          //   leading: const Icon(Icons.star_rate_rounded),
          //   onTap: () {
          //     //go to the relevant page or do the relevant function
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) => AlertDialog(
          //           title: const Text('Rate Liber'),
          //           content: Column(
          //             children: [
          //               Expanded(child: IconButton(onPressed: () {
          //                 ConstantFunctions.launchUrlFromLogic(Uri.parse(rateLiberAppleStore));
          //               }, icon:const Icon(Icons.apple))),
          //               Expanded(child: IconButton(onPressed: () {
          //                 ConstantFunctions.launchUrlFromLogic(Uri.parse(rateLiberGooglePlayStore));
          //               }, icon:const Icon(Icons.android))),
          //             ],
          //           ),
          //         )
          //     );
          //   },
          //   trailing: const Icon(Icons.arrow_right_outlined),
          // ),
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
          //about the tik tok accounts used
          ListTile(
            title: const Text('About the app'),
            onTap: () {
              showDialog(
                  context: context,
                barrierDismissible: true,
                builder: (BuildContext context) =>AlertDialog(
                  title:const Text('About the App'),
                  // Column -> description of how we get the websites , ListView.builder -> ListTile ( tiktok account information) onTap -> go to tiktok account
                  content:Column(children: [
                    const Padding(padding: EdgeInsets.zero, child: Text(aboutTikTokersMessage, style: TextStyle(color: textColor),),),
                    const Divider(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/2.5,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return tikTokers.isNotEmpty ? Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                              elevation: 3,
                              child: ListTile(
                                leading: Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width/100),
                                  child: Image.network(tikTokers[index].networkImage),
                                ),
                                title: Text(tikTokers[index].name,  style: const TextStyle(color: textColor)),
                                // subtitle: Text(tikTokers[index].description, style: const TextStyle(color: textColor),),
                                trailing: const Icon(Icons.more_vert),
                                onTap: () {
                                  ConstantFunctions.launchUrlFromLogic(Uri.parse(tikTokers[index].link));
                                },
                              ),
                            ) : const Text('No tik tokers present my Lord!');
                          },
                        itemCount: tikTokers.length,
                      ),
                    ),
                    const Divider(),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                      elevation: 3,
                      child: ListTile(
                        leading:  const FaIcon(FontAwesomeIcons.fileContract),
                        title: const Text('Privacy Policy', style: TextStyle(color: textColor),),
                        subtitle: const Text('See my privacy policy', style: TextStyle(color: textColor),),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          ConstantFunctions.launchUrlFromLogic(Uri.parse(privacyPolicy));
                        },
                      ),
                    ),
                  ],),
                )
              );
            },
            leading: const Icon(Icons.info_outline),
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //about the developer
          ListTile(
            title: const Text('About the developer'),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title:const Text('About the developer'),
                    content: SingleChildScrollView(child: Column(
                      children: [
                        const Text(aboutDeveloper, style: TextStyle(color: textColor),),
                        const Divider(),
                        //website
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                          elevation: 3,
                          child: ListTile(
                            leading: const FaIcon(FontAwesomeIcons.internetExplorer),
                            title: const Text('Website', style: TextStyle(color: textColor),),
                            subtitle: const Text('Visit my website', style: TextStyle(color: textColor),),
                            trailing: const Icon(Icons.more_vert),
                            onTap: () {
                              ConstantFunctions.launchUrlFromLogic(Uri.parse(aboutDeveloperMediaList[0]));
                            },
                          ),
                        ),
                        // tiktok
                        const Divider(),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                          elevation: 3,
                          child: ListTile(
                            leading:  const FaIcon(FontAwesomeIcons.tiktok),
                            title: const Text('Tiktok', style: TextStyle(color: textColor),),
                            subtitle: const Text('Visit my tikTok', style: TextStyle(color: textColor),),
                            trailing: const Icon(Icons.more_vert),
                            onTap: () {
                              ConstantFunctions.launchUrlFromLogic(Uri.parse(aboutDeveloperMediaList[1]));
                            },
                          ),
                        ),
                        // Instagram
                        const Divider(),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                          elevation: 3,
                          child: ListTile(
                            leading: const FaIcon(FontAwesomeIcons.instagram),
                            title: const Text('Instagram', style: TextStyle(color: textColor),),
                            subtitle: const Text('Visit my Instagram', style: TextStyle(color: textColor),),
                            trailing:  const Icon(Icons.more_vert),
                            onTap: () {
                              ConstantFunctions.launchUrlFromLogic(Uri.parse(aboutDeveloperMediaList[2]));
                            },
                          ),
                        ),
                        // youtube
                        const Divider(),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                          elevation: 3,
                          child: ListTile(
                            leading:  const FaIcon(FontAwesomeIcons.youtube),
                            title: const Text('Youtube', style: TextStyle(color: textColor),),
                            subtitle: const Text('Visit my youtube channel', style: TextStyle(color: textColor),),
                            trailing: const Icon(Icons.more_vert),
                            onTap: () {
                              ConstantFunctions.launchUrlFromLogic(Uri.parse(aboutDeveloperMediaList[3]));
                            },
                          ),
                        ),
                        //LinkedIn
                        const Divider(),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                          elevation: 3,
                          child: ListTile(
                            leading: const FaIcon(FontAwesomeIcons.linkedin),
                            title: const Text('LinkedIn', style: TextStyle(color: textColor),),
                            subtitle: const Text('Visit my LinkedIn profile', style: TextStyle(color: textColor),),
                            trailing:  const Icon(Icons.more_vert),
                            onTap: () {
                              ConstantFunctions.launchUrlFromLogic(Uri.parse(aboutDeveloperMediaList[4]));
                            },
                          ),
                        ),
                        // twitter
                        const Divider(),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                          elevation: 3,
                          child: ListTile(
                            leading:const FaIcon(FontAwesomeIcons.twitter),
                            title: const Text('Twitter', style: TextStyle(color: textColor),),
                            subtitle: const Text('Visit my twitter', style: TextStyle(color: textColor),),
                            trailing:  const Icon(Icons.more_vert),
                            onTap: () {
                              ConstantFunctions.launchUrlFromLogic(Uri.parse(aboutDeveloperMediaList[5]));
                            },
                          ),
                        ),
                        // github
                        const Divider(),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/60)),
                          elevation: 3,
                          child: ListTile(
                            leading:const FaIcon(FontAwesomeIcons.github),
                            title: const Text('Github', style: TextStyle(color: textColor),),
                            subtitle: const Text('Visit my github', style: TextStyle(color: textColor),),
                            trailing:  const Icon(Icons.more_vert),
                            onTap: () {
                              ConstantFunctions.launchUrlFromLogic(Uri.parse(aboutDeveloperMediaList[6]));
                            },
                          ),
                        ),
                      ],
                    ),),
                  )
              );
            },
            leading: const Icon(Icons.engineering),
            trailing: const Icon(Icons.arrow_right_outlined),
          ),
          const Divider(),
          //sign out
          // ListTile(
          //   title: const Text('Sign out'),
          //   leading: const Icon(Icons.logout),
          //   onTap: () {
          //     //go to the relevant page or do the relevant function
          //     ConstantFunctions.signOut();
          //     Navigator.pop(context);
          //   },
          //   trailing: const Icon(Icons.arrow_right_outlined),
          // ),
          // const Divider(),
        ],
      ),
    );
  }
}
