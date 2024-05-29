import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/Features/Explore/domain/entities/recent_entity.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/titles_text_widget.dart';
import 'package:realestate/objectbox.g.dart';

class RecentView extends StatefulWidget {
  RecentEntity recentEntity;
   RecentView({super.key,required this.recentEntity});

  @override
  State<RecentView> createState() => _RecentViewState();
}

class _RecentViewState extends State<RecentView> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(20),child: Image(image: NetworkImage(widget.recentEntity.image.toString()),height: 100,fit: BoxFit.contain,)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitlesTextWidget(label: widget.recentEntity.tite.toString().split(' ').take(4).join(' '),fontSize: 12,),
                  TitlesTextWidget(label: widget.recentEntity.price.toString(),fontSize:13),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
