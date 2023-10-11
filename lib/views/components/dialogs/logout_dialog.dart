import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/views/components/constants/strings.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogutDialog extends AlertDialogModel<bool> {
  const LogutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
