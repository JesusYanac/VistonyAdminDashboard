import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../../../../data/model/trade_marketing_model.dart';
import '../../../../../generated/assets.dart';
import '../../../../core/constants.dart';
import '../../../../core/controllers/responsive.dart';
import '../bloc/trade_marketing_bloc.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    super.key,
    required this.callback,
    required this.headers,
    required this.searchText,
    required this.updateHeaders,
    required this.updateSearchText,
  });

  final Map<String, bool> headers;
  final String searchText;
  final Function updateHeaders;
  final Function updateSearchText;

  final Function callback;

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {

  late Map<String, bool> headers;
  late String searchText;

  @override
  void initState() {
    headers = widget.headers;
    searchText = widget.searchText;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RecentFiles oldWidget) {
    if(widget.headers != headers || widget.searchText != searchText) {
      setState(() {
        headers = widget.headers;
        searchText = widget.searchText;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24.0),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Archivos Recientes",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: primaryColor,
                    ),
              ),
              BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
                builder: (context, state) {
                  final count = state is SuccessTradeMarketingState
                      ? state.datafiltered?.length ?? 0
                      : 0;
                  return Text(
                    "Total: $count",
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                },
              )
            ],
          ),
        ),
        Expanded(
          flex: 35,
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<TradeMarketingBloc>(context)
                  .filterByDateTradeMarketing(
                DateTime.now().toString().split(" ").first,
                DateTime.now().toString().split(" ").first,
              );

              setState(() {
                // limpiar header
                headers.forEach((key, value) {
                  headers[key] = false;
                });
                headers["Fecha"] = true;
              });

              widget.updateHeaders(headers);
              widget.updateSearchText("");
            },
            child: Text(
              "Hoy",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
      builder: (context, state) {
        if (state is SuccessTradeMarketingState) {
          return Column(
            children: [
              _buildTableHeader(context),
              _buildTableBody(context, state.datafiltered!),
            ],
          );
        } else if (state is LoadingTradeMarketingState) {
          return _buildLoadingAnimation(context);
        } else {
          return _buildErrorAnimation(context);
        }
      },
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: headers.keys.map((header) {
          return (header == "N°" ||
                  header == "DOC" ||
                  header == "Sucursal" ||
                  header == "Fecha")
              ? TableHeaderCell(
                  header: header,
                  isActive: headers[header]!,
                  callback: setHeader,
                )
              : Expanded(
                  child: TableHeaderCell(
                    header: header,
                    isActive: headers[header]!,
                    callback: setHeader,
                  ),
                );
        }).toList(),
      ),
    );
  }

  Widget _buildTableBody(
      BuildContext context, List<TradeMarketingHeader> data) {
    return Container(
      height: MediaQuery.of(context).size.height - 294,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: ListView.builder(
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return recentFileDataRow(data[index], "${index + 1}");
        },
      ),
    );
  }

  Widget _buildLoadingAnimation(BuildContext context) {
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorAnimation(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.35,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          height: MediaQuery.of(context).size.width * 0.20,
          child: const RiveAnimation.asset(
            Assets.riveAnimationsAlien404Screen,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget recentFileDataRow(TradeMarketingHeader fileInfo, String index) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (kIsWeb)
            SizedBox(
              width: 40.0,
              child: CustomRawTableText(
                text: index,
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(
            width: 120,
            child: CustomRawTableText(
              text: fileInfo.sucursal ?? "",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CustomRawTableText(text: fileInfo.vendedor ?? ""),
          ),
          Expanded(
            child: CustomRawTableText(text: fileInfo.cliente ?? ""),
          ),
          Expanded(
            child: CustomRawTableText(text: fileInfo.direccion ?? ""),
          ),
          SizedBox(
            width: 85,
            child: CustomRawTableText(
              text: fileInfo.fecha ?? "",
              textAlign: TextAlign.left,
            ),
          ),
          if (kIsWeb)
            SizedBox(
              width: 40.0,
              child: InkWell(
                onTap: () {
                  widget.callback(
                      fileInfo.docEntry, fileInfo.vendedor, fileInfo.direccion);
                },
                child: SvgPicture.asset(
                  Assets.iconsDocFile,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void setHeader(String header) {

    widget.updateSearchText("");
    setState(() {
      // solo true el header actual
      headers.forEach((key, value) {
        if (key == header) {
          headers[key] = true;
          BlocProvider.of<TradeMarketingBloc>(context).setFilter(header);
          BlocProvider.of<TradeMarketingBloc>(context).filterTradeMarketing("");
        } else {
          headers[key] = false;
        }
      });
    });
  }
}

class CustomRawTableText extends StatelessWidget {
  const CustomRawTableText({super.key, required this.text, this.textAlign});
  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      kIsWeb ? text : text.toLowerCase(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: kIsWeb ? 12 : 10,
          ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}

class TableHeaderCell extends StatefulWidget {
  const TableHeaderCell({
    super.key,
    required this.header,
    required this.isActive,
    required this.callback,
  });

  final String header;
  final bool isActive;
  final Function callback;

  @override
  State<TableHeaderCell> createState() => _TableHeaderCellState();
}

class _TableHeaderCellState extends State<TableHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!(widget.header == "N°" ||
            widget.header == "DOC" ||
            widget.header == "Fecha"))
          Checkbox(
            value: widget.isActive,
            onChanged: (value) {
              widget.callback(widget.header);
            },
          ),
        _buildHeaderContainer(context),
      ],
    );
  }

  Widget _buildHeaderContainer(BuildContext context) {
    double width;
    if (widget.header == "N°" || widget.header == "DOC") {
      width = 40;
    } else if (widget.header == "Sucursal") {
      width = 80;
    } else if (widget.header == "Fecha") {
      width = 80;
    } else {
      return Expanded(
        child: _buildHeaderText(context),
      );
    }

    return Container(
      width: width,
      child: _buildHeaderText(context),
    );
  }

  Widget _buildHeaderText(BuildContext context) {
    return Text(
      widget.header.toUpperCase(),
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: Responsive.isMobile(context)
                ? 10
                : Responsive.isTablet(context)
                    ? 12
                    : 14,
            overflow: TextOverflow.ellipsis,
            color: widget.header == "Fecha"
                ? Colors.white
                : widget.isActive
                    ? Colors.white
                    : Colors.black,
          ),
    );
  }
}
