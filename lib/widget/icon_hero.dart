import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WraleIconColorMapper implements ColorMapper {
  const WraleIconColorMapper({
    required this.bgColor,
    required this.wolfColor,
    required this.titleColor,
    required this.sloganColor,
  });

  static const Color _defaultBgColor = Color(0xff44464f);
  static const Color _defaultWolfColor = Color(0xffdae2ff);
  static const Color _defaultTitleColor = Color(0xff1b1b1f);
  static const Color _defaultSloganColor = Color(0xff0161a3);

  final Color bgColor;
  final Color wolfColor;
  final Color titleColor;
  final Color sloganColor;

  @override
  Color substitute(
      String? id, String elementName, String attributeName, Color color) {
    if (color == _defaultBgColor) {
      return bgColor;
    } else if (color == _defaultWolfColor) {
      return wolfColor;
    } else if (color == _defaultTitleColor) {
      return titleColor;
    } else if (color == _defaultSloganColor) {
      return sloganColor;
    }

    return color;
  }
}

class IconHero extends StatefulWidget {
  const IconHero({super.key});

  @override
  State<IconHero> createState() => _IconHeroState();
}

class _IconHeroState extends State<IconHero> {
  // path to rive file
  static const String assetName = 'assets/wrale_icon_extended.svg';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SvgPicture(
      SvgAssetLoader(
        assetName,
        colorMapper: WraleIconColorMapper(
          bgColor: colorScheme.onSurfaceVariant,
          wolfColor: colorScheme.primaryContainer,
          titleColor: colorScheme.onSurface,
          sloganColor: colorScheme.primary,
        ),
      ),
    );
  }
}
