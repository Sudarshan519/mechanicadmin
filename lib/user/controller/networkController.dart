import 'package:get/get.dart';
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';


class NetworkController extends GetxController {
  //TODO: Implement NetworkController

  var connectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionState);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Get.snackbar(e.code, e.message);
    } catch (e) {
      print(e.toString());
    }
    return _updateConnectionState(result);
  }

  Future<void> _updateConnectionState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;

        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        Get.snackbar("Network Error", "Failed to connect ot network");
    }
  }
  //void increment() => connectionStatus.value++;
}
