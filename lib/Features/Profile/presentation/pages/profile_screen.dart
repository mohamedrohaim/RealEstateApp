import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:realestate/Features/Explore/domain/entities/recent_entity.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/pages/details_screen.dart';
import 'package:realestate/Features/Explore/presentation/widgets/card_widget.dart';
import 'package:realestate/Features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:realestate/Features/Profile/presentation/widgets/app_bar_profile_screen.dart';
import 'package:realestate/Features/Profile/presentation/widgets/appoints_widget.dart';

import 'package:realestate/Features/Profile/presentation/widgets/recent_view_widgt.dart';
import 'package:realestate/Features/Profile/presentation/widgets/recent_widget.dart';
import 'package:realestate/Features/Profile/presentation/widgets/rounded_button.dart';
import 'package:realestate/Features/Profile/presentation/widgets/rounded_image.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/injection_container.dart' as di;
import 'package:realestate/main.dart';
import 'package:realestate/objectbox.g.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String city;

  const ProfileScreen({super.key, required this.name, required this.city});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Box<RecentEntity>? taskBox;
  Stream<List<RecentEntity>>? fetchAllTaske;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskBox = objectBox.store.box<RecentEntity>();
    print(taskBox!.count());
    setState(() {
      fetchAllTaske = taskBox!
          .query()
          .watch(triggerImmediately: true)
          .map((event) => event.find());
    });
  }

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: "token");
    var userId = CacheHelper.getData(key: 'UserID');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    log(token);
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        children: [
          const AppBarProfileScreen(),
          const RoundedImage(),
          Text(
            decodedToken['sub'][1],
            style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "Egypt, Benisufe",
            style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          verticalSpace(10),
          const RoundedButton(),
          DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: TabBar(
                    labelColor: AppColor.primaryColor,
                    unselectedLabelColor: AppColor.secondColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) {
                      if (index == 1) {
                        taskBox = objectBox.store.box<RecentEntity>();
                        setState(() {
                          fetchAllTaske = taskBox!
                              .query()
                              .watch(triggerImmediately: true)
                              .map((event) => event.find());
                        });
                      }
                      taskBox = objectBox.store.box<RecentEntity>();
                      setState(() {
                        fetchAllTaske = taskBox!
                            .query()
                            .watch(triggerImmediately: true)
                            .map((event) => event.find());
                      });
                    },
                    tabs: const [
                      Tab(
                        text: 'Recent view',
                      ),
                      Tab(
                        text: 'Appointments',
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 380,
                  child: TabBarView(children: [
                    StreamBuilder<List<RecentEntity>>(
                        stream: fetchAllTaske,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            log(snapshot.data!.length.toString());
                            return SingleChildScrollView(
                              child: Column(
                                children: snapshot.data!
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(context,MaterialPageRoute(builder: (context)=>DetialsScreen(id: e.uitId)));
                                            },
                                            child: RecentView(
                                              recentEntity: e,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                          return const CireProgressIndecatorWidget();
                        }),
                    //RecentView(),
                    BlocProvider(
                      create: (context) =>
                          di.sl<ProfileCubit>()..getAppointment(userId),
                      child: BlocConsumer<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                        return BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            if (state is GetAppointmentIsSucces) {
                              // DateTime dateTime = DateTime.now();

                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetialsScreen(
                                                      id: state
                                                          .appointmnets[index]
                                                          .unitId!
                                                          .toInt())));
                                    },
                                    child: AppointmentsWidgets(
                                        date: state
                                            .appointmnets[index].scheduleDate
                                            .toString()),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: state.appointmnets.length,
                              );
                            }
                            return const CireProgressIndecatorWidget();
                          },
                        );
                      }, listener: (context, state) {
                        if (state is GetAppointmentIsError) {
                          log(state.error.toString());
                          //   log(state.error.toString);
                        }
                      }),
                    )
                    // const Center(
                    //     child: Text(
                    //   "SOON",
                    //   style: TextStyle(color: Colors.red, fontSize: 24),
                    // ))
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
