class ParamsUtil {
  static bool requiredOneParam(List<String> params) {
    int start = params.indexOf(params.firstWhere(
      (element) => element.startsWith("-"),
      orElse: () => "-1",
    ));
    int end = params.lastIndexWhere((element) => element.startsWith("-"));
    // 只允许一个参数
    return start != -1 && end != -1 && start == end;
  }
}
