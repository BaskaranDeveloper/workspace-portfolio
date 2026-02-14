import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class FullScreenManager {
  static bool _isFullScreen = false;

  static bool get isFullScreen => _isFullScreen;

  static void enterFullScreen() {
    if (!kIsWeb) return;
    try {
      js.context.callMethod('eval', [
        '''
        const el = document.documentElement;
        if (el.requestFullscreen) {
          el.requestFullscreen().catch((e) => {
            console.log("Full screen denied:", e);
          });
        } else if (el.webkitRequestFullscreen) {
          el.webkitRequestFullscreen();
        } else if (el.msRequestFullscreen) {
          el.msRequestFullscreen();
        }
        ''',
      ]);
      _isFullScreen = true;
    } catch (e) {
      debugPrint('Error entering full screen: $e');
    }
  }

  static void exitFullScreen() {
    if (!kIsWeb) return;
    try {
      js.context.callMethod('eval', [
        '''
        if (document.exitFullscreen) {
          document.exitFullscreen();
        } else if (document.webkitExitFullscreen) {
          document.webkitExitFullscreen();
        } else if (document.msExitFullscreen) {
          document.msExitFullscreen();
        }
        ''',
      ]);
      _isFullScreen = false;
    } catch (e) {
      debugPrint('Error exiting full screen: \$e');
    }
  }

  static void toggleFullScreen() {
    if (_isFullScreen) {
      exitFullScreen();
    } else {
      enterFullScreen();
    }
  }
}
