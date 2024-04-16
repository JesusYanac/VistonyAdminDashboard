import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistony_admin_dashboard/presentation/features/dashboard/trade_marketing/trade_marketing_screen.dart';

import '../../core/constants.dart';
import '../../core/controllers/menu_app_controller.dart';
import '../../core/controllers/responsive.dart';
import 'components/side_menu.dart';
import 'components/header.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: ListView(
                        children: const [
                          Header(),
                          SizedBox(height: defaultPadding),
                          TradeMarketingScreen()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
