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
    'version': '2.0.0',

    /// Logo is used in splash screen and app ui
    'appLogo': 'assets/images/logo.png',

    'appBio': 'AI powered photo editor',

    /// Protocols is use to check
    'protocols': ['https://', 'http://', 'data:'],

    /// Prefix stored key
    'prefix': 'app.snapeditify.studio.',

    /// Contact
    'contact': 'hasoft.company@gmail.com',

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
      'version': '2.0.0',
      'required': false,
      'links': {
        'android': 'https://appgallery.huawei.com/app/C107645049', 
        'ios': 'https://appgallery.huawei.com/app/C107645049', 
        'huawei': 'https://appgallery.huawei.com/app/C107645049',
      },
    },

    'moreApps': [
       {
        "name": "Candy Land Puzzle: Match Game",
        "logo": "https://appimg2.dbankcdn.com/application/icon144/65/6124af2abde64858915de34600bf4e24.png",
        "desc": "Candy Land Puzzle is a new and stylish candy match 3 puzzle game, available for no matter adults or kids for all ages.!",
        "links": {
          "android": "https://appgallery.huawei.com/app/C108228683",
          "ios": "https://appgallery.huawei.com/app/C108228683",
          "huawei": "https://appgallery.huawei.com/app/C108228683"
        }
      },
      {
        "name": "Fall Dudes 3D: Amazing Run",
        "logo": "https://appimg2.dbankcdn.com/application/icon144/65/ae2086a83fd64cc9bde0d41b0305f20b.png",
        "desc": "Fall Dudes 3D: Super Tricky Amazing Run Run is a game with many levels and crazy obstacles waiting for you!",
        "links": {
          "android": "https://appgallery.huawei.com/app/C108199945",
          "ios": "https://appgallery.huawei.com/app/C108199945",
          "huawei": "https://appgallery.huawei.com/app/C108199945"
        }
      },
      {
        "name": "Car Mega Ramps",
        "logo": "https://appimg2.dbankcdn.com/application/icon144/65/6575b038b8534b3387bc4d1e6be163ac.png",
        "desc": "Car Mega Ramps games has an addictive and sensational interface where you will perform stunt racing efficiently on mega ramps.",
        "links": {
          "android": "https://appgallery.huawei.com/app/C108175001",
          "ios": "https://appgallery.huawei.com/app/C108175001",
          "huawei": "https://appgallery.huawei.com/app/C108175001"
        }
      },
      {
        "name": "Sweet Ice Cream Maker",
        "logo": "https://appimg2.dbankcdn.com/application/icon144/65/c5da0f730f4343269bd6bcd430315397.png",
        "desc": "Are you an ice cream lover? You will definitely like ice cream games. Here we have different varieties of Sweet Ice Cream Maker. ",
        "links": {
          "android": "https://appgallery.huawei.com/app/C108210943",
          "ios": "https://appgallery.huawei.com/app/C108210943",
          "huawei": "https://appgallery.huawei.com/app/C108210943"
        }
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
      // {
      //   "type": "reward",
      //   "provider": "huawei",
      //   "iosId": "h7s9d468ol",
      //   "androidId": "h7s9d468ol",
      // },
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
};
