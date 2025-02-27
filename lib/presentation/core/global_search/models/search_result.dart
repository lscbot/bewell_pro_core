import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bewell_pro_core/application/core/services/helpers.dart';
import 'package:bewell_pro_core/domain/core/value_objects/app_string_constants.dart';
import 'package:bewell_pro_core/domain/core/value_objects/asset_strings.dart';
import 'package:bewell_pro_core/domain/core/value_objects/type_defs.dart';
import 'package:bewell_pro_core/presentation/router/routes.dart';

class SearchResult {
  SearchResult({
    required this.name,
    required this.route,
    required this.image,
    required this.aliases,
    required this.onTap,
    this.role,
  });

  List<String> aliases;
  SvgPicture image;
  String name;
  NavigateToSearchResult onTap;
  String? route;
  String? role;
}

double searchIconHeight = 80.0;

List<SearchResult> searchResults = <SearchResult>[
  SearchResult(
    name: helpCenter,
    route: helpCenterRoute,
    aliases: <String>[
      'help',
      'help center',
      'center',
      'need help',
      'FAQS',
      'faqs',
      'FAQ',
      'faq'
    ],
    image: SvgPicture.asset(helpSearchIcon,
        height: searchIconHeight, width: searchIconHeight),
    onTap: (BuildContext context) async {
      await Navigator.of(context, rootNavigator: true)
          .pushNamed(helpCenterRoute);
    },
  ),

  //profile
  SearchResult(
    name: userProfile,
    // route: profileRoute,
    aliases: <String>[
      'profile',
      'prof',
      'my profile',
      'user profile',
      'profile info',
      'profile information'
    ],
    image: SvgPicture.asset(userProfileIconUrl,
        height: searchIconHeight, width: searchIconHeight),
    onTap: (BuildContext context) async {
      await Navigator.of(context, rootNavigator: true)
          .pushNamed(userProfileRoute);
    },
    route: '',
  ),

  //find patient
  SearchResult(
    name: patientFind,
    route: patientsPageRoute,
    role: patientStr,
    aliases: <String>[
      'find a patient',
      'find patient',
      'find my patient',
      'patient find',
      'search patient',
      'search for a patient',
      'search a patient',
      'patient search'
    ],
    image: SvgPicture.asset(findPatientIconUrl,
        height: searchIconHeight, width: searchIconHeight),
    onTap: (BuildContext context) =>
        triggerNavigationEvent(context: context, route: patientsPageRoute),
  ),

  // add patient
  SearchResult(
      name: patientAdd,
      role: patientStr,
      route: addPatientRoute,
      aliases: <String>[
        'add a patient',
        'add patient',
        'add my patient',
        'patient add',
        'register patient',
        'patient registration',
        'register a patient',
        'patient register'
      ],
      image: SvgPicture.asset(addPatientIconUrl,
          height: searchIconHeight, width: searchIconHeight),
      onTap: (BuildContext context) =>
          triggerNavigationEvent(context: context, route: addPatientRoute)),
];
