import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:vistony_admin_dashboard/data/model/trade_marketing_model.dart';
import 'package:vistony_admin_dashboard/generated/assets.dart';

import '../../../../core/constants.dart';
import '../bloc/trade_marketing_bloc.dart';


class RecentFiles extends StatefulWidget {
  const RecentFiles({
    super.key,
  });

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  final List<String> headers = [
    "",
    "Vendedor",
    "Cliente",
    "Fecha",
    "Dirección",
  ];
  @override
  Widget build(BuildContext context) {
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
            "Archivos Recientes",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
            builder: (context, state) {
              if (state is SuccessTradeMarketingState) {
                return Text("Total: ${state.data?.length}");
              } else {
                return const Text("Total: 0");
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<TradeMarketingBloc>(context).reloadTradeMarketing();
            },
            child: const Text("Cargar datos"),
          ),
          BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
            builder: (context, state) {
              if (state is SuccessTradeMarketingState) {
                return SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columns: headers
                        .map((header) => DataColumn(
                              label: Text(
                                header,
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ))
                        .toList(),
                    rows: List.generate(
                      state.data!.length,
                          (index) => recentFileDataRow(state.data![index]),
                    ),
                  ),
                );
              } else {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 200, height: 200, child: RiveAnimation.asset(Assets.riveAnimationsEparLoading,fit: BoxFit.contain,)),
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(TradeMarketingPageModel fileInfo) {
  return DataRow(
    cells: [
      DataCell(SvgPicture.asset(
        Assets.iconsDocFile,
        height: 30,
        width: 30,
      )),
      DataCell(Text("${fileInfo.cardName}",
          maxLines: 2, overflow: TextOverflow.ellipsis)),

      DataCell(Text("${fileInfo.cardName}",
          maxLines: 2, overflow: TextOverflow.ellipsis)),
      DataCell(Text(fileInfo.dateCreation!)),
      DataCell(Text("${fileInfo.cardCode}",
          maxLines: 2, overflow: TextOverflow.ellipsis)),
    ],
  );
}
