import 'package:flutter/material.dart';
import 'package:health_care/common/custom_text.dart';




class CommingSoonScreen extends StatefulWidget {
  const CommingSoonScreen({super.key});

  @override
  State<CommingSoonScreen> createState() => _CommingSoonScreenState();
}

class _CommingSoonScreenState extends State<CommingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(text: 'Coming Soon...'),
      ),
    );
  }
}
