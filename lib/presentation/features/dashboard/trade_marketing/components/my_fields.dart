import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/models/my_files.dart';
import '../../../../core/constants.dart';
import '../../../../core/controllers/responsive.dart';
import '../bloc/trade_marketing_bloc.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    super.key,
    required this.headers,
    required this.searchText,
    required this.updateHeaders,
    required this.updateSearchText,
  });

  final Map<String,bool> headers;
  final String searchText;
  final Function updateHeaders;
  final Function updateSearchText;

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  late Map<String,bool> headers;
  late String searchText;
  @override
  void initState() {
    headers = widget.headers;
    searchText = widget.searchText;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant MyFiles oldWidget) {
    if(widget.headers != headers || widget.searchText != searchText) {
      setState(() {
        headers = widget.headers;
        searchText = widget.searchText;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Estadística de Archivos",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),*/
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: size.width < 650 ? 2 : 4,
            childAspectRatio: size.width < 650 && size.width > 350 ? 1.3 : 1,
          ),
          tablet: const FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}
class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeMarketingBloc, TradeMarketingState>(
      builder: (context, state) {
        if (state is SuccessTradeMarketingState) {
          var filteredData = state.datafilteredfull;

          int numTotalOfFiles = Set.from(filteredData!.map((e) => "${e.vendedor}${e.fecha}")).length*5;

          if (numTotalOfFiles > 0) {
            //int numCurrentFiles = Set.from(state.datafiltered!.map((e) => "${e.direccion}${e.fecha}")).length;
            int numCurrentFiles = state.datafiltered!.length;
            int numCurrentSucursal = Set.from(state.datafiltered!.map((e) => e.sucursal)).length;
            int numTotalSucursal = Set.from(filteredData.map((e) => e.sucursal)).length;
            int numTotalVendedor = Set.from(filteredData.map((e) => e.vendedor)).length;
            int numActualVendedor = Set.from(state.datafiltered!.map((e) => e.vendedor)).length;

            final List<CloudStorageInfo> demoMyFiles = [
              CloudStorageInfo(
                title: "Total General",
                numOfFiles: numTotalOfFiles,
                svgSrc: "assets/icons/Documents.svg",
                totalStorage: "100%",
                color: primaryColor,
                percentage: 100,
              ),
              CloudStorageInfo(
                title: "Efectividad",
                numOfFiles: numCurrentFiles,
                svgSrc: "assets/icons/google_drive.svg",
                totalStorage: "${numCurrentFiles * 100 ~/ numTotalOfFiles}%",
                color: const Color(0xFFFFA113),
                percentage: numCurrentFiles * 100 ~/ numTotalOfFiles,
              ),
              CloudStorageInfo(
                title: "Vendedores Activos",
                numOfFiles: numActualVendedor,
                svgSrc: "assets/icons/one_drive.svg",
                totalStorage: "${numActualVendedor * 100 ~/ numTotalVendedor}%",
                color: const Color(0xFFA4CDFF),
                percentage: numActualVendedor * 100 ~/ numTotalVendedor,
              ),
            ];

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: demoMyFiles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: widget.childAspectRatio,
              ),
              itemBuilder: (context, index) =>
                  FileInfoCard(info: demoMyFiles[index]),
            );
          }
          else {
            return Container();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
