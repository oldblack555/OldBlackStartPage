import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/content_provider.dart';
import 'package:terminal/ui/terminal/terminal.dart';

/// 全局异常捕获，统一处理异常
class GlobalCatchError {
  run(Widget app) {
    // 重写onError方法，监听Flutter框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kDebugMode) {
        print("捕获异常");
        print(details.exception.toString());
      }
      ContentProvider.add(
          "${SystemController.user} ${ContentProvider.getTextInput()}");
      if (details.exception is OrderError) {
        // 更新content状态，将异常信息输出到ui
        ContentProvider.add(details.exception.toString());
      }
      ContentProvider.clearText();
      ContentProvider.clearHintText();
      Future.delayed(const Duration(milliseconds: 20)).then((value) {
        Terminal.scrollController
            .jumpTo(Terminal.scrollController.position.maxScrollExtent);
      });
    };

    // 捕获onError无法捕获的异常
    runZonedGuarded(() {
      runApp(app);
    }, (error, stack) => catchError(error, stack));
  }

  catchError(Object error, StackTrace stack) {
    if (kDebugMode) {
      print(error);
    }
  }
}
