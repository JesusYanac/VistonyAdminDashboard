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
  const TradeMarketingScreen({super.key});
  @override
  State<TradeMarketingScreen> createState() => _TradeMarketingScreenState();
}

class _TradeMarketingScreenState extends State<TradeMarketingScreen> {
  String codeForm = "";
  String vendorName = "";
  String clientAddress = "";
  @override
  Widget build(BuildContext context) {
    if (codeForm == "") {
      BlocProvider.of<NavigationBloc>(context).updateSearchBoxVisibility(0, true);
    }else{
      BlocProvider.of<NavigationBloc>(context).updateSearchBoxVisibility(0, false);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              const MyFiles(),
              const SizedBox(height: defaultPadding),
              if (codeForm == "")
                RecentFiles(callback: (code, vendor, address){
                  setState(() {
                    codeForm = code;
                    vendorName = vendor;
                    clientAddress = address;
                  });
                }),
              if (codeForm != "")
                BlocProvider<FormTradeMarketingBloc>(
                  create: (context) {
                    final bloc = FormTradeMarketingBloc();
                    bloc.fetchFormTradeMarketing(codeForm);
                    return bloc;
                  },
                  child: FileSelected(callback: (){
                    setState(() {
                      codeForm = "";
                    });
                  },
                  vendorName: vendorName,
                  clientAddress: clientAddress,),
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
                    total: 120*5*(state.ffin.difference(state.fini).inDays+1),
                  );
                }else if (state is LoadingTradeMarketingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  return Container();
                }

              }
            ),
          ),
      ],
    );
  }
}
