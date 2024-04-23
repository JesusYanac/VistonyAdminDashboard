import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/controllers/menu_app_controller.dart';
import '../../../core/controllers/responsive.dart';
import '../../auth/Welcome/welcome_screen.dart';
import '../bloc/navigation_bloc.dart';
import '../trade_marketing/bloc/trade_marketing_bloc.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state)  {
        return Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: context.read<MenuAppController>().controlMenu,
              ),
            if (!Responsive.isMobile(context))
              Text(
                state.title.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            if (state.isSearchBoxVisible) const Expanded(child: SearchField()),
            const ProfileCard()
          ],
        );
      }
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(-8, 70),
      icon: Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              height: 38,
              width: 38,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(38),
              ),
              child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(Icons.person, color: Colors.white)),
            ),
            if (!Responsive.isMobile(context))
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("Anonimo"),
              ),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.white),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.exit_to_app, color: Colors.black),
              SizedBox(width: 10),
              Text('Cerrar sesión'),
            ],
          ),
        ),
      ],
      onSelected: (String value) {
        if (value == 'logout') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const WelcomeScreen();
              },
            ),
          );
        }
      },
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController fini = TextEditingController();
  final TextEditingController ffin = TextEditingController();
  @override
  void initState() {
    fini.text = "${DateTime.now().toLocal()}".split(' ')[0];
    ffin.text = "${DateTime.now().toLocal()}".split(' ')[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Buscar...",
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {
            _showDateRangeDialog(context, (fini, ffin) {
              BlocProvider.of<TradeMarketingBloc>(context)
                  .filterByDateTradeMarketing(fini,ffin);
            });
          },
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(Icons.calendar_month_outlined, color: Colors.white),
          ),
        ),
      ),
      onChanged: (value) {
        BlocProvider.of<TradeMarketingBloc>(context).filterTradeMarketing(value);
      },
    );
  }

  void _showDateRangeDialog(BuildContext context, Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text('Seleccionar rango de fechas',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: primaryColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              // label fecha inicio
              const Text('Fecha de inicio:',
                  style: TextStyle(color: primaryColor)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: bgColor),
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelStyle: TextStyle(color: primaryColor)),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      fini.text = "${selectedDate.toLocal()}".split(' ')[0];
                    }
                  },
                  readOnly: true,
                  controller: fini,
                ),
              ),
              const SizedBox(height: 10),
              // label fecha fin
              const Text('Fecha fin:', style: TextStyle(color: primaryColor)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: bgColor),
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelStyle: TextStyle(color: primaryColor)),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      ffin.text = "${selectedDate.toLocal()}".split(' ')[0];
                    }
                  },
                  readOnly: true,
                  controller: ffin,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            Container(
              color: primaryColor,
              child: TextButton(
                onPressed: () {
                  callback(fini.text, ffin.text);
                  // Agregar lógica para guardar las fechas seleccionadas
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: const Text('Guardar',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}
