import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/presentation/features/dashboard/trade_marketing/bloc/trade_marketing_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/controllers/responsive.dart';

import 'bloc/form_trade_marketing_bloc.dart';
import 'components/file_selected.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class TradeMarketingScreen extends StatefulWidget {
  const TradeMarketingScreen({super.key});

  @override
  State<TradeMarketingScreen> createState() => _TradeMarketingScreenState();
}

class _TradeMarketingScreenState extends State<TradeMarketingScreen> {
  String codeForm = "";
  @override
  Widget build(BuildContext context) {
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
                BlocProvider<TradeMarketingBloc>(
                  create: (context) {
                    final bloc = TradeMarketingBloc();
                    bloc.reloadTradeMarketing();
                    return bloc;
                  },
                  child: RecentFiles(callback: (value){
                    setState(() {
                      codeForm = value;
                    });
                  }),
                ),
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
                  }),
                ),
              if (Responsive.isMobile(context))
                const SizedBox(height: defaultPadding),
              if (Responsive.isMobile(context)) const StorageDetails(),
            ],
          ),
        ),
        if (!Responsive.isMobile(context))
          const SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we don't want to show it
        if (!Responsive.isMobile(context))
          const Expanded(
            flex: 2,
            child: StorageDetails(),
          ),
      ],
    );
  }
}
