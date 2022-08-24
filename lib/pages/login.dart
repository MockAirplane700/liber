import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/pages/home.dart';
import 'package:liber/pages/mongo_demo.dart';
import 'package:liber/pages/sign_up.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: textColor),),
        elevation: 0,
        iconTheme: const IconThemeData(color: applicationIconThemeColor),
        backgroundColor: appBarColor,
      ),
      backgroundColor: applicationBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width/40),
              child: Form(
                key: _key,
                  child: Column(
                    children: [
                      //email
                      TextFormField(
                        decoration:  const InputDecoration(hintText: 'smith@email.com'),
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return 'Email cannot be empty please enter your email address';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            email = value.toString();
                          });
                        },
                      ),
                      //password
                      TextFormField(
                        decoration:  const InputDecoration(hintText: '*****************'),
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return 'The password  cannot be empty string please enter your password';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            password = value.toString();
                          });
                        },
                        obscureText: true,
                      ),
                      //error text
                      Text(error, style: const TextStyle(color: Colors.red),),
                      //submit
                      ElevatedButton(
                          onPressed: () {
                            if(_key.currentState!.validate()){
                              //form is valid
                              //todo: login
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
                            }else{
                              //form is not valid and or we failed to sign in
                              //todo: make error message
                            }//end if-else
                          },
                          child: const Text('Submit')
                      ),
                    ],
                  )
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account, ', style: TextStyle(color: textColor),),
                TextButton(
                    onPressed: () {
                      //navigate to the sign in page
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> const SignUp())
                      );
                    }, 
                    child: const Text('Sign up', style: TextStyle(color: textColor),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
