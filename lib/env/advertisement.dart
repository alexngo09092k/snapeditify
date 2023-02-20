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

const advertisement = {
  "enable": true,
  "adMobAppIdIos": "",
  "adMobAppIdAndroid": "",
  "providers": ["google", "huawei"],
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
    {
      "type": "native",
      "provider": "google",
      "iosId": "ca-app-pub-3940256099942544/6300978111",
      "androidId": "ca-app-pub-3940256099942544/6300978111",
    },

    /// HUAWEI
    {
      "type": "roll",
      "provider": "huawei",
      "iosId": "testy3cglm3pj0",
      "androidId": "testy3cglm3pj0",
      "showOnScreens": [],
      "hideOnScreens": [],
    },
    {
      "type": "interstitial",
      "provider": "huawei",
      "iosId": "teste9ih9j0rc3",
      "androidId": "teste9ih9j0rc3",
      "showOnScreens": [],
      "hideOnScreens": [],
    },
    {
      "type": "reward",
      "provider": "huawei",
      "iosId": "testx9dtjwj8hp",
      "androidId": "testx9dtjwj8hp",
      "showOnScreens": [],
      "hideOnScreens": [],
    },
  ],
};
