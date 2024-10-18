import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_selector/flutter_country_selector.dart';

class CountryButton extends StatelessWidget {
  final Function()? onTap;
  final IsoCode isoCode;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final double flagSize;
  final bool showFlag;
  final double flagSpace;
  final bool showDialCode;

  final bool showIsoCode;
  final double isoCodeSpace;

  final bool showDropdownIcon;
  final Widget? dropDownIcon;

  final bool enabled;

  const CountryButton({
    super.key,
    required this.isoCode,
    required this.onTap,
    this.textStyle,
    this.padding = const EdgeInsets.fromLTRB(12, 16, 4, 16),
    this.flagSize = 20,
    this.showFlag = true,
    this.showDialCode = true,
    this.showIsoCode = false,
    this.showDropdownIcon = true,
    this.enabled = true,
    this.dropDownIcon,
    this.isoCodeSpace = 8,
    this.flagSpace = 8,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16) ??
        const TextStyle();
    final countryLocalization = CountrySelectorLocalization.of(context) ??
        CountrySelectorLocalizationEn();
    final countryDialCode = '+ ${countryLocalization.countryDialCode(isoCode)}';

    const Icon defaultIcon = Icon(Icons.arrow_drop_down);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showIsoCode) ...[
              Text(
                isoCode.name,
                style: textStyle.copyWith(
                  color: enabled ? null : Theme.of(context).disabledColor,
                ),
              ),
              SizedBox(width: isoCodeSpace),
            ],
            if (showFlag) ...[
              ExcludeSemantics(
                child: CircleFlag(
                  isoCode.name,
                  size: flagSize,
                ),
              ),
              SizedBox(width: flagSpace),
            ],
            if (showDialCode) ...[
              Text(
                countryDialCode,
                style: textStyle.copyWith(
                  color: enabled ? null : Theme.of(context).disabledColor,
                ),
              ),
            ],
            if (showDropdownIcon)
              ExcludeSemantics(
                child: dropDownIcon ?? defaultIcon,
              ),
          ],
        ),
      ),
    );
  }
}
