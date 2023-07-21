const enviroment = {
  //! ====================================== REMOTE CONFIG ==============================================
  "remoteConfig": {
    "enable": false,
    "providers": ["huawei"],
    'fetchTimeout': 60000, // 1 minutes
    'minimumFetchInterval': 60000, // 1 minutes
  },

  //! ====================================== BUSSINESS ==============================================
  "business": {
    /// App mode
    /// production, debug, maintenance
    'appMode': 'debug',

    /// Maintenance mode
    'maintenanceMode': {
      'title': "We'll be back soon",
      'message': "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
      'link': 'https://snapeditify.netlify.app',
    },

    /// Display name is used in app
    'appName': 'QR Scanner & Barcode Lookup',

    /// Version
    'version': '1.0.0',

    /// Logo is used in splash screen and app ui
    'appLogo': 'assets/images/logo.png',

    'appBio': 'Extremely fast QR & barcode scanner that supports all QR & barcode formats!',

    /// Protocols is use to check
    'protocols': ['https://', 'http://', 'data:'],

    /// Prefix stored key
    'prefix': 'com.snapeditify.scanner.',

    /// Contact
    'contact': 'contact.snapeditify@gmail.com',

    /// Social Networks
    'socialNetworks': [
      {
        'brand': 'Facebook',
        'link': 'https://www.facebook.com/snapeditify/',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/600px-Facebook_Logo_%282019%29.png',
      },
      {
        'brand': 'Tiktok',
        'link': 'https://www.tiktok.com/@snapeditify',
        'image': 'https://cdn4.iconfinder.com/data/icons/social-media-flat-7/64/Social-media_Tiktok-512.png',
      },
      {
        'brand': 'Youtube',
        'link': 'https://www.youtube.com/@snapeditify',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/318px-YouTube_full-color_icon_%282017%29.svg.png',
      },
      {
        'brand': 'Telegram',
        'link': 'https://t.me/+GPyDosamyKA2OGVl',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/512px-Telegram_logo.svg.png?20220101141644',
      },
    ],

    /// Web links
    'webLinks': [
      {
        'title': 'Terms of service',
        'link': 'https://snapeditify.netlify.app/terms-of-service',
        'image': 'assets/images/icons/pricacy.png',
      },
      {
        'title': 'Privacy policy',
        'link': 'https://snapeditify.netlify.app/privacy-policy/',
        'image': 'assets/images/icons/privacy.png',
      },
      {
        'title': 'FAQ',
        'link': 'https://snapeditify.netlify.app/faq',
        'image': 'assets/images/icons/faq.png',
      },
    ],

    /// Share app
    'shareApp': {
      'message': 'QR Scanner & Barcode Lookup. Extremely fast QR & barcode scanner that supports all QR & barcode formats!',
      'links': {
        'android': 'https://appgallery.huawei.com/app/C108714985', 
        'ios': 'https://appgallery.huawei.com/app/C108714985', 
        'huawei': 'https://appgallery.huawei.com/app/C108714985',
      },
    },

    /// Update app
    'updateApp': {
      'version': '1.0.2',
      'required': false,
      'links': {
        'android': 'https://appgallery.huawei.com/app/C108714985', 
        'ios': 'https://appgallery.huawei.com/app/C108714985', 
        'huawei': 'https://appgallery.huawei.com/app/C108714985',
      },
    },

    'moreApps': [
      //  {
      //    'name': 'TikOk',
      //    'logo': 'https://play-lh.googleusercontent.com/sITxnGaUxYVzTDkVAjRSKM8JKehWTuseE4hF8937sWVattKHEAirl7uZw93gqad_fQg6=s128-rw',
      //    'desc': 'Play the game Stick War, one of the biggest, most fun, challenging and addicting stick figure games. Control your army in formations or play each unit, you have total control of every stickman. Build units, mine gold, learn the way of the Sword, Spear, Archer, Mage, and even Giant. Destroy the enemy statue, and capture all Territories!',
      //    'links': {
      //      'android': 'https://appgallery.huawei.com/app/C108714985', 
      //      'ios': 'https://appgallery.huawei.com/app/C108714985', 
      //      'huawei': 'https://appgallery.huawei.com/app/C108714985',
      //    },
      //  }
    ]
  },


  //! ====================================== ADVERTISEMENT ==============================================
  "advertisement": {
    "enable": true,
    "adMobAppIdIos": "",
    "adMobAppIdAndroid": "",
    "providers": [ "huawei"],
    "ads": [
      /// HUAWEI
      {
        "type": "roll",
        "provider": "huawei",
        "iosId": "m3uab37kyr",
        "androidId": "m3uab37kyr",
      },
      {
        "type": "interstitial",
        "provider": "huawei",
        "iosId": "j1hv8l85y4",
        "androidId": "j1hv8l85y4",
      },
      {
        "type": "reward",
        "provider": "huawei",
        "iosId": "g0dxztu42h",
        "androidId": "g0dxztu42h",
      },
      {
        "type": "splash",
        "provider": "huawei",
        "iosId": "u9u84ir07q",
        "androidId": "u9u84ir07q",
      },
      {
        "type": "banner",
        "provider": "huawei",
        "iosId": "v1nfde9wsl",
        "androidId": "v1nfde9wsl",
      },
    ],
  },

  //! ====================================== IAP ==============================================
  "iap": {
    "enable": true,
    "providers": ["huawei"],
    "products": [
      {
        "type": "nonConsumables",
        "provider": "huawei",
        "id": "com.snapeditify.scanner.removeads",
        "info": {
          "name": "A Month",
          "description": "This is lisence for remove ads use us service like. Thanks for purchase.",
          "price": "\$2.46",
          "rawPrice": '2',
          "currency": "GBP",
        }
      },
    ],
  },
};
