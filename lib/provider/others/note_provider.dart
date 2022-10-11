import 'package:terminal/provider/others/user_provider.dart';
import 'package:terminal/util/date_util.dart';

class NoteProvider {
  void add(List<String> notes) {
    String date = DateUtil.getCurrentDate();
    for (int i = 0; i < notes.length; i = i + 2) {
      if (!UserProvider.userController!.notes.containsKey(date)) {
        UserProvider.userController!.notes[date] = {};
      }
      UserProvider.userController!.notes[date]![notes[i]] = notes[i + 1];
    }
    UserProvider.userController!.save();
  }

  // 存在情况，date keys;keys
  void delete(List<String> notes, {String? date}) {
    String delDate = date ?? DateUtil.getCurrentDate();
    // 删除便签
    UserProvider.userController!.notes[delDate]!
        .removeWhere((key, value) => notes.contains(key));
    // 删除对应的完成便签
    if (UserProvider.userController!.completeNotes.containsKey(delDate)) {
      UserProvider.userController!.completeNotes[delDate]!
          .removeWhere((key, value) => notes.contains(key));
    }
    // 排除日期作为key的情况，且日期为当前
    if (delDate == DateUtil.getCurrentDate()) {
      UserProvider.userController!.notes[delDate]!.remove(delDate);
      if (UserProvider.userController!.completeNotes.containsKey(delDate)) {
        UserProvider.userController!.completeNotes[delDate]!.remove(delDate);
      }
    }
    UserProvider.userController!.save();
  }

  void rename(String oldName, String newName, {String? date}) {
    String renameDate = date ?? DateUtil.getCurrentDate();
    // 便签集合
    UserProvider.userController!.notes[renameDate]![newName] =
        UserProvider.userController!.notes[renameDate]![oldName]!;
    UserProvider.userController!.notes[renameDate]!.remove(oldName);
    // 完成的便签
    if (UserProvider.userController!.completeNotes.containsKey(renameDate) &&
        UserProvider.userController!.completeNotes[renameDate]!
            .containsKey(oldName)) {
      UserProvider.userController!.completeNotes[renameDate]![newName] =
          UserProvider.userController!.completeNotes[renameDate]![oldName]!;
      UserProvider.userController!.completeNotes[renameDate]!.remove(oldName);
    }

    UserProvider.userController!.save();
  }

  void complete(String key, {String? date}) {
    String completeDate = date ?? DateUtil.getCurrentDate();
    if (!UserProvider.userController!.completeNotes.containsKey(completeDate)) {
      UserProvider.userController!.completeNotes[completeDate] = {};
    }
    UserProvider.userController!.completeNotes[completeDate]![key] =
        UserProvider.userController!.notes[completeDate]![key]!;
    UserProvider.userController!.save();
  }

  String getNotes() {
    String res = "";

    // 排除已完成的
    UserProvider.userController!.notes.forEach((key, value) {
      res += "$key:\n";
      UserProvider.userController!.notes[key]!.forEach((elKey, elValue) {
        if (UserProvider.userController!.completeNotes.containsKey(key)) {
          if (!UserProvider.userController!.completeNotes[key]!
              .containsKey(elKey)) {
            res += "$elKey : $elValue\n";
          }
        } else {
          res += "$elKey : $elValue\n";
        }
      });
    });

    return res.isEmpty ? res : res.substring(0, res.length - 1);
  }

  String getCompleteNotes() {
    String res = "";

    UserProvider.userController!.completeNotes.forEach((key, value) {
      res += "$key:\n";
      UserProvider.userController!.completeNotes[key]!
          .forEach((elKey, elValue) {
        res += "$elKey : $elValue\n";
      });
    });
    return res.isEmpty ? res : res.substring(0, res.length - 1);
  }
}
