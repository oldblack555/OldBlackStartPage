/// 指令异常
class OrderError extends Error {
  // 需要抛出的异常信息
  final String? message;
  OrderError(String this.message);

  @override
  String toString() => "Order error [$message]";
}
