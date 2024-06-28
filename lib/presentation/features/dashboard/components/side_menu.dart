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
                      isSelected: navigationBloc.titles[index]["index"] == state.index,
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

class DrawerListTile extends StatefulWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
    this.isSelected = false, // Nuevo atributo para indicar si está seleccionado
  });

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected; // Indica si está seleccionado

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        widget.svgSrc,
        colorFilter: widget.isSelected // Aplica filtro de color si está seleccionado
            ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
            : const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: widget.isSelected ? Colors.white : Colors.white54, // Cambia el color del texto si está seleccionado
          fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal, // Cambia el peso de la fuente si está seleccionado
        ),
      ),
    );
  }
}


