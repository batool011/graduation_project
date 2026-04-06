import 'package:career/features/tasks/presentation/widget/custom_card_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.task.tr,)),
      body: Column(
        children: [

       Expanded(
          child: ListView.builder(itemBuilder: (context,index){
               return CustomTaskCard(title: 'title', description: 'description', assignedBy: 'assignedBy', startDate: 'startDate', endDate: 'endDate');
          }
           ),
          )
        ],
      ),
    );
  }
}
