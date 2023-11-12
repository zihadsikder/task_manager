import 'package:flutter/material.dart';
import 'package:task_manager/screens/edit_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key, this.enableOnTap = true,
  });

  final bool enableOnTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        if (enableOnTap) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()));
        }
        },
      leading: CircleAvatar(),
      title: Text('Zihad Sikder',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
      subtitle: Text('zihadsikder.cse@gmail.com',style: TextStyle(color:Colors.white)),
      trailing: Icon(Icons.arrow_forward),
      tileColor: Colors.green,
    );
  }
}