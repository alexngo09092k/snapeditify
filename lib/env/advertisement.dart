// ADVERTISEMENT
// https://developers.google.com/admob/android/test-ads
// https://developers.google.com/admob/ios/test-ads
// openApp,
// fluid,
// banner,
// reward,
// native,
// interstitial,
// splash,
// roll,

const advertisementConfig = {
  "enable": true,
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
    {
      "type": "banner",
      "provider": "google",
      "iosId": "ca-app-pub-3940256099942544/6300978111",
      "androidId": "ca-app-pub-3940256099942544/6300978111",
    },
    {
      "type": "interstitial",
      "provider": "google",
      "iosId": "ca-app-pub-3940256099942544/1033173712",
      "androidId": "ca-app-pub-3940256099942544/6300978111",
    },
    {
      "type": "reward",
      "provider": "google",
      "iosId": "ca-app-pub-3940256099942544/5224354917",
      "androidId": "ca-app-pub-3940256099942544/5224354917",
    },
    // {
    //   "type": "native",
    //   "provider": "google",
    //   "iosId": "ca-app-pub-3940256099942544/6300978111",
    //   "androidId": "ca-app-pub-3940256099942544/6300978111",
    // },

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
