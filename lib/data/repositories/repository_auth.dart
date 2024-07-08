import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../data/model/trade_marketing_model.dart';
import '../../domain/repositories/repository_auth.dart';
import '../../domain/repositories/repository_trade_marketing.dart';

class RepositoryAuthImpl implements RepositoryAuth {
  var proxyUrl = 'https://cors-anywhere.herokuapp.com/';
  @override
  Future<bool> getAuthLogin(String username, String password) async {
    try {
      // URL de la API a consumir
      var apiUrl = 'http://190.12.79.135:8060/get/api/TradeMarketing/Validate';

      // Construir la URL completa
      var url = Uri.parse('${kIsWeb ? proxyUrl : ""}$apiUrl');
      debugPrint(url.toString());

      // Crear el cuerpo de la solicitud
      var body = jsonEncode({
        'Usuario': username,
        'Password': password,
      });

      // Realizar la solicitud POST con el cuerpo JSON
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      debugPrint("response: ${response.body}");

      if (response.statusCode == 200) {
        return response.body == 'Y';
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }
}
