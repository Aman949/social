import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_button.dart';
import 'package:social/components/my_textfield.dart';
import 'package:social/helper/helper.dart';

class SignupPage extends StatefulWidget {
  final void Function()? onTap;

  SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController confirmpasswordcontroller = TextEditingController();

  TextEditingController usercontroller = TextEditingController();

  void signup() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      Navigator.pop(context);
      displayMessage("Passwords dont match!", context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text);

        createUserDocument(userCredential);        
           if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessage(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential)async{
    if(userCredential!=null && userCredential.user !=null){
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set({
         'email':userCredential.user!.email,
         'username':usercontroller.text,
      });
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              MyTextfield(
                  hintText: "Username",
                  obsecureText: false,
                  controller: usercontroller),
              //password
              SizedBox(
                height: 20,
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
              ,
              SizedBox(
                height: 20,
              ),
              MyTextfield(
                  hintText: "Confirm Password",
                  obsecureText: true,
                  controller: confirmpasswordcontroller),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //signin
              MyButton(text: "Sign Up", onTap: signup),
              //donthave
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Sign In Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
