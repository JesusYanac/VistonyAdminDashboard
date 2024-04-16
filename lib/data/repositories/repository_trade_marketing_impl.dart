import 'dart:convert';

import '../../data/model/trade_marketing_model.dart';
import '../../domain/repositories/repository_trade_marketing.dart';
import 'package:http/http.dart' as http;

class RepositoryTradeMarketingImpl implements RepositoryTradeMarketing {
  @override
  Future<TradeMarketingEntity?> getTradeMarketing() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.254.20:8083/get.qa/api/survey/RangoEncuestas?FechaInicio=20240101&FechaFin=20240403&CodVendedor=730'));
      if (response.statusCode == 200) {
        final jsondata = '''
        {
          "status": "S",
          "Data": ${response.body}
        }
        ''';
        return TradeMarketingEntity.fromJson(jsonDecode(jsondata));
      } else {
        return null;
      }
    } catch (e) {
      //status s de momento pues siempre entrara aqui porque la api no esta lista
      String jsonString = '''
          {
              "status": "S",
              "Data": [
                  {
                      "cardCode": "K20600221826",
                      "cardName": "CREDIADORVA EMPRESA INDIVIDUAL DE RESPONSABILIDAD",
                      "chkrecibido": null,
                      "DateCompletion": null,
                      "DateCreation": "3/04/2024 00:00:00",
                      "id": 0,
                      "IdDocument": null,
                      "Imei": null,
                      "Section": null,
                      "shipToCode": null,
                      "SlpCode": 730
                  },
                  {
                      "cardCode": "K20600221826",
                      "cardName": "CREDIADORVA EMPRESA INDIVIDUAL DE RESPONSABILIDAD",
                      "chkrecibido": null,
                      "DateCompletion": null,
                      "DateCreation": "4/04/2024 00:00:00",
                      "id": 0,
                      "IdDocument": null,
                      "Imei": null,
                      "Section": null,
                      "shipToCode": null,
                      "SlpCode": 730
                  }
              ]
          }
      ''';
      return TradeMarketingEntity.fromJson(jsonDecode(jsonString));
    }
  }
}
