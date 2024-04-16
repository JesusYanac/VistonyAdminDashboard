import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/presentation/features/dashboard/trade_marketing/bloc/trade_marketing_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/controllers/responsive.dart';

import 'components/my_fields.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class TradeMarketingScreen extends StatelessWidget {
  const TradeMarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              const MyFiles(),
              const SizedBox(height: defaultPadding),
              BlocProvider<TradeMarketingBloc>(
                create: (context){
                  final bloc = TradeMarketingBloc();
                  bloc.reloadTradeMarketing();
                  return bloc;
                },
                child: const RecentFiles(),
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


