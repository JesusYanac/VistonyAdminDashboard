import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';
import '../bloc/navigation_bloc.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Drawer(
      backgroundColor: secondaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/icons/logo_vistony_rojo.png"),
          ),
          BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              return Column(
                children: List.generate(
                  navigationBloc.titles.length,
                      (index) => DrawerListTile(
                      title: navigationBloc.titles[index]["title"],
                      svgSrc: navigationBloc.titles[index]["svgSrc"],
                      press: () {
                        navigationBloc.changeScreen(navigationBloc.titles[index]["index"]);
                      }
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}

