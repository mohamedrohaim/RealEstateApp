import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          image:const  DecorationImage(image: NetworkImage('https://i.pinimg.com/236x/cf/9b/8d/cf9b8d7501016b56d552e154e096b46e.jpg')),
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          border: Border.all(
              color: Theme.of(context).colorScheme.background, width: 3)),
    );
  }
}
