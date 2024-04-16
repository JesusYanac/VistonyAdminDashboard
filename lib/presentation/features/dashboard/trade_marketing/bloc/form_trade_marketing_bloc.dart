import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/domain/usecases/usecase_trade_marketing.dart';

import '../../../../../data/model/trade_marketing_model.dart';

class FormTradeMarketingBloc extends Bloc<FormTradeMarketingEvent, FormTradeMarketingState> {
  FormTradeMarketingBloc() : super(InitialFormTradeMarketingState(null)) {
    on<FetchFormTradeMarketing>((event, emit)async{
      emit(LoadingFormTradeMarketingState(null));
      final TradeMarketingPageModel? value = await UseCaseTradeMarketing().getFormTradeMarketing();
      debugPrint("value: value.toString(): ${value?.toString()}");
      if(value != null){
        emit(ErrorFormTradeMarketingState(value));
      }else{
        emit(ErrorFormTradeMarketingState(null));
      }
    });
  }
  void fetchFormTradeMarketing(String codeForm) => add(FetchFormTradeMarketing(codeForm));
}

class FormTradeMarketingEvent {
  String codeForm = "";
  FormTradeMarketingEvent(this.codeForm);
}

class FetchFormTradeMarketing extends FormTradeMarketingEvent {
  FetchFormTradeMarketing(super.codeForm);
}

class FormTradeMarketingState {
  TradeMarketingPageModel? data;
  FormTradeMarketingState([this.data]);
}

class InitialFormTradeMarketingState extends FormTradeMarketingState {
  InitialFormTradeMarketingState(super.data);
}

class LoadingFormTradeMarketingState extends FormTradeMarketingState {
  LoadingFormTradeMarketingState(super.data);
}

class SuccessFormTradeMarketingState extends FormTradeMarketingState {
  SuccessFormTradeMarketingState(super.data);
}

class ErrorFormTradeMarketingState extends FormTradeMarketingState {
  ErrorFormTradeMarketingState(super.data);
}

