import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/Features/Explore/presentation/widgets/card_widget.dart';
import 'package:realestate/Features/Explore/presentation/widgets/house_category.dart';
import 'package:realestate/Features/Explore/presentation/widgets/swipper_card.dart';
import 'package:realestate/Features/Explore/presentation/widgets/viall_category.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';


class ExplorScreen extends StatefulWidget {
  const ExplorScreen({super.key});

  @override
  State<ExplorScreen> createState() => _ExplorScreenState();
}

class _ExplorScreenState extends State<ExplorScreen> {
  var searchController = TextEditingController();
//var tabController=TabController(length: 4,vsync: (){});
    int _selectedIndex = 0;
      void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                hintText: "Search real estata",
                leading: Icon(Icons.search),
              ),
            ),  
            verticalSpace(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwipperCard(
                size: size,
              ),
            ),
            verticalSpace(10),
            DefaultTabController(
              length: 4, child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: TabBar(
                    labelColor: AppColor.whiteColor,
                    unselectedLabelColor: AppColor.secondColor,
                    indicatorSize:TabBarIndicatorSize.tab ,
                    indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), // Creates border
                  color: AppColor.primaryColor),
                    onTap:(index){},
                    tabs:const  [
                         Tab(text: 'All',),
                      Tab(text: 'House'),
                      Tab(text:'Villa'),
                      Tab(text: 'Apartment',)
                  ],),
                ),
                Container(
                  height:370,
                  child: TabBarView(children:[
                    CardListView(),
                   HouseListView(),
                    VillaListView(),
                   // VillaWidget()
                     CardListView(),
                     //CardListView(),
                  ] ),
                ),
              ],
              ),
              ),
         ],
        ),
      ),
    );
  }
}
