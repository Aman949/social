import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/back_button.dart';


class Profile extends StatelessWidget {
  Profile({super.key});
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserdetails() async {
    if (currentUser != null) {
      return await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.email)
          .get();
    } else {
      throw Exception("No user signed in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserdetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            } else if (snapshot.hasData) {
              Map<String, dynamic>? user = snapshot.data!.data();
              return Center(
                child: Column(       
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:50,left: 25),
                      child: Row(
                        children: [
                          MyBackButton(),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24)
                    ),
                    padding: EdgeInsets.all(25),
                    child: Icon(Icons.person,size: 64,),
                  ),
                  SizedBox(height: 25,),
                   Text(user!['username'],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  Text(user['email'],style: TextStyle(color: Colors.grey[600]),),
                 ],
                ),
              );
            } else {
              return Text("No Data");
            }
          }),
    );
  }
}
