import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/presentation/features/dashboard/bloc/navigation_bloc.dart';

import '../../../../core/constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({super.key});

  @override
  State<StorageDetails> createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  @override
  Widget build(BuildContext context) {
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
              const Chart(),
              const StorageInfoCard(
                svgSrc: "assets/icons/Documents.svg",
                title: "Documents Files",
                amountOfFiles: "1.3GB",
                numOfFiles: 1328,
              ),
              const StorageInfoCard(
                svgSrc: "assets/icons/media.svg",
                title: "Media Files",
                amountOfFiles: "15.3GB",
                numOfFiles: 1328,
              ),
              const StorageInfoCard(
                svgSrc: "assets/icons/folder.svg",
                title: "Other Files",
                amountOfFiles: "1.3GB",
                numOfFiles: 1328,
              ),
              const StorageInfoCard(
                svgSrc: "assets/icons/unknown.svg",
                title: "Unknown",
                amountOfFiles: "1.3GB",
                numOfFiles: 140,
              ),
            ],
          ),
        );
      },
    );
  }
}
