class TradeMarketingEntity {
  String? status;
  List<TradeMarketingHeader>? data;

  TradeMarketingEntity({this.status = "N", this.data});

  factory TradeMarketingEntity.fromJson(Map<String, dynamic> json) {
    return TradeMarketingEntity(
      status: json['status'] ?? "N",
      data: List<TradeMarketingHeader>.from(
          json['data']?.map((x) => TradeMarketingHeader.fromJson(x)) ?? []),
    );
  }

  @override
  String toString() {
    return 'TradeMarketingEntity{status: $status, data: $data}';
  }
}

class TradeMarketingHeader {
  final String sucursal;
  final String? fecha;
  final String? vendedor;
  final String? cardCode;
  final String? cliente;
  final String? direccion;
  final String? trade;
  final String? docEntry;

  TradeMarketingHeader({
    this.sucursal = "",
    this.vendedor = "",
    this.cardCode = "",
    this.cliente = "",
    this.direccion = "",
    this.trade = "",
    this.docEntry = "",
    this.fecha = "",
  });

  factory TradeMarketingHeader.fromJson(Map<String, dynamic> json) {
    return TradeMarketingHeader(
      sucursal: json['Sucursal'] ?? "",
      vendedor: json['Vendedor'] ?? "",
      cardCode: json['CardCode'] ?? "",
      cliente: json['Cliente'] ?? "",
      direccion: json['Direccion'] ?? "",
      trade: json['Trade'] ?? "",
      docEntry: json['DocEntry'] ?? "",
      fecha: json['Fecha'] ?? "",
    );
  }

  @override
  String toString() {
    return 'TradeMarketingHeader{Sucursal: $sucursal, Fecha: $fecha, Vendedor: $vendedor, CardCode: $cardCode, Cliente: $cliente, Direccion: $direccion, Trade: $trade, DocEntry: $docEntry}';
  }

}

class TradeMarketingPageModel {
  int id;
  String? idDocument;
  String? chkrecibido;
  List<TradeMarketingSection>? sectionList;
  String? dateCreation;
  String? dateCompletion;
  String? imei;
  String? cardCode;
  String? cardName;
  String? shipToCode;

  TradeMarketingPageModel({
    this.id = 0,
    this.idDocument,
    this.chkrecibido = "N",
    this.sectionList,
    this.dateCreation = "",
    this.dateCompletion = "",
    this.imei,
    this.cardCode,
    this.cardName,
    this.shipToCode,
  });

  factory TradeMarketingPageModel.fromJson(Map<String, dynamic> json) {
    return TradeMarketingPageModel(
      id: json['id'] ?? 0,
      idDocument: json['IdDocument'] ?? "0",
      chkrecibido: json['chkrecibido'] ?? "N",
      sectionList: List<TradeMarketingSection>.from(
          json['Section']?.map((x) => TradeMarketingSection.fromJson(x)) ?? []),
      dateCreation: json['DateCreation'] ?? "",
      dateCompletion: json['DateCompletion'] ?? "",
      imei: json['Imei'] ?? "",
      cardCode: json['cardCode'] ?? "",
      cardName: json['cardName'] ?? "",
      shipToCode: json['shipToCode'] ?? "",
    );
  }

  @override
  String toString() {
    return 'TradeMarketingPageModel{id: $id, idDocument: $idDocument, chkrecibido: $chkrecibido, sectionList: $sectionList, dateCreation: $dateCreation, dateCompletion: $dateCompletion, imei: $imei, cardCode: $cardCode, cardName: $cardName, shipToCode: $shipToCode}';
  }
}

class TradeMarketingSection {
  int id;
  String? idDocument;
  List<TradeMarketingSubSection>? subSectionList;
  String? description;
  int file;
  String order;

  TradeMarketingSection({
    this.id = 0,
    this.idDocument,
    this.subSectionList,
    this.description,
    this.file = 0,
    this.order = "0",
  });

  factory TradeMarketingSection.fromJson(Map<String, dynamic> json) {
    return TradeMarketingSection(
      id: json['id'] ?? 0,
      idDocument: json['IdDocument'] ?? "0",
      subSectionList: List<TradeMarketingSubSection>.from(json['SubSeccion']
              ?.map((x) => TradeMarketingSubSection.fromJson(x)) ??
          []),
      description: json['U_Descr'] ?? "",
      file: json['U_File'] ?? 0,
      order: json['U_Order'] ?? "0",
    );
  }

  @override
  String toString() {
    return 'TradeMarketingSection{id: $id, idDocument: $idDocument, subSectionList: $subSectionList, description: $description, file: $file, order: $order}';
  }
}

class TradeMarketingSubSection {
  int id;
  String? idDocument;
  int docEntry;
  List<TradeMarketingForm>? formList;
  String? tituloSubSeccion;

