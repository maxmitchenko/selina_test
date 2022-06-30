class WaitService {
  static Future<void> wait(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }
}
