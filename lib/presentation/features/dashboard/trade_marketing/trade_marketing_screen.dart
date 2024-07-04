import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/controllers/responsive.dart';
import '../bloc/navigation_bloc.dart';
import 'bloc/form_trade_marketing_bloc.dart';
import 'bloc/trade_marketing_bloc.dart';
import 'components/my_fields.dart';
import 'components/storage_details.dart';
import 'file_selected.dart';
import 'components/recent_files.dart';

class TradeMarketingScreen extends StatefulWidget {
  const TradeMarketingScreen({super.key
  , required this.searchController});
  final TextEditingController searchController;
  @override
  State<TradeMarketingScreen> createState() => _TradeMarketingScreenState();
}

class _TradeMarketingScreenState extends State<TradeMarketingScreen> {
  String codeForm = "";
  String vendorName = "";
  String clientAddress = "";
  final Map<String, bool> headers = {
    "N°": false,
    "Sucursal": false,
    "Vendedor": false,
    "Cliente": false,
    "Dirección": false,
    "Fecha": true,
    "DOC": false,
  };
  @override
  Widget build(BuildContext context) {
    if (codeForm == "") {
      BlocProvider.of<NavigationBloc>(context)
          .updateSearchBoxVisibility(0, true);
    } else {
      BlocProvider.of<NavigationBloc>(context)
          .updateSearchBoxVisibility(0, false);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              MyFiles(
                  headers: headers,
                  searchText: widget.searchController.text,
                  updateHeaders: (header) {
                    setState(() {
                      headers[header] = true;
                      widget.searchController.text = "";
                    });
                  },
                  updateSearchText: (text) {
                    setState(() {
                      widget.searchController.text = text;
                    });
                  }),
              const SizedBox(height: defaultPadding),
              if (codeForm == "")
                RecentFiles(
                    callback: (code, vendor, address) {
                      setState(() {
                        codeForm = code;
                        vendorName = vendor;
                        clientAddress = address;
                      });
                    },
                    headers: headers,
                    searchText: widget.searchController.text,
                    updateHeaders: (header) {
                      setState(() {
                        headers[header] = true;
                        widget.searchController.text = "";
                      });
                    },
                    updateSearchText: (text) {
                      setState(() {
                        widget.searchController.text = text;
                      });
                    }),
              if (codeForm != "")
                BlocProvider<FormTradeMarketingBloc>(
                  create: (context) {
                    final bloc = FormTradeMarketingBloc();
                    bloc.fetchFormTradeMarketing(codeForm);
                    return bloc;
                  },
                  child: FileSelected(
                    callback: () {
                      setState(() {
                        codeForm = "";
                      });
                    },
                    vendorName: vendorName,
                    clientAddress: clientAddress,
                  ),
                ),
              /*if (Responsive.isMobile(context))
                const SizedBox(height: defaultPadding),
              if (Responsive.isMobile(context)) const StorageDetails(),*/
            ],
          ),
        ),
        if (!Responsive.isMobile(context))
          const SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we don't want to show it
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
                builder: (context, state) {
              if (state is SuccessTradeMarketingState) {
                return StorageDetails(
                  value: state.datafiltered!.length,
                  //calcular la diferencia en dias
                  total: Set.from(state.datafilteredfull!
                          .map((e) => "${e.vendedor}${e.fecha}")).length *
                      5,
                );
              } else if (state is LoadingTradeMarketingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            }),
          ),
      ],
    );
  }
}
