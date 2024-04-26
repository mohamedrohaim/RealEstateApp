// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
// import 'package:realestate/Features/Profile/presentation/widgets/build_recent_view_item.dart';
// import 'package:realestate/core/widgets/circle_progress_widget.dart';
// import 'package:realestate/injection_container.dart' as di;
// import 'package:sqflite/sqflite.dart';

// class RecentView extends StatefulWidget {
//   const RecentView({super.key});

//   @override
//   State<RecentView> createState() => _RecentViewState();
// }

// class _RecentViewState extends State<RecentView> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GetUnitCubit, GetUnitState>(builder: (context, state) {
//             var recentview = BlocProvider.of<GetUnitCubit>(context).recentView;
//             log(recentview.length.toString());
//           //  log(recentview.first.toString());
//             return reventviewBuilder(recent: recentview);
//           }, listener: (context, state) {
//             if (state is AppGetDatabaseState) {
//     log(state.recentViwe.first.toString());
//             }
//           });
//   }
// }
