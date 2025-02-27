import 'package:flutter/material.dart';
import 'package:bewell_pro_core/domain/core/value_objects/app_string_constants.dart';
import 'package:bewell_pro_core/presentation/onboarding/profile/communication_settings.dart';
import 'package:bewell_pro_core/presentation/onboarding/profile/profile_contact_details.dart';
import 'package:bewell_pro_core/presentation/onboarding/profile/pages/try_new_features_page.dart';
import 'package:bewell_pro_core/presentation/router/routes.dart';

class ProfileItem {
  const ProfileItem({
    required this.text,
    required this.onTapRoute,
    required this.section,
    this.onTapRouteArguments,
    this.isComingSoon = false,
    this.tabletWidget,
  });

  final bool isComingSoon;
  final String onTapRoute;
  final Map<String, dynamic>? onTapRouteArguments;
  final ProfileItemType section;
  final Widget? tabletWidget;
  final String text;
}

enum ProfileItemType {
  account,
  legal,
}

/// A list of Widgets that holds profile items to be displayed in the user_profile_page
/// They are displayed as tiles which when tapped navigate the user to the specif profile item's page
/// This allows users to change settings, manage accounts and view terms & conditions
List<ProfileItem> profileItems = <ProfileItem>[
  ProfileItem(
    text: contactInfo,
    section: ProfileItemType.account,
    onTapRoute: profileContactDetailsRoute,
    tabletWidget: BuildContactProvider(),
  ),
  ProfileItem(
    text: communicationSettingsText,
    section: ProfileItemType.account,
    onTapRoute: commSettingsRoute,
    tabletWidget: BuildCommunicationItems(),
  ),
  const ProfileItem(
    text: changePINText,
    section: ProfileItemType.account,
    onTapRoute: pinVerificationRoute,
  ),
  ProfileItem(
    text: tryNewFeaturesText,
    section: ProfileItemType.account,
    onTapRoute: tryNewFeatureSettingsRoute,
    tabletWidget: BuildTryNewFeatures(),
  ),
  const ProfileItem(
    text: termsOfServiceText,
    section: ProfileItemType.legal,
    onTapRoute: webViewRoute,
  ),
];
