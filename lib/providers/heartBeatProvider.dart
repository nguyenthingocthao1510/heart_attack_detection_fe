import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';

class HearbeatAPI {
  static Future<List<Dashboard>> getBPM() async {
    final dio = Dio();
    final url = 'https://heart-attack-detection-be.onrender.com/api/heartbeat';
    final response = await dio.get(url);
    final resData = response.data['data'];
    final result = resData as List<dynamic>;
    return result.map((e) => Dashboard.fromMap(e)).toList();
  }
}

/// Provider to manage heartbeat state and fetching logic
class HeartbeatProvider with ChangeNotifier {
  List<Dashboard> _bpms = [];
  bool _isLoading = false;
  bool _hasHighThalachh = false;
  Timer? _timer; // Timer to fetch continuously

  bool get hasHighThalachh => _hasHighThalachh;

  List<Dashboard> get bpms => _bpms;

  bool get isLoading => _isLoading;

  /// Start periodic fetching
  void startFetching() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      fetchBPM();
    });
  }

  /// Stop periodic fetching
  void stopFetching() {
    _timer?.cancel();
  }

  /// Fetch heart beat data from API
  Future<void> fetchBPM() async {
    try {
      _isLoading = true;
      notifyListeners();

      _bpms = await HearbeatAPI.getBPM();

      // Check if any of the last 3 records exceed the threshold
      _hasHighThalachh = _bpms.take(3).any((e) => e.thalachh! > 120);

      notifyListeners();
    } catch (e) {
      print("Error fetching BPM: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Reset the high BPM flag
  void resetHighThalachh() {
    _hasHighThalachh = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
