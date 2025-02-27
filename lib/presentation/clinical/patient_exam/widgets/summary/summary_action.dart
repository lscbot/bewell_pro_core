import 'dart:async';

import 'package:app_wrapper/app_wrapper.dart';
import 'package:async_redux/async_redux.dart';
import 'package:bewell_pro_core/application/redux/states/core_state.dart';
import 'package:domain_objects/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_client/graph_utils.dart';
import 'package:bewell_pro_core/application/redux/flags/flags.dart';

class SummaryAction extends ReduxAction<CoreState> {
  SummaryAction({
    this.doctorsEmail,
    this.phoneNumber,
    required this.disabled,
    required this.context,
  });

  final String? doctorsEmail;
  final String? phoneNumber;
  final bool disabled;
  final BuildContext context;

  @override
  void before() {
    // show a loading indicator
    dispatch(WaitAction<CoreState>.add(summaryExamFlag));
  }

  @override
  Future<CoreState?> reduce() async {
    if (!disabled) {
      final String phoneNumber = StoreProvider.state<CoreState>(context)!
          .userState!
          .userProfile!
          .primaryPhoneNumber!
          .getValue();

      await GraphQlUtils().sendOtp(
        client: AppWrapperBase.of(context)!.graphQLClient,
        phoneNumber: phoneNumber,
        email: doctorsEmail == UNKNOWNEMAIL ? null : doctorsEmail,
        logTitle: 'Exam summary : send OTP',
      );
    }

    return null;
  }

  @override
  void after() {
    // remove the loading indicator
    dispatch(WaitAction<CoreState>.remove(summaryExamFlag));
  }
}
