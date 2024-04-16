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
  NavigationBloc() : super(NavigationState(0)) {
    on<ChangeScreen>((event, emit) => emit(NavigationState(event.index, titles[event.index]["title"], titles[event.index]["svgSrc"])));
  }
  void changeScreen(int index) => add(ChangeScreen(index));

  List<Map<String, dynamic>> getTitles() => titles;
}

class NavigationEvent {
  int index;
  NavigationEvent(this.index);
}

class ChangeScreen extends NavigationEvent {
  ChangeScreen(super.index);
}

class NavigationState {
  int index;
  String title;
  String svgSrc;
  NavigationState(this.index, [this.title = "Trade Marketing", this.svgSrc = Assets.iconsMenuDashboard]);
}