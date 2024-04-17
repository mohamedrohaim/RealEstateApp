import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({super.key,required this.errormessage,});
  final String errormessage;
  @override
  Widget build(BuildContext context) {
    return  Text(errormessage,style: TextStyle(color: Colors.red,fontSize: 15),);
  }
}