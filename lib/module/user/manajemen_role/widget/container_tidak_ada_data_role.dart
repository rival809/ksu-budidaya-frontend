// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerTidakAda extends StatefulWidget {
  final String? entity;
  const ContainerTidakAda({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  State<ContainerTidakAda> createState() => _ContainerTidakAdaState();
}

class _ContainerTidakAdaState extends State<ContainerTidakAda> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => Container(
        constraints: BoxConstraints.loose(
          Size.fromHeight(
            MediaQuery.of(context).size.height -
                144 -
                AppBar().preferredSize.height -
                32,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            width: 1.0,
            color: blueGray50,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            // Container(
            //   padding: const EdgeInsets.all(14),
            //   child: SvgPicture.asset(
            //     "assets/icons/info_progresif/tidak_ditemukan.svg",
            //     height: 107,
            //     width: 107,
            //   ),
            // ),
            // const SizedBox(
            //   height: 16.0,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Tidak ada data ${widget.entity}. ",
                    style: myTextTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Text(
              "Silakan Melakukan Pencarian data.",
              style: myTextTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      desktop: (context) => Container(
        constraints: BoxConstraints.loose(
          Size.fromHeight(
            MediaQuery.of(context).size.height -
                120 -
                AppBar().preferredSize.height -
                40,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            width: 1.0,
            color: blueGray50,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            // Container(
            //   padding: const EdgeInsets.all(14),
            //   child: SvgPicture.asset(
            //     "assets/icons/info_progresif/tidak_ditemukan.svg",
            //     height: 107,
            //     width: 107,
            //   ),
            // ),
            // const SizedBox(
            //   height: 16.0,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Tidak ada data ${widget.entity}.",
                    style: myTextTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Silakan lakukan ",
                style: myTextTheme.bodyLarge,
                children: <TextSpan>[
                  TextSpan(
                    text: "pencarian",
                    style: myTextTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
