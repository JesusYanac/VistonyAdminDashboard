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
  });

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
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
        if(state is SuccessTradeMarketingState){
          int numOfFiles = state.data!.length;
          if(numOfFiles > 0){
            int sucursales = Set.from(state.datafiltered!.map((s) => s.sucursal)).length;
            int numdays = state.ffin.difference(state.fini).inDays+1;
            int totalDocs = sucursales*5*5*numdays; // 5 documentos x 5 vendedores x 5 dias

            //limitar a dos decimales
            int efectivity = state.datafiltered!.length;

            int activeVendors = Set.from(state.datafiltered!.where((e) => e.trade == "Y").map((s) => s.vendedor)).length;
            int totalVendors = Set.from(state.datafiltered!.map((s) => s.vendedor)).length;


            List demoMyFiles = [
              CloudStorageInfo(
                title: "Total General",
                numOfFiles: totalDocs,
                svgSrc: "assets/icons/Documents.svg",
                totalStorage: "100%",
                color: primaryColor,
                percentage: totalDocs,
              ),
              CloudStorageInfo(
                title: "Efectividad",
                numOfFiles: totalDocs,
                svgSrc: "assets/icons/google_drive.svg",
                totalStorage: "$efectivity%",
                color: const Color(0xFFFFA113),
                percentage:  efectivity * 100 ~/ totalDocs,
              ),
              CloudStorageInfo(
                title: "Vendedores Activos",
                numOfFiles: activeVendors,
                svgSrc: "assets/icons/one_drive.svg",
                totalStorage: "100%",
                color: const Color(0xFFA4CDFF),
                percentage: activeVendors*100~/totalVendors,
              ),
              /*CloudStorageInfo(
                title: "PDVs",
                numOfFiles: locations,
                svgSrc: "assets/icons/drop_box.svg",
                totalStorage: "100%",
                color: const Color(0xFF007EE5),
                percentage: 100,
              ),*/
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
              itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
            );
          }else{
            return Container();
          }
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}