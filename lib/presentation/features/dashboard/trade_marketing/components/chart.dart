import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/constants.dart';

class PieChartForTwoValues extends StatefulWidget {
  const PieChartForTwoValues({
    super.key,
    required this.value,
    required this.total
  });

  final int value;
  final int total;

  @override
  State<PieChartForTwoValues> createState() => _PieChartForTwoValuesState();
}

class _PieChartForTwoValuesState extends State<PieChartForTwoValues> {
  @override
  Widget build(BuildContext context) {
    double value1 = widget.value / widget.total;
    double roundedValue1 = double.parse((value1 * 100).toStringAsFixed(1));
    double roundedValue2 = 100 - roundedValue1;

    List<PieChartSectionData> paiSelectionData = [
      PieChartSectionData(
        color: Colors.green,
        value: value1,
        showTitle: true,
        title: '$roundedValue1%',
        radius: 20+(value1/4),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 1 - value1,
        showTitle: true,
        title: '$roundedValue2%',
        radius: 20+((1 - value1)/4),
      )
    ];

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiSelectionData,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  "${widget.value}",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("de ${widget.total}", style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


