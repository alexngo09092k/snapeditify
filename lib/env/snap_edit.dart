const snapEditConfig = {
    'baseUrl': "https://be-prod-1.snapedit.app/",
    'apiKey': "s2svtF6qSCwBCI0Xjm4MvY0fBGVrtoUCbidhNmkvrJA=",
    'version': "v6",
    'endPoints': {
      'erase': 'api/v6/erase',
      'erasePro': 'api/v6/erase',
      'ai': 'api/v6/ai_detection',
      'aiPro': 'api/v6/ai_detection',
      'enhance': 'api/v2/enhance',
      'enhancePro': 'api/v2/pro/enhance',
      'restyle': 'api/v1/restyle',
      'restylePro': 'api/v1/restyle',
      'styles': 'api/v1/restyle/styles',
      'stylesPro': 'api/v1/restyle/styles',
      'animeStyles': "api/imagen/v1/styles",
      'animeStylesPro': "api/imagen/v1/styles",
      'animeImageAI': "api/imagen/v1",
      'animeImageAIPro': "api/imagen/v1",
      'animeVideoAI': "api/imagen/v1/video",
      'animeVideoAIPro': "api/imagen/v1/video",
    },
    'enhance': {
      'suportedImageSize': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
      'uploadImageSize': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
      'upscaleMaxImageSize': 1000,
    },
    'restyle': {
      'dimension': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
    },
    'removeObject': {
      'dimension': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
      'strokeWidth': {
        'min': 1,
        'max': 100,
        'init': 30,
        'color': [255, 255, 255, 0.5],
      }
    },
    'waterMark': false,
    'maxFreeDownloadCount': 100,
  };