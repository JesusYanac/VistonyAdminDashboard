import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:vistony_admin_dashboard/generated/assets.dart';

import '../../core/constants.dart';
import '../../core/controllers/menu_app_controller.dart';
import '../../core/controllers/responsive.dart';
import 'bloc/navigation_bloc.dart';
import 'components/side_menu.dart';
import 'components/header.dart';
import 'trade_marketing/trade_marketing_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            const Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
          Expanded(
            // It takes 5/6 part of the screen
            flex: 5,
            child: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(defaultPadding),
                  child: ListView(
                    children: [
                      Header( searchController: searchController,),
                      const SizedBox(height: defaultPadding),
                      switch (state.index) {
                        0 => TradeMarketingScreen(searchController: searchController,),
                        _ => const PageUnderConstruction(),
                      },
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class PageUnderConstruction extends StatefulWidget {
  const PageUnderConstruction({super.key});

  @override
  State<PageUnderConstruction> createState() => _PageUnderConstructionState();
}

class _PageUnderConstructionState extends State<PageUnderConstruction> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //rive animation
        Container(
          padding: const EdgeInsets.all(42.0),
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
          child: const RiveAnimation.asset(Assets.riveAnimationsOnConsctruction,fit: BoxFit.contain,),
        ),
      ],
    );
  }
}
