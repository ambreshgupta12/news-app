import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/src/constants/asset_constants.dart';
import 'package:news_app/src/constants/string_constants.dart';
import 'package:news_app/src/resource/dimensions/dimensions.dart';
import 'package:news_app/src/resource/theme/text_themes.dart';

class WidgetFailureMessage extends StatelessWidget {
  final String errorTitle;
  final String errorSubtitle;

  WidgetFailureMessage({
    this.errorTitle = KString.youSeemToBeOffline,
    this.errorSubtitle =KString.checkYourWiFiConnectionInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SvgPicture.asset(
          AssetsConstant.undrawNewspaper,
          width: Dimens.px300,
          height: Dimens.px200,
        ),
        SizedBox(height: Dimens.px24),
        Text(
          errorTitle,
          style: TextThemes.h24
              ?.copyWith(fontSize: Dimens.px26, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimens.px8),
        Text(
          errorSubtitle,
          style: TextThemes.h24
              ?.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
