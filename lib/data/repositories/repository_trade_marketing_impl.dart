import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../data/model/trade_marketing_model.dart';
import '../../domain/repositories/repository_trade_marketing.dart';
import 'package:http/http.dart' as http;

class RepositoryTradeMarketingImpl implements RepositoryTradeMarketing {
  var proxyUrl = 'https://cors-anywhere.herokuapp.com/';
  @override
  Future<TradeMarketingEntity?> getTradeMarketing(String dateini, String datefin) async {
    try {
      // URL de la API a consumir
      var apiUrl = 'http://190.12.79.135:8060/get/api/TradeMarketing/Get';

      // Parámetros de la consulta
      var queryParams = 'DateStart=$dateini&DateFinish=$datefin';

      // Construir la URL completa con los parámetros
      var url = Uri.parse('$proxyUrl$apiUrl?$queryParams');
      debugPrint(url.toString());
      var response = await http.get(url);
      debugPrint("response: ${response.body}");
      if (response.statusCode == 200) {
        final String jsonString = '''
          {
            "status": "S",
            "data": ${response.body}
          }
        ''';
        final Map<String, dynamic> jsondata = jsonDecode(jsonString);
        TradeMarketingEntity model = TradeMarketingEntity.fromJson(jsondata);
        return model;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
  @override
  Future<TradeMarketingPageModel?> getFormTradeMarketing(String docEntry) async {
    try {
      var apiUrl =
          'http://190.12.79.135:8060/get/api/TradeMarketing/GetEncuesta?DocEntry=$docEntry';
      var url = Uri.parse(proxyUrl + apiUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsondata = jsonDecode(response.body)[0];
        final TradeMarketingPageModel model =
            TradeMarketingPageModel.fromJson(jsondata);
        return model;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}

String jsonTestFormTradeMarketing() => '''
            {
                "cardCode": "C10096699056",
                "cardName": "ALEJOS VICENTE,SANDRA ROSA",
                "chkrecibido": "", 
                "DateCompletion": "", 
                "DateCreation": "15/04/2024 00:00:00",
                "id": 0,
                "IdDocument": "", 
                "Imei": "", 
                "Section": [
                    {
                        "U_Descr": "PDV",
                        "U_File": 1,
                        "id": 0,
                        "IdDocument": "", 
                        "U_Order": "1",
                        "SubSeccion": [
                            {
                                "Formulario": [
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 1,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "1",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "Malo",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "true"
                                                    },
                                                    {
                                                        "U_answer": "Bueno",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Letrero",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
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
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "true"
                                                    },
                                                    {
                                                        "U_answer": "Bueno",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Pintado",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Exterior Punto de Venta",
                                        "Url": ""
                                    }
                                ],
                                "DocEntry": 1,
                                "IdDocument": "", 
                                "Titulo_SubSeccion": "PDV",
                                "SubTitulo_SubSeccion": ""
                            }
                        ]
                    },
                    {
                        "U_Descr": "POP",
                        "U_File": 2,
                        "id": 0,
                        "IdDocument": "", 
                        "U_Order": "2",
                        "SubSeccion": [
                            {
                                "Formulario": [
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 2,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "2",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "JalaVistas",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_JalaVistasC1009669905600010101_Document.png"
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Fronterizador",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_FronterizadorC1009669905600010101_Document.png"
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Calendario",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_CalendarioC1009669905600010101_Document.png"
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Afiche Promocional",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "4",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_Afiche_PromocionalC1009669905600010101_Document.png"
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Afiche Producto",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "5",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_Afiche_ProductoC1009669905600010101_Document.png"
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Marcador de Precio",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "6",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Colgadores",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "7",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_ColgadoresC1009669905600010101_Document.png"
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "NO",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "SI",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Rompetratico",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "8",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Material P.O.P",
                                        "Url": ""
                                    }
                                ],
                                "DocEntry": 2,
                                "IdDocument": "", 
                                "Titulo_SubSeccion": "POP",
                                "SubTitulo_SubSeccion": ""
                            }
                        ]
                    },
                    {
                        "U_Descr": "Exhibición Primaria",
                        "U_File": 3,
                        "id": 0,
                        "IdDocument": "", 
                        "U_Order": "3",
                        "SubSeccion": [
                            {
                                "Formulario": [
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 3,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "1",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "D",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "I",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "3",
                                                        "U_Responsevalue": "true"
                                                    },
                                                    {
                                                        "U_answer": "F",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Anaquel",
                                                "id": 0,
                                                "IdDocument": "", 
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
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Facing",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Niveles",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Lubricantes de Motor",
                                        "Url": ""
                                    },
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 4,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "2",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Facing",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "1",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Niveles",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "1",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "D",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "I",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "3",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "F",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Anaquel",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RM",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Lubricantes de Transmisión",
                                        "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_Lubricantes_de_TransmisiónC1009669905600010101_Document.png"
                                    },
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 5,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "3",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Facing",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Niveles",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "D",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "I",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "3",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "F",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Anaquel",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RM",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Acuosos",
                                        "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_AcuososC1009669905600010101_Document.png"
                                    },
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 6,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "4",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Facing",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Niveles",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "D",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "I",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "3",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "F",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Anaquel",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RM",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Grasas",
                                        "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_GrasasC1009669905600010101_Document.png"
                                    },
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 7,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "5",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Facing",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Niveles",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "D",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "I",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "3",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "F",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Anaquel",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RM",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Car Care",
                                        "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_Car_CareC1009669905600010101_Document.png"
                                    },
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 8,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "6",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Facing",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Niveles",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RT",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "D",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "I",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "3",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "F",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Anaquel",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RM",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Frenos",
                                        "Url": "http://190.12.79.132:8083/get.qa/api/survey/Photo?Name=B1H_VIST_PE/2024/4/15/Trade_Marketing_FrenosC1009669905600010101_Document.png"
                                    }
                                ],
                                "DocEntry": 3,
                                "IdDocument": "", 
                                "Titulo_SubSeccion": "Exhibición Primaria",
                                "SubTitulo_SubSeccion": ""
                            }
                        ]
                    },
                    {
                        "U_Descr": "Exhibición Secundaria",
                        "U_File": 4,
                        "id": 0,
                        "IdDocument": "", 
                        "U_Order": "4",
                        "SubSeccion": [
                            {
                                "Formulario": [
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 9,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "7",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "Malo",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "Bueno",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Estado",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "Interno",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    },
                                                    {
                                                        "U_answer": "Externo",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Ubicación",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "2",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "Vacío",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "Cargado",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Surtido",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "Anaquel Vistony",
                                        "Url": ""
                                    },
                                    {
                                        "Base64": "", 
                                        "U_File": 0,
                                        "DocEntry": 10,
                                        "id": 0,
                                        "IdDocument": "", 
                                        "U_Order": "8",
                                        "Preguntas": [
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "Interno",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    },
                                                    {
                                                        "U_answer": "Externo",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Ubicación",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "1",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            },
                                            {
                                                "Respuestas": [
                                                    {
                                                        "U_answer": "Vacío",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "Cargado",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Surtido",
                                                "id": 0,
                                                "IdDocument": "", 
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
                                                        "IdDocument": "", 
                                                        "U_Order": "2",
                                                        "U_Responsevalue": "false"
                                                    },
                                                    {
                                                        "U_answer": "Bueno",
                                                        "id": 0,
                                                        "IdDocument": "", 
                                                        "U_Order": "1",
                                                        "U_Responsevalue": "true"
                                                    }
                                                ],
                                                "Base64": "", 
                                                "U_Descr": "Estado",
                                                "id": 0,
                                                "IdDocument": "", 
                                                "U_Order": "3",
                                                "U_Question": 0,
                                                "U_Responsevalue": "",
                                                "U_Type": "RL",
                                                "Url": ""
                                            }
                                        ],
                                        "U_Title": "",
                                        "Url": ""
                                    }
                                ],
                                "DocEntry": 4,
                                "IdDocument": "", 
                                "Titulo_SubSeccion": "Exhibición Secundaria",
                                "SubTitulo_SubSeccion": ""
                            }
                        ]
                    }
                ],
                "shipToCode": "", 
                "SlpCode": 208
            }

      ''';

String jsonTestTradeMarketing() => '''
{
  "status": "S",
  "data": [
    {
      "DocEntry": "4",
      "CardCode": "C20604419361",
      "CardName": "IMPORTACIONES Y SERVICIOS GEDEON S.A.C.",
      "DateCreate": "2023-07-15",
      "Direccion": "MZA. A LOTE. 9-A A.H. LOS LAURELES",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "5",
      "CardCode": "C10435687909",
      "CardName": "DE LA CRUZ HUAMAN EDISON",
      "DateCreate": "2023-10-28",
      "Direccion": "CAL.LA UNION MZA. D LOTE. 06 A.H. EL INTI",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "6",
      "CardCode": "C10074522021",
      "CardName": "VEGA CCANTO MADIO MARCELINO",
      "DateCreate": "2024-01-05",
      "Direccion": "AV. LOS PROCERES MZ A LOTE 11 AAHH EL INTI LIMA-LIMA - SAN JUAN DE MIRAFLORES",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "7",
      "CardCode": "C10096560155",
      "CardName": "TUPAYUPANQUI ZUÑIGA JOSE SANTOS",
      "DateCreate": "2024-04-10",
      "Direccion": "Av.Jorge Basadre este 407 urb.San Carlos S.j.l",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "8",
      "CardCode": "C10096560155",
      "CardName": "TUPAYUPANQUI ZUÑIGA JOSE SANTOS",
      "DateCreate": "2024-02-18",
      "Direccion": "Av.Jorge Basadre este 407 urb.San Carlos S.j.l",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "9",
      "CardCode": "C10096560155",
      "CardName": "TUPAYUPANQUI ZUÑIGA JOSE SANTOS",
      "DateCreate": "2023-11-21",
      "Direccion": "Av.Jorge Basadre este 407 urb.San Carlos S.j.l",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "10",
      "CardCode": "C47304499",
      "CardName": "SANDOVAL CORDOVA JORGE LUIS",
      "DateCreate": "2023-08-30",
      "Direccion": "Av. Mateo pumacahua mz. L1  Lt. 6 Santiago de Surco",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "11",
      "CardCode": "C43877879",
      "CardName": "VASQUEZ CAMPOS JOSE GILMER",
      "DateCreate": "2024-03-12",
      "Direccion": "JR.las Escarchas 104,A 23 Urb.Coop. El Mantaro Nro.121",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "12",
      "CardCode": "C10106313119",
      "CardName": "ALLCCA ALHUAY PEDRO",
      "DateCreate": "2023-12-04",
      "Direccion": "AV. SAN JUAN MZA. A1 LOTE. 5 P.J. PUMACAHUA MATEO",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "13",
      "CardCode": "C10083092802",
      "CardName": "CARDENAS INFANZON MAXIMO",
      "DateCreate": "2024-01-20",
      "Direccion": "AV. LOS POSTES NRO. 380 ASOC SAN HILARION (ALT PARAD 15 DE AV LAS FLORES) LIMA - LIMA - SAN JUAN DE",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "14",
      "CardCode": "C10417166012",
      "CardName": "CALDERON RAMIREZ GLORIA ELIZABETH",
      "DateCreate": "2023-10-07",
      "Direccion": "MZA. D LOTE. L3 P.J. JOSE MARIA ARGUEDAS",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "15",
      "CardCode": "C74904609",
      "CardName": "FERNANDEZ ALTAMIRANO ALEX FREDY",
      "DateCreate": "2023-09-14",
      "Direccion": "MZ B LT 5  LA MERCED",
      "Vendedor": "45 PALOMINO JIMENEZ ANGEL"
    },
    {
      "DocEntry": "16",
      "CardCode": "C10326452268",
      "CardName": "ROBLES ESPINOZA WALTER MANUEL",
      "DateCreate": "2024-03-21",
      "Direccion": "PROLONG. JESUS DEL VALLE NRO. 860",
      "Vendedor": "45 PALOMINO JIMENEZ ANGEL"
    },
    {
      "DocEntry": "17",
      "CardCode": "C10088022861",
      "CardName": "CAVERO LEON ALBERTO",
      "DateCreate": "2023-11-30",
      "Direccion": "AV. TOMAS MARSANO NRO. 3974 URB. LOS MOROCHUCOS (ALTURA AV SANTIAGO DE SURCO) LIMA - LIMA - SANTIAGO",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "18",
      "CardCode": "C10069360462",
      "CardName": "CANDIA CHINCHAY GAUDENCIO",
      "DateCreate": "2024-02-05",
      "Direccion": "Av. Proceres de la Independencia NRO.Mz A lote 08, Asoc.de Vivienda Los Pinos S.J.L",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "19",
      "CardCode": "C10409406390",
      "CardName": "OSORIO HUARANGA LINA BANEZA",
      "DateCreate": "2024-04-16",
      "Direccion": "Av. Santiago de surco 3535",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "20",
      "CardCode": "C10071301856",
      "CardName": "MATOS VELASQUEZ AGUSTIN",
      "DateCreate": "2023-08-15",
      "Direccion": "AV. SAN MARTÍN ESTE NRO. 317 URB. LOS PINOS",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "21",
      "CardCode": "C10100212051",
      "CardName": "SANCHEZ VILCHEZ WILLIAM GODOFREDO",
      "DateCreate": "2023-12-19",
      "Direccion": "JR. JOSE AGUILAR SEGURA Mz B Lt 23A A.H",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "22",
      "CardCode": "C20607295965",
      "CardName": "M&C LEYMA S.A.C.",
      "DateCreate": "2023-10-02",
      "Direccion": "PANAMERICANA NORTE KM 78 AA.HH SARITA COLONIA MZ",
      "Vendedor": "45 PALOMINO JIMENEZ ANGEL"
    },
    {
      "DocEntry": "23",
      "CardCode": "C20392592904",
      "CardName": "SERVICENTRO VIRGEN DE CHAPISAC",
      "DateCreate": "2024-03-01",
      "Direccion": "AV. PROCERES MZA. E LOTE. 15 URB. PROCERES",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "24",
      "CardCode": "C10445463006",
      "CardName": "TARRILLO LOZANO LEOVIGILDO MIGUEL ANGEL",
      "DateCreate": "2023-07-23",
      "Direccion": "MZA. A LOTE. 20 A.H. M.JESUS OROPEZA CHONTA",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "25",
      "CardCode": "C10070370170",
      "CardName": "GABRIEL DIAZ CLETO MARCELINO",
      "DateCreate": "2023-08-27",
      "Direccion": "AV. PASEO DE LA REPUBLICA NRO. 1441 URB. SANTA LEONOR ET. UNO.  LIMA - LIMA - CHORRILLOS",
      "Vendedor": "514 SUSAN OCHOA"
    },
    {
      "DocEntry": "26",
      "CardCode": "C40893731",
      "CardName": "ANCCO QUISPE VALENTINA",
      "DateCreate": "2023-12-31",
      "Direccion": "AV. PROCERES INDEPENDENCIA 3479",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "28",
      "CardCode": "C10096699056",
      "CardName": "ALEJOS VICENTE,SANDRA ROSA",
      "DateCreate": "2023-09-01",
      "Direccion": "CALL CORICANCHA NRO 725 URB ZARATE LIMA-LIMA-SAN JUAN LURIGANCHO",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    },
    {
      "DocEntry": "27",
      "CardCode": "C10472315523",
      "CardName": "PAREDES JACINTO JESUS ALBERTO",
      "DateCreate": "2024-02-10",
      "Direccion": "Av. Mariategui S/N. Puerta 5 Mercado 2 de Mayo",
      "Vendedor": "208 CORDOVA MASIAS JOSE DEL CARMEN"
    }
  ]
}
''';
