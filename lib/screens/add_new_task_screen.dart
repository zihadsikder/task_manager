import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/add_new_task_screen_controller.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/widget/body_background.dart';
import 'package:task_manager/widget/profile_summary_card.dart';
import 'package:task_manager/widget/snack_messege.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewTaskScreenController _addNewTaskScreenController = Get.find<AddNewTaskScreenController>();
  bool _createTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32,),
                          Text('Add New Task', style: Theme.of(context).textTheme.titleLarge,),
                          const SizedBox(height: 16,),
                          TextFormField(
                            controller: _subjectTEController,
                            decoration: const InputDecoration(
                                hintText: 'Subject'
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8,),
                          TextFormField(
                            controller: _descriptionTEController,
                            maxLines: 8,
                            decoration: const InputDecoration(
                                hintText: 'Description'
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<AddNewTaskScreenController>(
                              builder: (_addNewTaskScreenController) {
                                return Visibility(
                                  visible: _addNewTaskScreenController.createTaskInProgress == false,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: createTask,
                                    child: const Icon(Icons.arrow_circle_right_outlined),
                                  ),
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async {
    // if (_formKey.currentState!.validate()) {
    //   return;
    // }
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status": "New"
      });
      if (response.isSuccess) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if (mounted) {
          showSnackMessage(context, 'New task added!');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Create new task failed! Try again.', true);
        }
      }
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
    super.dispose();
  }
}