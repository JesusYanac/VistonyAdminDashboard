import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:vistony_admin_dashboard/presentation/features/dashboard/trade_marketing/bloc/form_trade_marketing_bloc.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/constants.dart';

class FileSelected extends StatefulWidget {
  const FileSelected({super.key, required this.callback});

  final Function callback;

  @override
  State<FileSelected> createState() => _FileSelectedState();
}

class _FileSelectedState extends State<FileSelected> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormTradeMarketingBloc, FormTradeMarketingState>(
      builder: (context, state) {
        if (state is LoadingFormTradeMarketingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SuccessFormTradeMarketingState) {
          return Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    widget.callback();
                  },
                  child: const Row(
                    children: [
                      //arrow back
                      Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
                      SizedBox(width: defaultPadding/2),
                      Text(
                        "Regresar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Archivos Recientes",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),

              ],
            ),
          );
        }else{
          return Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    widget.callback();
                  },
                  child: const Row(
                    children: [
                      //arrow back
                      Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
                      SizedBox(width: defaultPadding/2),
                      Text(
                        "Regresar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: RiveAnimation.asset(Assets.riveAnimationsAlien404Screen,fit: BoxFit.contain,),
                    )
                  ],
                )

              ],
            ),
          );
        }
      }
    );

  }
}
