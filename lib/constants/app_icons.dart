import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  // Navigation icons
  static Widget classements({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Accueil_classements.svg',
        width: size ?? 24,
        height: size ?? 24,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  static Widget recherche({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Accueil_Recherche.svg',
        width: size ?? 24,
        height: size ?? 24,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  static Widget favoris({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Accueil_Favoris.svg',
        width: size ?? 24,
        height: size ?? 24,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  // Arrows
  static Widget flecheGauche({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Fleche_gauche.svg',
        width: size ?? 20,
        height: size ?? 20,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  static Widget flecheDroite({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Fleche_droite.svg',
        width: size ?? 20,
        height: size ?? 20,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  // Like buttons
  static Widget likeOff({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Like_off.svg',
        width: size ?? 24,
        height: size ?? 24,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  static Widget likeOn({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Like_on.svg',
        width: size ?? 24,
        height: size ?? 24,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  // Others
  static Widget etoile({double? size, Color? color}) => SvgPicture.asset(
        'assets/icons/Etoile.svg',
        width: size ?? 16,
        height: size ?? 16,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
}