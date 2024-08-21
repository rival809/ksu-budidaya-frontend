import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DashedLinePriceCard extends StatelessWidget {
  const DashedLinePriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (MediaQuery.of(context).size.width / 2 - 76).toInt(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Container(
                width: 8,
                height: 0.5,
                color: gray900,
              ),
              const SizedBox(
                width: 4,
              )
            ],
          );
        },
      ),
    );
  }
}
