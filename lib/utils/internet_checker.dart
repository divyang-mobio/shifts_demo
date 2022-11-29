import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  Future<bool> connectionCheck() async {
    final connectionResult = await Connectivity().checkConnectivity();

    if (connectionResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectionResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
