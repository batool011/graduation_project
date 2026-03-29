import 'package:career/core/widget/base_container.dart';
import 'package:flutter/material.dart';

class AboutPositionWidget extends StatelessWidget {
  const AboutPositionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BaseContainer(title: "Job Description", body: "In a UX Designer job, you'll need both types of skills to develop the next generation of products. You'll partner with Researchers and Designers to define and deliver new features.",),
        BaseContainer(title: "Job Description", body: "In a UX Designer job, you'll need both types of skills to develop the next generation of products. You'll partner with Researchers and Designers to define and deliver new features.",),
        BaseContainer(title: "Job Description", body: "In a UX Designer job, you'll need both types of skills to develop the next generation of products. You'll partner with Researchers and Designers to define and deliver new features.",),
      ],
    );
  }
}
