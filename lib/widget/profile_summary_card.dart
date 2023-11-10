import 'package:flutter/material.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text('Zihad Sikder',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
      subtitle: Text('zihadsikder.cse@gmail.com',style: TextStyle(color:Colors.white)),
      trailing: Icon(Icons.arrow_forward),
      tileColor: Colors.green,
    );
  }
}