import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/presentation/features/dashboard/bloc/navigation_bloc.dart';

import 'bloc/form_trade_marketing_bloc.dart';
import 'bloc/trade_marketing_bloc.dart';
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
              //const MyFiles(),
              //const SizedBox(height: defaultPadding),
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
        /*if (!Responsive.isMobile(context))
          const SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we don't want to show it
        if (!Responsive.isMobile(context))
          const Expanded(
            flex: 2,
            child: StorageDetails(),
          ),*/
      ],
    );
  }
}
