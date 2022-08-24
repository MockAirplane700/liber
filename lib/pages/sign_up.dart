import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/pages/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _key = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up', style: TextStyle(color: textColor),),
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
                      //first name
                      TextFormField(
                        decoration:  const InputDecoration(hintText: 'First name'),
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return 'First name cannot be empty please enter your first name';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            firstName = value.toString();
                          });
                        },
                      ),
                      //last name
                      TextFormField(
                        decoration:  const InputDecoration(hintText: 'Last name'),
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return 'Last name cannot be empty please enter your last name';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            lastName = value.toString();
                          });
                        },
                      ),
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
                        decoration:  const InputDecoration(hintText: '**************'),
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return 'The password cannot be empty string please enter your desired password';
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
                      Text(error, style: const TextStyle(color: Colors.red),),
                      //submit
                      ElevatedButton(
                          onPressed: () {
                            if(_key.currentState!.validate()){
                              //form is valid
                              //todo: login
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
                const Text('Already have an account? ', style: TextStyle(color: textColor),),
                TextButton(
                    onPressed: () {
                      //Navigate to relevant page
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> const Login())
                      );
                    },
                    child: const Text('Login', style: TextStyle(color: textColor),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
