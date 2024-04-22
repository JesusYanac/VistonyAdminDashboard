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
      print("entro a on reload");
      emit(LoadingTradeMarketingState(
        data: [],
        datafiltered: [],
      ));
      // Inicia un temporizador para asegurar un retraso mínimo de 2 segundos
      final minimumDelayFuture = Future.delayed(const Duration(seconds: 1));

      // Realiza la consulta a la API
      final apiResponseFuture = UseCaseTradeMarketing().getTradeMarketing();

      // Espera a que ambas tareas (retraso mínimo y respuesta de la API) se completen
      await Future.wait([minimumDelayFuture, apiResponseFuture]);

      // Obtiene el valor de la respuesta de la API
      final TradeMarketingEntity? value = await apiResponseFuture;
      if (value != null && value.status != "N") {
        emit(SuccessTradeMarketingState(
          data: value?.data,
          datafiltered: value?.data,
        ));
      } else {
        emit(ErrorTradeMarketingState(
          data: value?.data,
          datafiltered: value?.data,
        ));
      }
    });
    on<FilterTradeMarketing>((event, emit) {
      List<TradeMarketingHeader>? data = state.data;
      if (data != null && event.value.isNotEmpty) {
        List<TradeMarketingHeader>? datafiltered = data
            .where((element) {
          return element.cardName
              .toLowerCase()
              .contains(event.value.toLowerCase());
        })
            .toList();
        emit(SuccessTradeMarketingState(
          data: data,
          datafiltered: datafiltered,
        ));
      } else {
        emit(SuccessTradeMarketingState(
          data: data,
          datafiltered: data,
        ));
      }
    });

    on<FilterByDateTradeMarketing>((event, emit) {
      List<TradeMarketingHeader>? data = state.data;
      if (data != null && event.fini.isNotEmpty && event.ffin.isNotEmpty) {
        List<TradeMarketingHeader>? datafiltered = data
            .where((element) {
              // parse fecha YYYY-MM-DD que es fini y ffin
              String fini = event.fini; // YYYY-MM-DD en formato de cadena
              String ffin = event.ffin; // YYYY-MM-DD en formato de cadena
              String finiDay = fini.split('-')[2];
              String finiMonth = fini.split('-')[1];
              String finiYear = fini.split('-')[0];
              String ffinDay = ffin.split('-')[2];
              String ffinMonth = ffin.split('-')[1];
              String ffinYear = ffin.split('-')[0];
              print("fini $fini");
              print("fini day : $finiDay");
              print("fini month : $finiMonth");
              print("fini year : $finiYear");
              print("ffin $ffin");
              print("ffin day : $ffinDay");
              print("ffin month : $ffinMonth");
              print("ffin year : $ffinYear");
              // se convierten las fechas a DateTime
              DateTime date1 = DateTime(int.parse(finiYear), int.parse(finiMonth), int.parse(finiDay));
              DateTime date2 = DateTime(int.parse(ffinYear), int.parse(ffinMonth), int.parse(ffinDay));
              // se compara la fecha del elemento con la fecha de inicio y fin
              if(element.dateCreate != ""){
                String dateElement = element.dateCreate.toString().split(" ")[0];
                String dateElementYear = dateElement.split('-')[0];
                String dateElementMonth = dateElement.split('-')[1];
                String dateElementDay = dateElement.split('-')[2];
                print("dateElement $dateElement");
                print("dateElement day : $dateElementDay");
                print("dateElement month : $dateElementMonth");
                print("dateElement year : $dateElementYear");
                // se convierten las fechas a DateTime
                DateTime dateElement2 = DateTime(
                  int.parse(dateElementYear),
                  int.parse(dateElementMonth),
                  int.parse(dateElementDay),
                );
                // se compara la fecha del elemento con la fecha de inicio y fin
                print("date1.isBefore(dateElement2) && date2.isAfter(dateElement2) : ${date1.isBefore(dateElement2) && date2.isAfter(dateElement2)}");
                return date1.isBefore(dateElement2) && date2.isAfter(dateElement2);
              }else{
                return false;
              }
        })
            .toList();
        emit(SuccessTradeMarketingState(
          data: data,
          datafiltered: datafiltered,
        ));
      } else {
        emit(SuccessTradeMarketingState(
          data: data,
          datafiltered: data,
        ));
      }
    });
  }
  void reloadTradeMarketing() => add(ReloadTradeMarketing());

  void filterTradeMarketing(String value) => add(FilterTradeMarketing(value));

  void filterByDateTradeMarketing(fini, ffin) => add(FilterByDateTradeMarketing(fini, ffin));
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

class FilterByDateTradeMarketing extends TradeMarketingEvent {
  final String fini;
  final String ffin;
  FilterByDateTradeMarketing(this.fini, this.ffin);
}

class TradeMarketingState {
  List<TradeMarketingHeader>? data;
  List<TradeMarketingHeader>? datafiltered;
  TradeMarketingState({required this.data, required this.datafiltered});
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
      {required super.data, required super.datafiltered});
}

class ErrorTradeMarketingState extends TradeMarketingState {
  ErrorTradeMarketingState({required super.data, required super.datafiltered});
}
