// ignore_for_file: unused_field

import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/user_provider.dart';
import 'package:terminal/util/date_util.dart';
import 'package:terminal/util/params_util.dart';

/// 用户指令
/// 便签指令
/// 快速添加便签，日志，笔记
class NoteOrder extends BaseOrder {
  final Map<String, NoteParams> _noteParams = {
    "-add": NoteParams.add,
    "-delete": NoteParams.delete,
    "-complete": NoteParams.complete,
    "-sync": NoteParams.synchronize,
    "-rename": NoteParams.rename,
  };

  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    if (irs.length == 1) {
      throw OrderError("Note order: invalid input");
    }
    parse(irs.sublist(1));
    return null;
  }

  @override
  void parse(List<String> params) {
    // 只允许一个参数
    if (!ParamsUtil.requiredOneParam(params)) {
      throw OrderError("Note order: invalid input");
    }
    NoteParams param = _noteParams[params.first]!;
    switch (param) {
      case NoteParams.add:
        List<String> notes = params.sublist(1);
        if (notes.length % 2 != 0) {
          throw OrderError(
              "Note order: invalid input, if value is empty,please input ''");
        }
        UserProvider.noteProvider!.add(notes);
        break;
      case NoteParams.delete:
        if (DateUtil.isTrueDate(params[1])) {
          UserProvider.noteProvider!.delete(params.sublist(2), date: params[1]);
        } else {
          UserProvider.noteProvider!.delete(params.sublist(1));
        }
        break;
      case NoteParams.complete:
        if (params.length < 2 || params.length > 3) {
          throw OrderError("Note order: invalid input");
        }
        // 指定日期 date oldname newname
        if (DateUtil.isTrueDate(params[1]) && params.length == 3) {
          UserProvider.noteProvider!.complete(params[2], date: params[1]);
        } else {
          // 不指定日期 oldname newname
          UserProvider.noteProvider!.complete(params[1]);
        }
        break;
      case NoteParams.rename:
        if (params.length < 3 || params.length > 4) {
          throw OrderError("Note order: invalid input");
        }
        // 指定日期 date oldname newname
        if (DateUtil.isTrueDate(params[1]) && params.length == 4) {
          UserProvider.noteProvider!
              .rename(params[2], params[3], date: params[1]);
        } else {
          // 不指定日期 oldname newname
          UserProvider.noteProvider!.rename(params[1], params[2]);
        }
        break;
      case NoteParams.synchronize:
        if (params.length != 1) {
          throw OrderError("Note order: invalid input");
        }
        break;
    }
    setHelp();
  }

  @override
  void setParams() {
    super.params.addAll(_noteParams.keys);
  }

  @override
  void setHelp() {
    String notes = UserProvider.noteProvider!.getNotes();
    String complete = UserProvider.noteProvider!.getCompleteNotes();
    super.helpInfo.clear();
    super.helpInfo.addAll({
      "Params": "",
      "-add": "",
      "-delete": "",
      "-complete": "",
      "-rename": "",
      "-sync": "",
      "Note list": notes.isEmpty ? "" : "\n$notes",
      "Complete note list": complete.isEmpty ? "" : "\n$complete",
    });
  }
}

enum NoteParams {
  add,
  delete,
  complete,
  rename,
  synchronize,
}
