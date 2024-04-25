import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../../data/model/trade_marketing_model.dart';
import '../../../../generated/assets.dart';
import '../../../core/constants.dart';
import '../../../core/controllers/responsive.dart';
import 'bloc/form_trade_marketing_bloc.dart';

class FileSelected extends StatefulWidget {
  const FileSelected(
      {super.key,
      required this.callback,
      required this.vendorName,
      required this.clientAddress});
  final String vendorName;
  final String clientAddress;

  final Function callback;

  @override
  State<FileSelected> createState() => _FileSelectedState();
}

class _FileSelectedState extends State<FileSelected> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormTradeMarketingBloc, FormTradeMarketingState>(
        builder: (context, state) {
      if (state is LoadingFormTradeMarketingState) {
        //mostrar rive animation
        return SizedBox(
          height: MediaQuery.of(context).size.width * 0.35,
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.20,
                    child: const RiveAnimation.asset(
                      Assets.riveAnimationsEparLoading,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ]),
          ),
        );
      }
      if (state is SuccessFormTradeMarketingState) {
        return Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FileSelectedHeader(
                tradeMarketingPageModel: state.data,
                callback: widget.callback,
                vendorName: widget.vendorName,
                clientAddress: widget.clientAddress,
              ),
              if (!Responsive.isMobile(context))
                Column(
                  children: [
                    for (int i = 0; i < state.data!.sectionList!.length; i += 2)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.black.withOpacity(
                                  0.2), // Fondo negro con opacidad para la fila de cabecera
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  for (int j = i;
                                      j < i + 2 &&
                                          j < state.data!.sectionList!.length;
                                      j++)
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: FormSectionTradeMarketing(
                                          section: state.data!.sectionList![j],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              if (Responsive.isMobile(context))
                Column(
                  children: [
                    for (int i = 0; i < state.data!.sectionList!.length; i++)
                      FormSectionTradeMarketing(
                        section: state.data!.sectionList![i],
                      ),
                  ],
                ),
            ],
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.callback();
                },
                child: const Row(
                  children: [
                    //arrow back
                    Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: Colors.white),
                    SizedBox(width: defaultPadding / 2),
                    Text(
                      "Regresar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    child: const RiveAnimation.asset(
                      Assets.riveAnimationsAlien404Screen,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}

class FormSectionTradeMarketing extends StatefulWidget {
  const FormSectionTradeMarketing({super.key, required this.section});
  final TradeMarketingSection section;

  @override
  State<FormSectionTradeMarketing> createState() =>
      _FormSectionTradeMarketingState();
}

class _FormSectionTradeMarketingState extends State<FormSectionTradeMarketing> {
  late final TradeMarketingSection section;
  @override
  void initState() {
    section = widget.section;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormSectionTradeMarketing oldWidget) {
    if (widget.section != section) {
      setState(() {
        section = widget.section;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (widget.section != section) {
      setState(() {
        section = widget.section;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              child: Text(
                "${section.description}", //page
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: primaryColor),
              ),
            ),
          ],
        ),
        for (var element in section.subSectionList!)
          FormSubSectionTradeMarketing(subSection: element),
      ],
    );
  }
}

class FormSubSectionTradeMarketing extends StatefulWidget {
  const FormSubSectionTradeMarketing({super.key, required this.subSection});
  final TradeMarketingSubSection subSection;

  @override
  State<FormSubSectionTradeMarketing> createState() =>
      _FormSubSectionTradeMarketingState();
}

class _FormSubSectionTradeMarketingState
    extends State<FormSubSectionTradeMarketing> {
  late final TradeMarketingSubSection subSection;
  @override
  void initState() {
    subSection = widget.subSection;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormSubSectionTradeMarketing oldWidget) {
    if (widget.subSection != subSection) {
      setState(() {
        subSection = widget.subSection;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (widget.subSection != subSection) {
      setState(() {
        subSection = widget.subSection;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${subSection.tituloSubSeccion}"),
            ],
          ),
          for (var subElement in subSection.formList!)
            FormElementTradeMarketing(element: subElement),
        ],
      ),
    );
  }
}

class FormElementTradeMarketing extends StatefulWidget {
  const FormElementTradeMarketing({super.key, required this.element});
  final TradeMarketingForm element;

  @override
  State<FormElementTradeMarketing> createState() =>
      _FormElementTradeMarketingState();
}

class _FormElementTradeMarketingState extends State<FormElementTradeMarketing> {
  late final TradeMarketingForm element;
  @override
  void initState() {
    element = widget.element;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormElementTradeMarketing oldWidget) {
    if (widget.element != element) {
      setState(() {
        element = widget.element;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (widget.element != element) {
      setState(() {
        element = widget.element;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "${element.title}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: primaryColor,
                        fontSize: 20,
                      ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                String url = element.url ?? "";
                final scaffoldmessenger = ScaffoldMessenger.of(context);
                if (url !=
                    "" /*&& await canLaunchUrl(Uri.parse("https://cors-anywhere.herokuapp.com/$url"))*/) {
                  //await launchUrl(Uri.parse("https://cors-anywhere.herokuapp.com/$url"));
                  showPopUpImage(context, url, element.title ?? "");
                } else {
                  scaffoldmessenger.clearSnackBars();
                  scaffoldmessenger.showSnackBar(
                    SnackBar(
                      content: const Text('No se puede abrir el link'),
                      backgroundColor: primaryColor2.withOpacity(0.6),
                    ),
                  );
                }
              },
              icon: Icon(
                element.url != "" ? Icons.link : Icons.link_off,
                color: element.url != "" ? primaryColor : primaryColor2,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60.0,
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.image),
                        ),
                        Expanded(
                            flex: 60,
                            child: Text(
                              'Evaluación',
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                        Expanded(
                            flex: 40,
                            child: Text('Respuesta',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  for (int i = 0; i < element.questionList!.length; i++)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        color: (i % 2 != 0)
                            ? const Color.fromRGBO(0, 0, 0, 0.2)
                            : const Color.fromRGBO(255, 255, 255, 0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60.0,
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () async {
                                final scaffoldmessenger =
                                    ScaffoldMessenger.of(context);
                                String url = element.questionList![i].url ?? "";
                                if (url !=
                                        "" /* &&
                                    await canLaunchUrl(Uri.parse(url))*/
                                    ) {
                                  // await launchUrl(Uri.parse(url));

                                  showPopUpImage(
                                      context,
                                      url,
                                      element.questionList![i].description ??
                                          "");
                                } else {
                                  scaffoldmessenger.clearSnackBars();
                                  scaffoldmessenger.showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'No se puede abrir el link'),
                                      backgroundColor:
                                          primaryColor2.withOpacity(0.6),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                (element.questionList![i].url != "")
                                    ? Icons.link
                                    : Icons.link_off,
                                color: (element.questionList![i].url != "")
                                    ? primaryColor
                                    : primaryColor2,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 60,
                              child: Text(
                                  "${element.questionList![i].description}")),
                          if (element.questionList![i].type == "RM")
                            Expanded(
                              flex: 40,
                              child: Row(
                                children: [
                                  for (var item
                                      in element.questionList![i].answerList!)
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: item.responsevalue == "true"
                                              ? primaryColor.withOpacity(0.6)
                                              : primaryColor2.withOpacity(0.6),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 8.0),
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "${item.answer}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          if (element.questionList![i].type == "RT")
                            Expanded(
                              flex: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${(element.questionList![i].responsevalue == null || element.questionList![i].responsevalue == "") ? "-" : element.questionList![i].responsevalue}"),
                                ],
                              ),
                            ),
                          if (element.questionList![i].type == "RL")
                            Expanded(
                              flex: 40,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (var item
                                      in element.questionList![i].answerList!)
                                    if (item.responsevalue == "true")
                                      Expanded(
                                        child: Container(
                                          /*color: (item.responsevalue ==
                                                    "true")
                                                ? primaryColor.withOpacity(0.6)
                                                : primaryColor2
                                                    .withOpacity(0.6),*/
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 8.0),
                                          child: Center(
                                            child: Text("${item.answer}"),
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showPopUpImage(BuildContext context, String url, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          content: Container(
            height: MediaQuery.of(context).size.width * 0.8,
            width: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width * 0.5
                : Responsive.isTablet(context)
                    ? MediaQuery.of(context).size.width * 0.8
                    : MediaQuery.of(context).size.width * 0.9,
            color: bgColor,
            child: // imagen con loading builder
            CachedNetworkImage(
              imageUrl: "https://cors-anywhere.herokuapp.com/$url",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: LinearProgressIndicator(
                        backgroundColor: primaryColor2, // Fondo gris
                        valueColor: const AlwaysStoppedAnimation<Color>(primaryColor), // Color de carga rojo
                        value: downloadProgress.progress,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
            )
,
          ),
          title: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cerrar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class FileSelectedHeader extends StatefulWidget {
  const FileSelectedHeader(
      {super.key,
      required this.tradeMarketingPageModel,
      required this.callback,
      required this.vendorName,
      required this.clientAddress});
  final TradeMarketingPageModel? tradeMarketingPageModel;
  final Function callback;
  final String vendorName;
  final String clientAddress;

  @override
  State<FileSelectedHeader> createState() => _FileSelectedHeaderState();
}

class _FileSelectedHeaderState extends State<FileSelectedHeader> {
  late final TradeMarketingPageModel? tradeMarketingPageModel;
  late final String vendorName;
  late final String clientAddress;
  @override
  void initState() {
    tradeMarketingPageModel = widget.tradeMarketingPageModel;
    vendorName = widget.vendorName;
    clientAddress = widget.clientAddress;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FileSelectedHeader oldWidget) {
    if (widget.tradeMarketingPageModel != tradeMarketingPageModel ||
        widget.vendorName != vendorName ||
        widget.clientAddress != clientAddress) {
      setState(() {
        tradeMarketingPageModel = widget.tradeMarketingPageModel;
        vendorName = widget.vendorName;
        clientAddress = widget.clientAddress;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (widget.tradeMarketingPageModel != tradeMarketingPageModel ||
        widget.vendorName != vendorName ||
        widget.clientAddress != clientAddress) {
      setState(() {
        tradeMarketingPageModel = widget.tradeMarketingPageModel;
        vendorName = widget.vendorName;
        clientAddress = widget.clientAddress;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonBack = Row(
      children: [
        InkWell(
          onTap: () {
            widget.callback();
          },
          child: const Row(
            children: [
              //arrow back
              Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: Colors.white),
              SizedBox(width: defaultPadding / 2),
              Text(
                "Regresar",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              buttonBack,
              Text("Formulario del punto de Venta",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: primaryColor)),
              RowIconData(
                icon: Icons.calendar_month_outlined,
                data: "${tradeMarketingPageModel?.dateCreation}",
              ),
              RowIconData(
                icon: Icons.support_agent,
                data: vendorName,
              ),
              RowIconData(
                icon: Icons.person,
                data: "${tradeMarketingPageModel?.cardName}",
              ),
              RowIconData(
                icon: Icons.pin_drop,
                data: clientAddress,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RowIconData extends StatelessWidget {
  const RowIconData({super.key, required this.icon, required this.data});

  final IconData icon;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            data,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
