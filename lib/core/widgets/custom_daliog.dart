import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.onPresed,required this.alretTitle});
  final VoidCallback onPresed;
  final String alretTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Note That'),
      content: Text(alretTitle,style: TextStyle(fontSize: 14.sp),),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: onPresed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
