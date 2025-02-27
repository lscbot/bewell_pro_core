import 'package:async_redux/async_redux.dart';
import 'package:bewell_pro_core/application/redux/states/core_state.dart';
import 'package:domain_objects/entities.dart';

class CommunicationSettingsViewModel extends Vm {
  final bool? allowText;
  final bool? allowPush;
  final bool? allowEmail;
  final bool? allowWhatsApp;

  CommunicationSettingsViewModel({
    required this.allowEmail,
    required this.allowPush,
    required this.allowText,
    required this.allowWhatsApp,
  }) : super(equals: <bool>[
          allowEmail!,
          allowPush!,
          allowText!,
          allowWhatsApp!
        ]);

  static CommunicationSettingsViewModel fromStore(Store<CoreState> store) {
    final CommunicationSettings? settings =
        store.state.userState!.communicationSettings;

    return CommunicationSettingsViewModel(
      allowEmail: settings!.allowEmail,
      allowPush: settings.allowPush,
      allowText: settings.allowText,
      allowWhatsApp: settings.allowWhatsApp,
    );
  }
}
