import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/pages/homepage.dart';
import 'package:social/pages/profile.dart';
import 'package:social/pages/users.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
   void logout(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            DrawerHeader(child: Icon(Icons.favorite)),
          SizedBox(height: 50,),
            Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(Icons.home,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text("H O M E"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(Icons.person,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text("P R O F I L E"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>Profile()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(Icons.group,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text("U S E R S"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Users()));
              },
            ),
          ),
          ],),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.inversePrimary,),
              title: Text("L O G O U T"),
              onTap: () {
                logout();
              },
            ),
          )
        
          ],
      ),
    );
  }
}
