import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

import '../../../../../data/model/trade_marketing_model.dart';
import '../../../../../generated/assets.dart';
import '../../../../core/constants.dart';
import '../bloc/trade_marketing_bloc.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({super.key, required this.callback});

  final Function callback;

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  final List<String> headers = [
    "N°",
    "Cliente",
    "Vendedor",
    "Fecha",
    "Dirección",
    " "
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
          Row(
            children: [
              Expanded(
                flex: 65,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Archivos Recientes",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: primaryColor,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
                          builder: (context, state) {
                            if (state is SuccessTradeMarketingState) {
                              return Text(
                                "Total: ${state.datafiltered?.length}",
                                style: Theme.of(context).textTheme.titleMedium,
                              );
                            } else {
                              return Text(
                                "Total: 0",
                                style: Theme.of(context).textTheme.titleMedium,
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 35,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<TradeMarketingBloc>(context)
                        .reloadTradeMarketing();
                  },
                  child: Text(
                    "Hoy",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 24.0),
          BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
            builder: (context, state) {
              if (state is SuccessTradeMarketingState) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: List.generate(
                            headers.length,
                            (index) {
                              return (headers[index].toLowerCase() == "fecha")
                                  ? Container(
                                color: Colors.transparent,
                                width: 120,
                                child: Text(
                                  headers[index].toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                              ):(headers[index] == "N°" || headers[index].toLowerCase() == " ")?
                              Container(
                                width: 60,
                                color: Colors.transparent,
                                child: Text(
                                  headers[index],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                              ): Expanded(
                                      child: Text(
                                        headers[index].toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                      Column(
                        children: List.generate(
                          state.datafiltered!.length,
                          (index) => recentFileDataRow(
                              state.datafiltered![index], "${index+1}"),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is LoadingTradeMarketingState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.width * 0.35,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.20,
                            child: const RiveAnimation.asset(
                              Assets.riveAnimationsEparLoading,
                              fit: BoxFit.contain,
                            )),
                      ],
                    ),
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      child: const RiveAnimation.asset(
                        Assets.riveAnimationsAlien404Screen,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget recentFileDataRow(TradeMarketingHeader fileInfo, index) {
    return Container(
      decoration: BoxDecoration(
        color: (int.parse(index) % 2 == 0) ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          SizedBox(
            width: 60.0,
            child: CustomRawTableText(
              text: index,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CustomRawTableText(text: fileInfo.cardName??""),
          ),
          Expanded(
            child: CustomRawTableText(text: fileInfo.vendedor??""),
          ),
          SizedBox(
            width: 120.0,
            child: CustomRawTableText(
              text: ("${fileInfo.dateCreate}"!="")?DateFormat("dd/MM/yyyy").format(DateTime.parse(fileInfo.dateCreate!)):"",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CustomRawTableText(text: fileInfo.direccion??""),
          ),
          Container(
            width: 60.0,
              child: InkWell(
            onTap: () {
              widget.callback(
                  fileInfo.docEntry!, fileInfo.vendedor, fileInfo.direccion);
            },
            child: SvgPicture.asset(
              Assets.iconsDocFile,
              height: 30,
              width: 30,
            ),
          )),
        ],
      ),
    );
  }
}

class CustomRawTableText extends StatelessWidget {
  const CustomRawTableText({super.key, required this.text, this.textAlign});
  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
