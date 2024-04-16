import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/domain/usecases/usecase_trade_marketing.dart';

import '../../../../../data/model/trade_marketing_model.dart';

class TradeMarketingBloc extends Bloc<TradeMarketingEvent, TradeMarketingState> {
  TradeMarketingBloc() : super(InitialTradeMarketingState([])) {
    on<ReloadTradeMarketing>((event, emit)async{
      emit(LoadingTradeMarketingState([]));
      // Inicia un temporizador para asegurar un retraso mínimo de 2 segundos
      final minimumDelayFuture = Future.delayed(const Duration(seconds: 2));

      // Realiza la consulta a la API
      final apiResponseFuture = UseCaseTradeMarketing().getTradeMarketing();

      // Espera a que ambas tareas (retraso mínimo y respuesta de la API) se completen
      await Future.wait([minimumDelayFuture, apiResponseFuture]);

      // Obtiene el valor de la respuesta de la API
      final TradeMarketingEntity? value = await apiResponseFuture;
      debugPrint("value: value.toString(): ${value?.data.toString()}");
      if(value != null && value.status != "N"){
        emit(SuccessTradeMarketingState(value.data));
      }else{
        emit(ErrorTradeMarketingState([]));
      }
    });
  }
  void reloadTradeMarketing() => add(ReloadTradeMarketing());
}

class TradeMarketingEvent {
  TradeMarketingEvent();
}

class ReloadTradeMarketing extends TradeMarketingEvent {
  ReloadTradeMarketing();
}

class TradeMarketingState {
  List<TradeMarketingPageModel>? data;
  TradeMarketingState([this.data]);
}

class InitialTradeMarketingState extends TradeMarketingState {
  InitialTradeMarketingState(super.data);
}

class LoadingTradeMarketingState extends TradeMarketingState {
  LoadingTradeMarketingState(super.data);
}

class SuccessTradeMarketingState extends TradeMarketingState {
  SuccessTradeMarketingState(super.data);
}

class ErrorTradeMarketingState extends TradeMarketingState {
  ErrorTradeMarketingState(super.data);
}

