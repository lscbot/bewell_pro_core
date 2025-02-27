import 'dart:convert';

import 'package:app_wrapper/app_wrapper.dart';
import 'package:async_redux/async_redux.dart';
import 'package:bewell_pro_core/application/redux/states/core_state.dart';
import 'package:bewell_pro_core/application/redux/states/user_state.dart';
import 'package:bewell_pro_core/application/core/services/helpers.dart';
import 'package:bewell_pro_core/application/core/services/onboarding.dart';
import 'package:bewell_pro_core/application/redux/actions/navigation_actions/navigation_action.dart';
import 'package:bewell_pro_core/application/redux/flags/flags.dart';
import 'package:bewell_pro_core/domain/clinical/value_objects/system_enums.dart';
import 'package:bewell_pro_core/domain/core/entities/onboarding_path_config.dart';
import 'package:bewell_pro_core/domain/core/entities/processed_response.dart';
import 'package:bewell_pro_core/domain/core/value_objects/exception_strings.dart';
import 'package:bewell_pro_core/domain/core/value_objects/events.dart';
import 'package:dart_fcm/dart_fcm.dart';
import 'package:domain_objects/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_graphql_client/graph_client.dart';
import 'package:http/http.dart';
import 'package:misc_utilities/misc.dart';
import 'package:user_feed/user_feed.dart';

/// [PhoneSignUpAction] called when creating an account
class PhoneSignUpAction extends ReduxAction<CoreState> {
  PhoneSignUpAction({required this.context});

  final BuildContext context;

  @override
  void before() {
    dispatch(WaitAction<CoreState>.add(createUserFlag));
  }

  @override
  void after() {
    dispatch(WaitAction<CoreState>.remove(createUserFlag));
  }

  @override
  Future<CoreState?> reduce() async {
    /// Call endpoint and get back profile and custom token
    final String createAccountEndpoint =
        EndpointContext.createUserByPhoneEndpoint(
            AppWrapperBase.of(this.context)!.appContexts);

    final IGraphQlClient client = AppWrapperBase.of(context)!.graphQLClient;

    final Map<String, String> variables = <String, String>{
      'phoneNumber': state.miscState!.phoneNumber!,
      'otp': state.miscState!.otpCode!,
      'flavour': Flavour.PRO.name,
      'pin': state.miscState!.pinCode!,
    };

    final ProcessedResponse processedResponse = processResponse(
        await SimpleCall.callRestAPI(
          endpoint: createAccountEndpoint,
          method: AppRequestTypes.POST.name,
          variables: variables,
          graphClient: client,
          raw: true,
        ) as Response,
        context);

    if (processedResponse.ok) {
      final Response response = processedResponse.response;

      // decode the response
      final Map<String, dynamic> responseMap =
          json.decode(response.body) as Map<String, dynamic>;

      final UserResponse responseAsObject = UserResponse.fromJson(responseMap);

      final UserState? newUserState = store.state.userState?.copyWith.call(
        userProfile: responseAsObject.profile,
        customerProfile: responseAsObject.customerProfile,
        communicationSettings: responseAsObject.communicationSettings,
        auth: responseAsObject.auth,
        isSignedIn: true,
        inActivitySetInTime: DateTime.now().toIso8601String(),
        signedInTime: DateTime.now().toIso8601String(),
      );

      final CoreState newState = state.copyWith(userState: newUserState);

      await StoreProvider.dispatch<CoreState>(
        context,
        NavigationAction(
            drawerSelectedIndex:
                responseAsObject.navigation?.drawerSelectedIndex,
            primaryActions: responseAsObject.navigation?.primaryActions,
            secondaryActions: responseAsObject.navigation?.secondaryActions),
      );

      await saveDeviceToken(client: client, fcm: SILFCM());

      final OnboardingPathConfig path = onboardingPath(state: state);

      triggerEvent(signupEvent, context);

      dispatch(NavigateAction<CoreState>.pushNamedAndRemoveAll(path.route));

      return newState;
    } else {
      await captureException(
        errorPhoneSignup,
        error: processedResponse.message,
        response: processedResponse.response.body,
        variables: variables,
      );
      throw UserException(processedResponse.message);
    }
  }

  @override
  Object? wrapError(dynamic error) {
    if (error.runtimeType == UserException) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar(content: (error as UserException).msg));

      return null;
    }

    return error;
  }
}
