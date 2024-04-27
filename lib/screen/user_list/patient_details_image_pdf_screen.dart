import 'package:flutter/material.dart';
import 'package:health_care/common/app_bar.dart';

class PatientDetailsImagePdfScreen extends StatefulWidget {
  final type,file;
  const PatientDetailsImagePdfScreen({super.key,this.type,this.file});

  @override
  State<PatientDetailsImagePdfScreen> createState() => _PatientDetailsImagePdfScreenState();
}

class _PatientDetailsImagePdfScreenState extends State<PatientDetailsImagePdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Details'),
      body: widget.type=="png"||widget.type=="jpg"?imageWidget():Container()
    );
  }



  Widget imageWidget(){
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(image: NetworkImage(widget.file.toString()),fit: BoxFit.cover)
      ),
    );
  }
}
