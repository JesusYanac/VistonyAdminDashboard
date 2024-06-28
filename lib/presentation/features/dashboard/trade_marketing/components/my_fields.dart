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
    this.crossAxisCount = 4,
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
          int numOfFiles = state.datafiltered!.length;
          if(numOfFiles > 0){
            int differentNames = Set.from(state.datafiltered!.map((persona) => persona.vendedor)).length;
            int locations = Set.from(state.datafiltered!.map((persona) => persona.direccion)).length;
            int totalDocs = differentNames*5;

            List demoMyFiles = [
              CloudStorageInfo(
                title: "Total",
                numOfFiles: totalDocs,
                svgSrc: "assets/icons/Documents.svg",
                totalStorage: "100%",
                color: primaryColor,
                percentage: 100,
              ),
              CloudStorageInfo(
                title: "Realizados",
                numOfFiles: numOfFiles,
                svgSrc: "assets/icons/google_drive.svg",
                totalStorage: "${numOfFiles*100~/totalDocs}%",
                color: const Color(0xFFFFA113),
                percentage: numOfFiles*100~/totalDocs,
              ),
              CloudStorageInfo(
                title: "Faltantes",
                numOfFiles: totalDocs-numOfFiles,
                svgSrc: "assets/icons/one_drive.svg",
                totalStorage: "${(totalDocs-numOfFiles)*100~/totalDocs}%",
                color: const Color(0xFFA4CDFF),
                percentage: (totalDocs-numOfFiles)*100~/totalDocs,
              ),
              CloudStorageInfo(
                title: "PDVs",
                numOfFiles: locations,
                svgSrc: "assets/icons/drop_box.svg",
                totalStorage: "100%",
                color: const Color(0xFF007EE5),
                percentage: 100,
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