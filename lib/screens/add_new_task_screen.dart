import 'package:flutter/material.dart';
import 'package:task_manager/widget/profile_summary_card.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(),
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0,),
                    Text('Add New Task', style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'subject'
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'subject'
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: (){}, child: Text('Add')),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
