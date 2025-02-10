import 'package:flutter/services.dart';

class WidgetService {
  static const _channel = MethodChannel('com.example.widgetnoteapp/update_widget');

  Future<void> updateWidget() async {
    try {
      await _channel.invokeMethod('updateWidget');
    } catch (e) {
      throw Exception('Error updating widget: $e');
    }
  }
}