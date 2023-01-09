// ADVERTISEMENT
// https://developers.google.com/admob/android/test-ads
// https://developers.google.com/admob/ios/test-ads
const advertisementConfig = {
  "enable": true,
  "googleTestingId": [],
  "adMobAppIdIos": "",
  "adMobAppIdAndroid": "",
  "ads": [
    /// GOOGLE
    {
      "type": "openApp",
      "provider": "google",
      "iosId": "ca-app-pub-3940256099942544/3419835294",
      "androidId": "ca-app-pub-3940256099942544/3419835294",
    },

    /// HUAWEI
    {
      "type": "interstitial",
      "provider": "huawei",
      "iosId": "",
      "androidId": "",
      "showOnScreens": ['edit'],
      "hideOnScreens": ['edit'],
      "waitingTimeToDisplay": 5,
    },
  ],
};
