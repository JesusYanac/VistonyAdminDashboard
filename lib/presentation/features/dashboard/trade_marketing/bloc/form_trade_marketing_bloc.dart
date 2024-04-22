import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/trade_marketing_model.dart';
import '../../../../../domain/usecases/usecase_trade_marketing.dart';

class FormTradeMarketingBloc extends Bloc<FormTradeMarketingEvent, FormTradeMarketingState> {
  FormTradeMarketingBloc() : super(InitialFormTradeMarketingState(null)) {
    on<FetchFormTradeMarketing>((event, emit)async{
      emit(LoadingFormTradeMarketingState(null));
      // Inicia un temporizador para asegurar un retraso mínimo de 2 segundos
      final minimumDelayFuture = Future.delayed(const Duration(seconds: 1));

      // Realiza la consulta a la API
      final apiResponseFuture = UseCaseTradeMarketing().getFormTradeMarketing();

      // Espera a que ambas tareas (retraso mínimo y respuesta de la API) se completen
      await Future.wait([minimumDelayFuture, apiResponseFuture]);

      // Obtiene el valor de la respuesta de la API
      final TradeMarketingPageModel? value = await apiResponseFuture;
      if(value != null){
        emit(SuccessFormTradeMarketingState(value));
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

