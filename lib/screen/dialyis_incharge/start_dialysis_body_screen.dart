import 'package:flutter/material.dart';

import '../../common/app_bar.dart';

class StartDialysisBodyScreen extends StatefulWidget {
  const StartDialysisBodyScreen({super.key});

  @override
  State<StartDialysisBodyScreen> createState() => _StartDialysisBodyScreenState();
}

class _StartDialysisBodyScreenState extends State<StartDialysisBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Start Dialysis'),
    );
  }
}
