import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/presentation/features/dashboard/bloc/navigation_bloc.dart';

import '../../../../core/constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({super.key,
    required this.value,
    required this.total
  });

  final int value;
  final int total;

  @override
  State<StorageDetails> createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  @override
  Widget build(BuildContext context) {

    double value1 = widget.value / widget.total;
    double roundedValue1 = double.parse((value1 * 100).toStringAsFixed(1));
    double roundedValue2 = 100 - roundedValue1;
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: defaultPadding),
              PieChartForTwoValues(
                value: widget.value,
                total: widget.total,
              ),
              StorageInfoCard(
                svgSrc: "assets/icons/Documents.svg",
                title: "Visitadas",
                amountOfFiles: "$roundedValue1%",
                numOfFiles: widget.value,
              ),
              /*const StorageInfoCard(
                svgSrc: "assets/icons/media.svg",
                title: "Media Files",
                amountOfFiles: "15.3GB",
                numOfFiles: 1328,
              ),*/
              StorageInfoCard(
                svgSrc: "assets/icons/unknown.svg",
                title: "Sin Visitar",
                amountOfFiles: "$roundedValue2%",
                numOfFiles: widget.total - widget.value,
              ),
              StorageInfoCard(
                svgSrc: "assets/icons/folder.svg",
                title: "Total de Visitas",
                amountOfFiles: "100%",

                numOfFiles: widget.total,
              ),
            ],
          ),
        );
      },
    );
  }
}
