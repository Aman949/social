import 'package:flutter/material.dart';

class MyBackButton extends StatefulWidget {
  const MyBackButton({super.key});

  @override
  State<MyBackButton> createState() => _MyBackButtonState();
}

class _MyBackButtonState extends State<MyBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle
        ),
        padding: EdgeInsets.all(10),
        child: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.inversePrimary,),
      ),
    );
  }
}