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

  @override
  Future<TradeMarketingPageModel?> getFormTradeMarketing() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.254.20:8083/get.qa/api/survey/RangoEncuestas?FechaInicio=20240101&FechaFin=20240403&CodVendedor=730'));
      if (response.statusCode == 200) {
        return TradeMarketingPageModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      String jsonString = '''
          {
              "cardCode": "K20600221826",
              "cardName": "CREDIADORVA EMPRESA INDIVIDUAL DE RESPONSABILIDAD",
              "chkrecibido": null,
              "DateCompletion": null,
              "DateCreation": "3/04/2024 00:00:00",
              "id": 0,
              "IdDocument": null,
              "Imei": null,
              "Section": [
                  {
                      "U_Descr": "PDV",
                      "U_File": 1,
                      "id": 0,
                      "IdDocument": null,
                      "U_Order": "1",
                      "SubSeccion": [
                          {
                              "Formulario": [
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 1,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "1",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Malo",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Bueno",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Pintado",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_PintadoK20600221826_Document.png"
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Malo",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Bueno",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Letrero",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_LetreroK20600221826_Document.png"
                                          }
                                      ],
                                      "U_Title": "Exterior Punto de Venta",
                                      "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_Exterior Punto de VentaK20600221826_Document.png"
                                  }
                              ],
                              "DocEntry": 1,
                              "IdDocument": null,
                              "Titulo_SubSeccion": "PDV",
                              "SubTitulo_SubSeccion": ""
                          }
                      ]
                  },
                  {
                      "U_Descr": "POP",
                      "U_File": 2,
                      "id": 0,
                      "IdDocument": null,
                      "U_Order": "2",
                      "SubSeccion": [
                          {
                              "Formulario": [
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 2,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "2",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Colgadores",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Rompetratico",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "JalaVistas",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_JalaVistasK20600221826_Document.png"
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Fronterizador",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "4",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "true"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Calendario",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "5",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Afiche Promocional",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "6",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Afiche Producto",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "7",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "No",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Si",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Marcador de Precio",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "8",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Material P.O.P",
                                      "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_Material P.O.PK20600221826_Document.png"
                                  }
                              ],
                              "DocEntry": 2,
                              "IdDocument": null,
                              "Titulo_SubSeccion": "POP",
                              "SubTitulo_SubSeccion": ""
                          }
                      ]
                  },
                  {
                      "U_Descr": "Exhibición Primaria",
                      "U_File": 3,
                      "id": 0,
                      "IdDocument": null,
                      "U_Order": "3",
                      "SubSeccion": [
                          {
                              "Formulario": [
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 3,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "1",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "D",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "F",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  },
                                                  {
                                                      "U_answer": "I",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "3",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Anaquel",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RM",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Facing",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "6",
                                              "U_Type": "RT",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Niveles",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "2",
                                              "U_Type": "RT",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Lubricantes de Motor",
                                      "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_Lubricantes de MotorK20600221826_Document.png"
                                  },
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 4,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "2",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "D",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "true"
                                                  },
                                                  {
                                                      "U_answer": "F",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  },
                                                  {
                                                      "U_answer": "I",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "3",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Anaquel",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RM",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Facing",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "3",
                                              "U_Type": "RT",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Niveles",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "2",
                                              "U_Type": "RT",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Lubricantes de Transmisión",
                                      "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_Lubricantes de TransmisiónK20600221826_Document.png"
                                  },
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 5,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "3",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "F",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "D",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "true"
                                                  },
                                                  {
                                                      "U_answer": "I",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "3",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Anaquel",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RM",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Facing",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "9",
                                              "U_Type": "RT",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Niveles",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "1",
                                              "U_Type": "RT",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Acuosos",
                                      "Url": ""
                                  },
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 6,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "4",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "F",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "D",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "I",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "3",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Anaquel",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RM",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Facing",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "9",
                                              "U_Type": "RT",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Niveles",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "4",
                                              "U_Type": "RT",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Grasas",
                                      "Url": ""
                                  },
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 7,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "5",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "D",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "I",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "3",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "F",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Anaquel",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RM",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Facing",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "5",
                                              "U_Type": "RT",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Niveles",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "5",
                                              "U_Type": "RT",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Car Care",
                                      "Url": ""
                                  },
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 8,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "6",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "D",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "I",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "3",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "F",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Anaquel",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RM",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Facing",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "8",
                                              "U_Type": "RT",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "",
                                                      "U_Responsevalue": "false"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Niveles",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "2",
                                              "U_Type": "RT",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Frenos",
                                      "Url": ""
                                  }
                              ],
                              "DocEntry": 3,
                              "IdDocument": null,
                              "Titulo_SubSeccion": "Exhibición Primaria",
                              "SubTitulo_SubSeccion": ""
                          }
                      ]
                  },
                  {
                      "U_Descr": "Exhibición Secundaria",
                      "U_File": 4,
                      "id": 0,
                      "IdDocument": null,
                      "U_Order": "4",
                      "SubSeccion": [
                          {
                              "Formulario": [
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 9,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "7",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Interno",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Externo",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Ubicación",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Cargado",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Vacío",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Surtido",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Malo",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Bueno",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Estado",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Anaquel Vistony",
                                      "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_Anaquel VistonyK20600221826_Document.png"
                                  },
                                  {
                                      "Base64": null,
                                      "U_File": 0,
                                      "DocEntry": 10,
                                      "id": 0,
                                      "IdDocument": null,
                                      "U_Order": "8",
                                      "Preguntas": [
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Interno",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Externo",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Ubicación",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "1",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Cargado",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Vacío",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Surtido",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "2",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          },
                                          {
                                              "Respuestas": [
                                                  {
                                                      "U_answer": "Malo",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "2",
                                                      "U_Responsevalue": "false"
                                                  },
                                                  {
                                                      "U_answer": "Bueno",
                                                      "id": 0,
                                                      "IdDocument": null,
                                                      "U_Order": "1",
                                                      "U_Responsevalue": "true"
                                                  }
                                              ],
                                              "Base64": null,
                                              "U_Descr": "Estado",
                                              "id": 0,
                                              "IdDocument": null,
                                              "U_Order": "3",
                                              "U_Question": 0,
                                              "U_Responsevalue": "",
                                              "U_Type": "RL",
                                              "Url": ""
                                          }
                                      ],
                                      "U_Title": "Exhibidor Vistony",
                                      "Url": "http://190.12.79.132:8083/get.qa/api/survey/Address/Photo?Name=B1H_VIST_PE_QA2/2024/4/3/Trade_Marketing_Exhibidor VistonyK20600221826_Document.png"
                                  }
                              ],
                              "DocEntry": 4,
                              "IdDocument": null,
                              "Titulo_SubSeccion": "Exhibición Secundaria",
                              "SubTitulo_SubSeccion": ""
                          }
                      ]
                  }
              ],
              "shipToCode": null,
              "SlpCode": 730
          }
      ''';
      return TradeMarketingPageModel.fromJson(jsonDecode(jsonString));
    }
  }
}