  TradeMarketingSubSection({
    this.id = 0,
    this.idDocument,
    this.docEntry = 0,
    this.formList,
    this.tituloSubSeccion,
  });

  factory TradeMarketingSubSection.fromJson(Map<String, dynamic> json) {
    return TradeMarketingSubSection(
      id: json['id'] ?? 0,
      idDocument: json['IdDocument'] ?? "0",
      docEntry: json['DocEntry'] ?? 0,
      formList: List<TradeMarketingForm>.from(
          json['Formulario']?.map((x) => TradeMarketingForm.fromJson(x)) ?? []),
      tituloSubSeccion: json['Titulo_SubSeccion'] ?? "",
    );
  }

  @override
  String toString() {
    return 'TradeMarketingSubSection{id: $id, idDocument: $idDocument, docEntry: $docEntry, formList: $formList, tituloSubSeccion: $tituloSubSeccion}';
  }
}

class TradeMarketingForm {
  int id;
  String? idDocument;
  int docEntry;
  List<TradeMarketingQuestion>? questionList;
  int file;
  String order;
  String? title;
  String? base64;
  String? url;

  TradeMarketingForm({
    this.id = 0,
    this.idDocument,
    this.docEntry = 0,
    this.questionList,
    this.file = 0,
    this.order = "0",
    this.title,
    this.base64,
    this.url,
  });

  factory TradeMarketingForm.fromJson(Map<String, dynamic> json) {
    return TradeMarketingForm(
      id: json['id'] ?? 0,
      idDocument: json['IdDocument'] ?? "0",
      docEntry: json['DocEntry'] ?? 0,
      questionList: List<TradeMarketingQuestion>.from(
          json['Preguntas']?.map((x) => TradeMarketingQuestion.fromJson(x)) ??
              []),
      file: json['U_File'] ?? 0,
      order: json['U_Order'] ?? "0",
      title: json['U_Title'] ?? "",
      base64: json['Base64'] ?? "",
      url: json['Url'] ?? "",
    );
  }

  @override
  String toString() {
    return 'TradeMarketingForm{id: $id, idDocument: $idDocument, docEntry: $docEntry, questionList: $questionList, file: $file, order: $order, title: $title, base64: $base64, url: $url}';
  }
}

class TradeMarketingQuestion {
  int id;
  String? idDocument;
  int docEntry;
  List<TradeMarketingAnswer>? answerList;
  String? description;
  String order;
  int question;
  String? type;
  String? responsevalue;
  String? base64;
  String? url;

  TradeMarketingQuestion({
    this.id = 0,
    this.idDocument,
    this.docEntry = 0,
    this.answerList,
    this.description,
    this.order = "0",
    this.question = 0,
    this.type,
    this.responsevalue,
    this.base64,
    this.url,
  });

  factory TradeMarketingQuestion.fromJson(Map<String, dynamic> json) {
    return TradeMarketingQuestion(
      id: json['id'] ?? 0,
      idDocument: json['IdDocument'] ?? "0",
      docEntry: json['DocEntry'] ?? 0,
      answerList: List<TradeMarketingAnswer>.from(
          json['Respuestas']?.map((x) => TradeMarketingAnswer.fromJson(x)) ??
              []),
      description: json['U_Descr'] ?? "",
      order: json['U_Order'] ?? "0",
      question: json['U_Question'] ?? 0,
      type: json['U_Type'] ?? "",
      responsevalue: json['U_Responsevalue'] ?? "",
      base64: json['Base64'] ?? "",
      url: json['Url'] ?? "",
    );
  }

  @override
  String toString() {
    return 'TradeMarketingQuestion{id: $id, idDocument: $idDocument, docEntry: $docEntry, answerList: $answerList, description: $description, order: $order, question: $question, type: $type, responsevalue: $responsevalue, base64: $base64, url: $url}';
  }
}

class TradeMarketingAnswer {
  int id;
  String? idDocument;
  String? order;
  String? answer;
  String? responsevalue;

  TradeMarketingAnswer({
    this.id = 0,
    this.idDocument,
    this.order,
    this.answer,
    this.responsevalue = "",
  });

  factory TradeMarketingAnswer.fromJson(Map<String, dynamic> json) {
    return TradeMarketingAnswer(
      id: json['id'] ?? 0,
      idDocument: json['IdDocument'] ?? "0",
      order: json['U_Order'] ?? "",
      answer: json['U_answer'] ?? "",
      responsevalue: json['U_Responsevalue'] ?? "",
    );
  }

  @override
  String toString() {
    return 'TradeMarketingAnswer{id: $id, idDocument: $idDocument, order: $order, answer: $answer, responsevalue: $responsevalue}';
  }
}
