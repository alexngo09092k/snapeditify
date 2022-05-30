import 'package:flutter/foundation.dart';
import 'package:snapedit/modules/advertisement/advertisement_service.dart';
import 'package:snapedit/modules/firebase/firebase_notification_service.dart';
import 'package:snapedit/modules/firebase/firebase_service.dart';
import 'package:snapedit/modules/firebase/notification/notification_service.dart';
import 'package:snapedit/modules/firebase/notification/notification_service_impl.dart';

class Services {
  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();

  /// using BaseFirebaseServices when disable the Firebase
  // final firebase = BaseFirebaseServices();
  final firebase = FirebaseServices();

  /// using AdvertisementService when disable the Advertisement
  // final AdvertisementService advertisement = AdvertisementService();
  final AdvertisementService advertisement = AdvertisementService();

  /// Get notification Service
  static NotificationService getNotificationService() {
    NotificationService notificationService = NotificationServiceImpl();
    if (!kIsWeb) {
      if (_instance.firebase.isEnabled) {
        notificationService = FirebaseNotificationService();
      }
    }
    return notificationService;
  }
}
