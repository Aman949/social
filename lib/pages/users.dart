import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social/components/back_button.dart';
import 'package:social/components/my_drawer.dart';
import 'package:social/helper/helper.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              displayMessage("Something went wrong", context);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.data == null){
             return Text("No Data");
            }

            final users = snapshot.data!.docs;
            return Column(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context,index){
                      final user = users[index];
                      return ListTile(
                        title: Text(user['username']),
                        subtitle: Text(user['email']),
                      );
                    }),
                ),
              ],
            );
          }),
    );
  }
}
