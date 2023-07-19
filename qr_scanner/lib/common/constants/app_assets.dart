part of '../constants.dart';

///APP IMAGES
class AppAssets {
  static final AppAssets _instance = AppAssets._internal();
  static AppAssets get instance => _instance;

  factory AppAssets() => _instance;

  AppAssets._internal();

  /// Lotties
  static const String lottiePath = 'assets/lotties';

  final String auToAIAnim = '$lottiePath/autoai_anim.json';
  final String brushAnim = '$lottiePath/brush_anim.json';
  final String enhanceGuideBfAf = '$lottiePath/enhance_guide_bf_af.json';
  final String heartTeam = "$lottiePath/heart.json";
  final String notFound = "$lottiePath/not_found.json";
  final String confetti = "$lottiePath/confetti.json";


  /// Images
  static const String imagePath = 'assets/images';

  final String imagePlaceholder = "$imagePath/image_place_holder.png";
  final String logo = "$imagePath/logo.png";
  final String placeholder = "$imagePath/placeholder.png";
  final String gAudio = "$imagePath/audio.png";
  final String gCrypto = "$imagePath/crypto.png";
  final String gEmail = "$imagePath/email.png";
  final String gFacebook = "$imagePath/facebook.png";
  final String gImage = "$imagePath/image.png";
  final String gInstagram = "$imagePath/instagram.png";
  final String gLinkList = "$imagePath/link-list.png";
  final String gLink = "$imagePath/link.png";
  final String gMaps = "$imagePath/maps.png";
  final String gMenu = "$imagePath/menu.png";
  final String gMutilUrl = "$imagePath/multiurl.png";
  final String gPCR = "$imagePath/pcr.png";
  final String gPDF = "$imagePath/pdf.png";
  final String gPPTX = "$imagePath/pptx.png";
  final String gSnapChat = "$imagePath/snapchat.png";
  final String gStore = "$imagePath/store.png";
  final String gTelegram = "$imagePath/telegram.png";
  final String gText = "$imagePath/text.png";
  final String gTiktok = "$imagePath/tiktok.png";
  final String gTwitter = "$imagePath/twitter.png";
  final String gVCard = "$imagePath/vcard.png";
  final String gWhatsapp = "$imagePath/whatsapp.png";
  final String gWifi = "$imagePath/wi-fi.png";
  final String gYoutube = "$imagePath/youtube.png";

  /// Coins
  final String bitcoin = "$imagePath/bitcoin.png";
  final String bitcoincash = "$imagePath/bitcoincash.png";
  final String ether = "$imagePath/ether.png";
  final String litecoin = "$imagePath/litecoin.png";
  final String dash = "$imagePath/dash.png";
  final String bnb = "$imagePath/bnb.png";
  final String usdt = "$imagePath/usdt.png";

  /// Flags
  static const String flagPath = '$imagePath/flags';

  /// Icons
  static const String iconPath = '$imagePath/icons';

  final String icFlashOff = "$iconPath/flash-off.png";
  final String icFlashOn = "$iconPath/flash-on.png";
  final String icFlipCamera = "$iconPath/flip-camera.png";
  final String icGallery = "$iconPath/gallery.png";
  final String icGenerate = "$iconPath/generate.png";
  final String icHistory = "$iconPath/history.png";
  final String icScanner = "$iconPath/scanner.png";
  final String icSettings = "$iconPath/settings.png";
  final String icZoomIn = "$iconPath/zoom-in.png";
  final String icZoomOut = "$iconPath/zoom-out.png";
}
