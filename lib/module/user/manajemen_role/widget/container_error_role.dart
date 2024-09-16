// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerError extends StatefulWidget {
  const ContainerError({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerError> createState() => _ContainerErrorState();
}

class _ContainerErrorState extends State<ContainerError> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => Container(
        padding: const EdgeInsets.all(24),
        constraints: BoxConstraints.loose(
          Size.fromHeight(MediaQuery.of(context).size.height -
              144 -
              AppBar().preferredSize.height -
              48),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: gray300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   "assets/icons/info_progresif/gagal.svg",
            //   height: 150,
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),

            Text(
              "Terjadi kesalahan saat mengambil data.",
              textAlign: TextAlign.center,
              style: myTextTheme.bodyMedium,
            )
          ],
        ),
      ),
      desktop: (context) => Container(
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints.loose(
          Size.fromHeight(MediaQuery.of(context).size.height -
              120 -
              AppBar().preferredSize.height -
              40),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: gray300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   "assets/icons/info_progresif/gagal.svg",
            //   height: 150,
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            Text(
              "Terjadi kesalahan saat mengambil data.",
              textAlign: TextAlign.center,
              style: myTextTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
