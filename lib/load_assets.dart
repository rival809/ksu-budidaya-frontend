import 'package:ksu_budidaya/core.dart';

Future loadSVG() async {
  await precachePicture(
    ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
        'assets/images/illustration/default.svg'),
    null,
  );
  await precachePicture(
    ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
        'assets/images/illustration/not_found_info_pab.svg'),
    null,
  );
}
