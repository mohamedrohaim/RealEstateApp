import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/presentation/pages/explore_screen.dart';
import 'package:realestate/Features/Favorites/presentation/pages/favoirtes_screen.dart';
import 'package:realestate/Features/Profile/presentation/pages/profile_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
    static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Explore'),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoirt'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Acount'),
  ];
  List<Widget> screens = [
    ExplorScreen(),
    FavoirtScreen(),
    ProfileScreen(name: 'name', city: ''),
  ];
  void changeBottomNave(int index) {
    currentIndex = index;
    if (index == 1) {
      ExplorScreen();
    }
    if (index == 2) {
      FavoirtScreen();
    }
    if (index == 3) {
      ProfileScreen(name: 'name', city: '');
    }
    //emit(NewsBottomNave());
  }
}
