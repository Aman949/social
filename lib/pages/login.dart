// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_button.dart';
import 'package:social/components/my_textfield.dart';
import 'package:social/helper/helper.dart';


class Login extends StatefulWidget {

 
   final void Function()? onTap;
  Login({super.key
  , required this.onTap
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  void login()async{
    showDialog(context: context, builder: (context)=>Center(
      child: CircularProgressIndicator(),
    ));
   try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
   if(context.mounted) Navigator.pop(context);

   }on FirebaseAuthException catch(e){
    Navigator.pop(context);
    displayMessage(e.code, context);
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              SizedBox(
                height: 25,
              ),
              //name
              Text(
                "Social",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              //email
              MyTextfield(
                  hintText: "Email",
                  obsecureText: false,
                  controller: emailcontroller),
              //password
              SizedBox(
                height: 20,
              ),
              MyTextfield(
                  hintText: "Password",
                  obsecureText: true,
                  controller: passwordcontroller)
              //forgot
              ,SizedBox(height: 15,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?",style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.secondary
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              //signin
              MyButton(text: "Log In", onTap: login),
              //donthave
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Register Here",style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
