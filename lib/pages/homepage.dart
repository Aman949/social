import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_drawer.dart';
import 'package:social/components/my_textfield.dart';
import 'package:social/components/postbtn.dart';
import 'package:social/database/firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirestoreDatabase firestore = FirestoreDatabase();
  TextEditingController newPostContoller = TextEditingController();
   
   void postMessage(){
    if(newPostContoller.text.isNotEmpty){
      String message = newPostContoller.text;
      firestore.addPost(message);
    }
    newPostContoller.clear();
   }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("P O S T"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                      hintText: "Say Something...",
                      obsecureText: false,
                      controller: newPostContoller),
                ),
                Postbtn(onTap: postMessage)
              ],
            ),
          ),
          StreamBuilder(stream: firestore.getPost(),
           builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            
            final posts = snapshot.data!.docs;
            if(snapshot.data == null || posts.isEmpty){
              return Center(child: Padding(padding: EdgeInsets.all(25),child: Text("No Posts..."),),);
            }
             
             return Expanded(child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context,index){
                final post = posts[index];
                String message = post['postMessage'];
                String userEmail = post['userEmail'];
                Timestamp timestamp = post['Timestamp'];

                return Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
                  child: ListTile(
                    title: Text(message),
                    subtitle: Text(userEmail,style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                  ),
                );
              }));
           })
        ],
      ),
    );
  }
}
