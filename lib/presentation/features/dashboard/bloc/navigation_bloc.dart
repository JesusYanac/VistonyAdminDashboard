import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  List<Map<String, dynamic>> titles = [
    {"title": "Trade Marketing", "svgSrc": Assets.iconsMenuDashboard, "index": 0},
    {"title": "Transaction", "svgSrc": Assets.iconsMenuTran, "index": 1},
    {"title": "Task", "svgSrc": Assets.iconsMenuTask, "index": 2},
    {"title": "Documents", "svgSrc": Assets.iconsMenuDoc, "index": 3},
    {"title": "Store", "svgSrc": Assets.iconsMenuStore, "index": 4},
    {"title": "Notification", "svgSrc": Assets.iconsMenuNotification, "index": 5},
    {"title": "Profile", "svgSrc": Assets.iconsMenuProfile, "index": 6},
    {"title": "Settings", "svgSrc": Assets.iconsMenuSetting, "index": 7},
  ];
  NavigationBloc() : super(NavigationState(
    title: "Trade Marketing",
    svgSrc: Assets.iconsMenuDashboard,
    index: 0,
    isSearchBoxVisible: true
  )) {
    on<ChangeScreen>((event, emit) => emit(NavigationState(
      index: event.index,
      title: titles[event.index]["title"],
      svgSrc: titles[event.index]["svgSrc"],
      isSearchBoxVisible: event.isSearchBoxVisible
    )));
    on<UpdateSearchBoxVisibility>((event, emit) => emit(NavigationState(
      index: event.index,
      title: titles[event.index]["title"],
      svgSrc: titles[event.index]["svgSrc"],
      isSearchBoxVisible: event.isSearchBoxVisible
    )));
  }
  void changeScreen(int index) => add(ChangeScreen(
    index: index,
    isSearchBoxVisible: true
  ));
  void updateSearchBoxVisibility(int index, bool isVisible) => add(UpdateSearchBoxVisibility(
    index: index,
    isSearchBoxVisible: isVisible
  ));

  List<Map<String, dynamic>> getTitles() => titles;
}

class NavigationEvent {
  int index;
  bool isSearchBoxVisible;
  NavigationEvent({required this.index, required this.isSearchBoxVisible});
}

class ChangeScreen extends NavigationEvent {

  ChangeScreen({required super.index, required super.isSearchBoxVisible});
}

class UpdateSearchBoxVisibility extends NavigationEvent {
  UpdateSearchBoxVisibility({required super.index, required super.isSearchBoxVisible});
}

class NavigationState {
  int index;
  String title;
  String svgSrc;
  bool isSearchBoxVisible;

  NavigationState({
    required this.index,
    required this.title,
    required this.svgSrc,
    required this.isSearchBoxVisible
  });
}