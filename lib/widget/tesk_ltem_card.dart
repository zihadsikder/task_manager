import 'package:flutter/material.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('World University Of Bangladesh', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500
            ),),
            Text('Description'),
            Text('Date : 01.11.2023'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text('New',style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.green,
                ),
                Wrap(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline_sharp)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}