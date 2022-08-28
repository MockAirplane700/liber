import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:liber/custom_objects/constant_functions.dart';
import 'package:liber/pages/home.dart';

const FlutterAppAuth appAuth =  FlutterAppAuth();
const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
/// ----------------------------------------------------
///
///               Auth0 variables
/// ----------------------------------------------------
const  AUTH0_DOMAIN = 'dev-f1-rzg-y.us.auth0.com';
const AUTH0_CLIENT_ID = '48hAOwzIevz03Dp7iV9mXnB7yeSiKlMO';

const AUTH0_REDIRECT_URI = 'com.mthandazoedwinsiziba.liber://login-callback';
const AUTH0_ISSUER = 'https://dev-f1-rzg-y.us.auth0.com';
/// ----------------------------------------------------
///
///               Profile widget
/// ----------------------------------------------------
// class ProfileWidget extends StatelessWidget {
//   const ProfileWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

/// ----------------------------------------------------
///
///               Login widget
/// ----------------------------------------------------

/// ----------------------------------------------------
///
///               App
/// ----------------------------------------------------
///
class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String name = '';
  String picture = '';

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }//end parse id token

  Future<Map> getUserDetails(String accessToken) async {
    final Uri url = Uri.parse('https://dev-f1-rzg-y.us.auth0.com/userinfo');
    final response = await http.get(
      url,
      headers: {'Authorization' : 'Bearer $accessToken'}
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }else{
      throw Exception('Failed to get user details');
    }//end if-else
  }//end user details

  Future<void> logInAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final  AuthorizationTokenResponse result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
            AUTH0_CLIENT_ID,
            AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid', 'profile', 'offline_access'],
          promptValues: ['login']
        ),
      ) as AuthorizationTokenResponse;

      final idToken = parseIdToken('${result.idToken}');
      final profile = await getUserDetails(result.accessToken as String);

      await flutterSecureStorage.write(key: 'refresh_token', value: result.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];

      });
      // add the profile picture to the drawer
      ConstantFunctions.addNetworkString(picture);
    }catch (ioe) {
      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = ioe.toString();
      });
      throw Exception(errorMessage);
    }//end try-catch
  }//end login action

  void logoutAction() async {
    await flutterSecureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }//end logout action

  void initAction() async {
    final storedRefreshToken = await flutterSecureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken
      )) as TokenResponse;

      final idToken = parseIdToken(response.idToken as String);
      final profile = await getUserDetails(response.accessToken as String);

      flutterSecureStorage.write(key: 'refresh_token', value: response.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = idToken['picture'];
      });
      ConstantFunctions.setSignOutAction(logoutAction);
    }catch (ioe) {
      logoutAction();
      throw Exception('Error on refresh token: ${ioe.toString()}');
    }//end try-catch
  }//end init action
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }//end init state
  @override
  Widget build(BuildContext context) {
    ConstantFunctions.setSignOutAction(logoutAction);

    return Scaffold(
      appBar: AppBar(title: const Text('Auth0'),),
      body: Center(
        child: isBusy ? const CircularProgressIndicator() :isLoggedIn ? const Home(): FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Text('logged in yeah baby');
              }else{
                return const CircularProgressIndicator();
              }//end if-else
            },
          future: logInAction(),
        ),
      ),
    );
  }
}
