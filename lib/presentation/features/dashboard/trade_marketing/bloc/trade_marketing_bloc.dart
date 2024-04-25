import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/trade_marketing_model.dart';
import '../../../../../domain/usecases/usecase_trade_marketing.dart';

class TradeMarketingBloc
    extends Bloc<TradeMarketingEvent, TradeMarketingState> {
  TradeMarketingBloc()
      : super(InitialTradeMarketingState(
          data: [],
          datafiltered: [],
        )) {
    on<ReloadTradeMarketing>((event, emit) async {
      emit(LoadingTradeMarketingState(
        data: [],
        datafiltered: [],
      ));
      // Inicia un temporizador para asegurar un retraso mínimo de 2 segundos
      final minimumDelayFuture = Future.delayed(const Duration(seconds: 1));

      // Realiza la consulta a la API
      final apiResponseFuture = UseCaseTradeMarketing().getTradeMarketing(
        DateTime(DateTime.now().year, DateTime.now().month, 1).toString().split(' ')[0],
        DateTime.now().toString().split(' ')[0],
      );


      // Espera a que ambas tareas (retraso mínimo y respuesta de la API) se completen
      await Future.wait([minimumDelayFuture, apiResponseFuture]);

      // Obtiene el valor de la respuesta de la API
      final TradeMarketingEntity? value = await apiResponseFuture;
      if (value != null && value.data != null && value.data!.isNotEmpty && value.status != "N") {
        emit(SuccessTradeMarketingState(
          data: value.data,
          datafiltered: value.data,
          header: state.header,
        ));
      } else {
        emit(ErrorTradeMarketingState(
          data: [],
          datafiltered: [],
        ));
      }
    });
    on<FilterTradeMarketing>((event, emit) {
      List<TradeMarketingHeader>? data = state.data;
      debugPrint("state.header ${state.header}");
      if(state.header == "Cliente"|| state.header == ""){
        if (data != null && event.value.isNotEmpty) {
          List<TradeMarketingHeader>? datafiltered = data.where((element) {
            return (element.cardName??"")
                .toLowerCase()
                .contains(event.value.toLowerCase());
          }).toList();
          emit(SuccessTradeMarketingState(
            data: data,
            datafiltered: datafiltered,
            header: state.header,
          ));
        } else {
          emit(SuccessTradeMarketingState(
            data: data,
            datafiltered: data,
            header: state.header,
          ));
        }
      }else if (state.header == "Vendedor") {
        if (data != null && event.value.isNotEmpty) {
          List<TradeMarketingHeader>? datafiltered = data.where((element) {
            return (element.vendedor??"")
                .toLowerCase()
                .contains(event.value.toLowerCase());
          }).toList();
          emit(SuccessTradeMarketingState(
            data: data,
            datafiltered: datafiltered,
            header: state.header,
          ));
        } else {
          emit(SuccessTradeMarketingState(
            data: data,
            datafiltered: data,
            header: state.header,
          ));
        }
      }else if (state.header == "Dirección") {
        if (data != null && event.value.isNotEmpty) {
          List<TradeMarketingHeader>? datafiltered = data.where((element) {
            return (element.direccion??"")
                .toLowerCase()
                .contains(event.value.toLowerCase());
          }).toList();
          emit(SuccessTradeMarketingState(
            data: data,
            datafiltered: datafiltered,
            header: state.header,
          ));
        } else {
          emit(SuccessTradeMarketingState(
            data: data,
            datafiltered: data,
            header: state.header,
          ));
        }
      }else{
        emit(SuccessTradeMarketingState(
          data: data,
          datafiltered: data,
          header: state.header,
        ));
      }
    });

    on<FilterByDateTradeMarketing>((event, emit) async {
      String fini = event.fini; // YYYY-MM-DD en formato de cadena
      String ffin = event.ffin; // YYYY-MM-DD en formato de cadena
      String finiDay = fini.split('-')[2];
      String finiMonth = fini.split('-')[1];
      String finiYear = fini.split('-')[0];
      String ffinDay = ffin.split('-')[2];
      String ffinMonth = ffin.split('-')[1];
      String ffinYear = ffin.split('-')[0];
      emit(LoadingTradeMarketingState(
        data: [],
        datafiltered: [],
      ));
      // Inicia un temporizador para asegurar un retraso mínimo de 2 segundos
      final minimumDelayFuture = Future.delayed(const Duration(seconds: 1));

      // Realiza la consulta a la API
      final apiResponseFuture = UseCaseTradeMarketing().getTradeMarketing(
        finiYear+finiMonth+finiDay, ffinYear+ffinMonth+ffinDay
      );

      // Espera a que ambas tareas (retraso mínimo y respuesta de la API) se completen
      await Future.wait([minimumDelayFuture, apiResponseFuture]);

      // Obtiene el valor de la respuesta de la API
      final TradeMarketingEntity? value = await apiResponseFuture;
      if (value != null && event.fini.isNotEmpty && event.ffin.isNotEmpty) {
        emit(SuccessTradeMarketingState(
          data: value.data,
          datafiltered: value.data,
          header: "Fecha",
        ));
      } else {
        emit(ErrorTradeMarketingState(
          data: [],
          datafiltered: [],
        ));
      }


    });
    on<FilterTradeMarketingByHeader>((event, emit) {
      emit(SuccessTradeMarketingState(
        data: state.data,
        datafiltered: state.data,
          header: event.header,
      ));
    });
  }
  void reloadTradeMarketing() => add(ReloadTradeMarketing());

  void filterTradeMarketing(String value) => add(FilterTradeMarketing(value));

  void filterByDateTradeMarketing(fini, ffin) =>
      add(FilterByDateTradeMarketing(fini, ffin));

  void setFilter(String header) => add(FilterTradeMarketingByHeader(header));
}

class TradeMarketingEvent {
  TradeMarketingEvent();
}

class ReloadTradeMarketing extends TradeMarketingEvent {
  ReloadTradeMarketing();
}

class FilterTradeMarketing extends TradeMarketingEvent {
  final String value;
  FilterTradeMarketing(this.value);
}

class FilterTradeMarketingByHeader extends TradeMarketingEvent {
  final String? header;
  FilterTradeMarketingByHeader(this.header);
}

class FilterByDateTradeMarketing extends TradeMarketingEvent {
  final String fini;
  final String ffin;
  FilterByDateTradeMarketing(this.fini, this.ffin);
}

class TradeMarketingState {
  List<TradeMarketingHeader>? data;
  List<TradeMarketingHeader>? datafiltered;
  String? header;
  TradeMarketingState({required this.data, required this.datafiltered, this.header});
}

class InitialTradeMarketingState extends TradeMarketingState {
  InitialTradeMarketingState(
      {required super.data, required super.datafiltered});
}

class LoadingTradeMarketingState extends TradeMarketingState {
  LoadingTradeMarketingState(
      {required super.data, required super.datafiltered});
}

class SuccessTradeMarketingState extends TradeMarketingState {
  SuccessTradeMarketingState(
      {required super.data, required super.datafiltered, required super.header});
}

class ErrorTradeMarketingState extends TradeMarketingState {
  ErrorTradeMarketingState({required super.data, required super.datafiltered});
}
