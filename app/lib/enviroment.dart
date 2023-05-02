const enviroment = {
  //! ====================================== REMOTE CONFIG ==============================================
  "remoteConfig": {
    "enable": true,
    "providers": ["huawei"],
    'fetchTimeout': 60000, // 1 minutes
    'minimumFetchInterval': 60000, // 1 minutes
  },

  //! ====================================== BUSSINESS ==============================================
  "business": {
    /// App mode
    /// production, debug, maintenance
    'appMode': 'production',

    /// Maintenance mode
    'maintenanceMode': {
      'title': "We'll be back soon",
      'message': "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
      'link': 'https://snapeditify.netlify.app',
    },

    /// Display name is used in app
    'appName': 'SnapEditify',

    /// Version
    'version': '1.0.2',

    /// Logo is used in splash screen and app ui
    'appLogo': 'assets/images/logo.png',

    'appBio': 'Make your life beautiful',

    /// Protocols is use to check
    'protocols': ['https://', 'http://', 'data:'],

    /// Prefix stored key
    'prefix': 'app.snapeditify.studio.',

    /// Contact
    'contact': 'contact.snapeditify@gmail.com',

    /// Social Networks
    'socialNetworks': [
      {
        'brand': 'Facebook',
        'link': 'https://www.facebook.com/snapeditify/',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/600px-Facebook_Logo_%282019%29.png',
      },
      {
        'brand': 'Tiktok',
        'link': 'https://www.tiktok.com/@snapeditify',
        'image':
            'https://cdn4.iconfinder.com/data/icons/social-media-flat-7/64/Social-media_Tiktok-512.png',
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
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/512px-Telegram_logo.svg.png?20220101141644',
      },
    ],

    /// Web links
    'webLinks': [
      {
        'title': 'Terms of service',
        'link': 'https://snapeditify.netlify.app/terms-of-service',
        'image': 'assets/images/icons/ic_term.png',
      },
      {
        'title': 'Privacy policy',
        'link': 'https://snapeditify.netlify.app/privacy-policy/',
        'image': 'assets/images/icons/ic_term.png',
      },
      {
        'title': 'FAQ',
        'link': 'https://snapeditify.netlify.app/faq',
        'image': 'assets/images/icons/ic_faq.png',
      },
    ],

    /// Share app
    'shareApp': {
      'message': 'SnapEditify AI Photo Editor Pro',
      'links': {
        'android': 'https://appgallery.huawei.com/app/C107645049', 
        'ios': 'https://appgallery.huawei.com/app/C107645049', 
        'huawei': 'https://appgallery.huawei.com/app/C107645049',
      },
    },

    /// Update app
    'updateApp': {
      'version': '1.0.2',
      'required': false,
      'links': {
        'android': 'https://appgallery.huawei.com/app/C107645049', 
        'ios': 'https://appgallery.huawei.com/app/C107645049', 
        'huawei': 'https://appgallery.huawei.com/app/C107645049',
      },
    },

    'moreApps': [
       {
         'name': 'TikOk',
         'logo': 'https://play-lh.googleusercontent.com/sITxnGaUxYVzTDkVAjRSKM8JKehWTuseE4hF8937sWVattKHEAirl7uZw93gqad_fQg6=s128-rw',
         'desc': 'Play the game Stick War, one of the biggest, most fun, challenging and addicting stick figure games. Control your army in formations or play each unit, you have total control of every stickman. Build units, mine gold, learn the way of the Sword, Spear, Archer, Mage, and even Giant. Destroy the enemy statue, and capture all Territories!',
         'links': {
           'android': 'https://appgallery.huawei.com/app/C107645049', 
           'ios': 'https://appgallery.huawei.com/app/C107645049', 
           'huawei': 'https://appgallery.huawei.com/app/C107645049',
         },
       }
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
      // {
      //   "type": "native",
      //   "provider": "huawei",
      //   "iosId": "l28y76h1or",
      //   "androidId": "h2bea5p6f4",
      // },
      {
        "type": "roll",
        "provider": "huawei",
        "iosId": "h2bea5p6f4",
        "androidId": "h2bea5p6f4",
      },
      {
        "type": "interstitial",
        "provider": "huawei",
        "iosId": "r0o9tg4ocx",
        "androidId": "r0o9tg4ocx",
      },
      {
        "type": "reward",
        "provider": "huawei",
        "iosId": "h7s9d468ol",
        "androidId": "h7s9d468ol",
      },
      // {
      //   "type": "splash",
      //   "provider": "huawei",
      //   "iosId": "t17z7pus7m",
      //   "androidId": "t17z7pus7m",
      // },
      {
        "type": "banner",
        "provider": "huawei",
        "iosId": "v7y4ozn8r7",
        "androidId": "v7y4ozn8r7",
      },
    ],
  },

  //! ====================================== IAP ==============================================
  "iap": {
    "enable": true,
    "providers": ["huawei"],
    "products": [
      {
        "type": "subscriptions",
        "provider": "huawei",
        "id": "app.snapeditify.studio.amonth",
        "info": {
          "name": "A Month",
          "description": "This is lisence for a month use us service like. Thanks for purchase.",
          "price": "\$2.46",
          "rawPrice": '2',
          "currency": "GBP",
        }
      },
      {
        "type": "subscriptions",
        "provider": "huawei",
        "id": "app.snapeditify.studio.oneyear",
        "info": {
          "name": "A Month",
          "description": "This is lisence for a month use us service like. Thanks for purchase.",
          "price": "\$2.46",
          "rawPrice": '2',
          "currency": "GBP",
        }
      },
    ],
  },

  //! ====================================== SNAPEDIT ==============================================
  "snapEdit": {
    'baseUrl': "https://be-prod-1.snapedit.app/",
    // 'apiKey': "s2svtF6qSCwBCI0Xjm4MvY0fBGVrtoUCbidhNmkvrJA=",
    'apiKey': "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2ZXJzaW9uIjoiMy4xLjAiLCJleHAiOjE3Njk2MjI0MDEsInN1YiI6Imlnbm9yZSIsInBsYXRmb3JtIjoiYW5kcm9pZCJ9.OufJuEzKvN2RVCw-Ofy1oY6d9oRuOnM_Vxmt6aqLWAk",
    'version': "3.8.0",
    'endPoints': {
      'removeObject': "api/v6/erase",
      'scanObject': "api/v6/ai_detection",
      'enhanceImage': "api/v2/pro/enhance",
      'restyleEffects': "https://assets.snapedit.app/restyle/styles.json",
      'restyleImage': "api/v1/restyle",
      'animeEffects': "https://assets.snapedit.app/imagen/styles.json",
      'animeImage': "api/imagen/v1",
      'generateVideo': "api/video/v1/generate",
      'removeBackground': "api/rmbg/v1",
      'backgroundEffects': "https://assets.snapedit.app/removebg/backgrounds.json",
      'removeOneTouch': "api/object_removal/v5/onetouch_suggest",
      'saveImagelarge': "api/v6/save_large_image",
      'skyImage': "api/sky/v1",
      'skyEffects': "https://assets.snapedit.app/skywizard/backgrounds.json",
      'restoreImage': "api/restore/v1",
    },
    'maxFreeDownloadCount': 100,
  },
};
