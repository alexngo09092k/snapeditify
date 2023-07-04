// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get chinese {
    return Intl.message(
      'Chinese',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `Thailand`
  String get thailand {
    return Intl.message(
      'Thailand',
      name: 'thailand',
      desc: '',
      args: [],
    );
  }

  /// `Albums`
  String get albums {
    return Intl.message(
      'Albums',
      name: 'albums',
      desc: '',
      args: [],
    );
  }

  /// `Anime AI`
  String get animeAi {
    return Intl.message(
      'Anime AI',
      name: 'animeAi',
      desc: '',
      args: [],
    );
  }

  /// `After`
  String get after {
    return Intl.message(
      'After',
      name: 'after',
      desc: '',
      args: [],
    );
  }

  /// `Before`
  String get before {
    return Intl.message(
      'Before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `Enhance`
  String get enhance {
    return Intl.message(
      'Enhance',
      name: 'enhance',
      desc: '',
      args: [],
    );
  }

  /// `Remove things\nfrom image`
  String get removeThingsNfromImage {
    return Intl.message(
      'Remove things\nfrom image',
      name: 'removeThingsNfromImage',
      desc: '',
      args: [],
    );
  }

  /// `Turn your\nimage\ninto Art`
  String get turnYourNimageNintoArt {
    return Intl.message(
      'Turn your\nimage\ninto Art',
      name: 'turnYourNimageNintoArt',
      desc: '',
      args: [],
    );
  }

  /// `Enhance\nimage quality`
  String get enhanceNimageQuality {
    return Intl.message(
      'Enhance\nimage quality',
      name: 'enhanceNimageQuality',
      desc: '',
      args: [],
    );
  }

  /// `Create\nAnime avatar`
  String get createNanimeAvatar {
    return Intl.message(
      'Create\nAnime avatar',
      name: 'createNanimeAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Try it now`
  String get tryItNow {
    return Intl.message(
      'Try it now',
      name: 'tryItNow',
      desc: '',
      args: [],
    );
  }

  /// `Suggested`
  String get suggested {
    return Intl.message(
      'Suggested',
      name: 'suggested',
      desc: '',
      args: [],
    );
  }

  /// `Not found images`
  String get notFoundImages {
    return Intl.message(
      'Not found images',
      name: 'notFoundImages',
      desc: '',
      args: [],
    );
  }

  /// `Objects`
  String get objects {
    return Intl.message(
      'Objects',
      name: 'objects',
      desc: '',
      args: [],
    );
  }

  /// `% accurate`
  String get accurate {
    return Intl.message(
      '% accurate',
      name: 'accurate',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Removed`
  String get removed {
    return Intl.message(
      'Removed',
      name: 'removed',
      desc: '',
      args: [],
    );
  }

  /// `No potential object has been detected.`
  String get noPotentialObjectHasBeenDetected {
    return Intl.message(
      'No potential object has been detected.',
      name: 'noPotentialObjectHasBeenDetected',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get auto {
    return Intl.message(
      'Auto',
      name: 'auto',
      desc: '',
      args: [],
    );
  }

  /// `Brush`
  String get brush {
    return Intl.message(
      'Brush',
      name: 'brush',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes and revert?`
  String get discardChangesAndRevert {
    return Intl.message(
      'Discard changes and revert?',
      name: 'discardChangesAndRevert',
      desc: '',
      args: [],
    );
  }

  /// `All changes will be lost. Your image will be reverted to its original states.`
  String get allChangesWillBeLostYourImageWillBeReverted {
    return Intl.message(
      'All changes will be lost. Your image will be reverted to its original states.',
      name: 'allChangesWillBeLostYourImageWillBeReverted',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Art Effect`
  String get artEffect {
    return Intl.message(
      'Art Effect',
      name: 'artEffect',
      desc: '',
      args: [],
    );
  }

  /// `Unlock SnapEditify Premium`
  String get unlockSnapeditifyPremium {
    return Intl.message(
      'Unlock SnapEditify Premium',
      name: 'unlockSnapeditifyPremium',
      desc: '',
      args: [],
    );
  }

  /// `No ads & Best image quality`
  String get noAdsBestImageQuality {
    return Intl.message(
      'No ads & Best image quality',
      name: 'noAdsBestImageQuality',
      desc: '',
      args: [],
    );
  }

  /// `Are you happy with\n`
  String get areYouHappyWith {
    return Intl.message(
      'Are you happy with\n',
      name: 'areYouHappyWith',
      desc: '',
      args: [],
    );
  }

  /// `Your feedback of the app and provide a better experience`
  String get yourFeedbackOfTheAppAndProvideABetterExperience {
    return Intl.message(
      'Your feedback of the app and provide a better experience',
      name: 'yourFeedbackOfTheAppAndProvideABetterExperience',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Let's share one of the best photo editing app with your friends, family and community`
  String get letsShareOneOfTheBestPhotoEditingAppWith {
    return Intl.message(
      'Let\'s share one of the best photo editing app with your friends, family and community',
      name: 'letsShareOneOfTheBestPhotoEditingAppWith',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get team {
    return Intl.message(
      'Team',
      name: 'team',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Feedback to`
  String get feedbackTo {
    return Intl.message(
      'Feedback to',
      name: 'feedbackTo',
      desc: '',
      args: [],
    );
  }

  /// `Please wait a moment.`
  String get pleaseWaitAMoment {
    return Intl.message(
      'Please wait a moment.',
      name: 'pleaseWaitAMoment',
      desc: '',
      args: [],
    );
  }

  /// `Restyle Image`
  String get restyleImage {
    return Intl.message(
      'Restyle Image',
      name: 'restyleImage',
      desc: '',
      args: [],
    );
  }

  /// `Enhance Image`
  String get enhanceImage {
    return Intl.message(
      'Enhance Image',
      name: 'enhanceImage',
      desc: '',
      args: [],
    );
  }

  /// `AI Detection`
  String get aiDetection {
    return Intl.message(
      'AI Detection',
      name: 'aiDetection',
      desc: '',
      args: [],
    );
  }

  /// `Remove Objects`
  String get removeObjects {
    return Intl.message(
      'Remove Objects',
      name: 'removeObjects',
      desc: '',
      args: [],
    );
  }

  /// `Save Image`
  String get saveImage {
    return Intl.message(
      'Save Image',
      name: 'saveImage',
      desc: '',
      args: [],
    );
  }

  /// `Save Image Limit`
  String get saveImageLimit {
    return Intl.message(
      'Save Image Limit',
      name: 'saveImageLimit',
      desc: '',
      args: [],
    );
  }

  /// `You have reached the limit of saved image, please upgrade premium version or contact`
  String get youHaveReachedTheLimitOfSavedImagePleaseUpgrade {
    return Intl.message(
      'You have reached the limit of saved image, please upgrade premium version or contact',
      name: 'youHaveReachedTheLimitOfSavedImagePleaseUpgrade',
      desc: '',
      args: [],
    );
  }

  /// `Team to support.`
  String get teamToSupport {
    return Intl.message(
      'Team to support.',
      name: 'teamToSupport',
      desc: '',
      args: [],
    );
  }

  /// `All changes will be lost. Are you sure you want to leave without saving?`
  String get allChangesWillBeLostAreYouSureYouWant {
    return Intl.message(
      'All changes will be lost. Are you sure you want to leave without saving?',
      name: 'allChangesWillBeLostAreYouSureYouWant',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `You are currently offline.`
  String get youAreCurrentlyOffline {
    return Intl.message(
      'You are currently offline.',
      name: 'youAreCurrentlyOffline',
      desc: '',
      args: [],
    );
  }

  /// `Looks like your comnnection is interrupted. Check network connection and try again.`
  String get looksLikeYourComnnectionIsInterruptedCheckNetworkConnectionAnd {
    return Intl.message(
      'Looks like your comnnection is interrupted. Check network connection and try again.',
      name: 'looksLikeYourComnnectionIsInterruptedCheckNetworkConnectionAnd',
      desc: '',
      args: [],
    );
  }

  /// `Open settings`
  String get openSettings {
    return Intl.message(
      'Open settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Saved Image`
  String get savedImage {
    return Intl.message(
      'Saved Image',
      name: 'savedImage',
      desc: '',
      args: [],
    );
  }

  /// `New Image`
  String get newImage {
    return Intl.message(
      'New Image',
      name: 'newImage',
      desc: '',
      args: [],
    );
  }

  /// `with`
  String get withText {
    return Intl.message(
      'with',
      name: 'withText',
      desc: '',
      args: [],
    );
  }

  /// `AI`
  String get ai {
    return Intl.message(
      'AI',
      name: 'ai',
      desc: '',
      args: [],
    );
  }

  /// `Failed to change style, please try again.`
  String get failedToChangeStylePleaseTryAgain {
    return Intl.message(
      'Failed to change style, please try again.',
      name: 'failedToChangeStylePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to remove objects, please try again.`
  String get failedToRemoveObjectsPleaseTryAgain {
    return Intl.message(
      'Failed to remove objects, please try again.',
      name: 'failedToRemoveObjectsPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to detect object, please try again.`
  String get failedToDetectObjectPleaseTryAgain {
    return Intl.message(
      'Failed to detect object, please try again.',
      name: 'failedToDetectObjectPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to enhance image, please try again.`
  String get failedToEnhanceImagePleaseTryAgain {
    return Intl.message(
      'Failed to enhance image, please try again.',
      name: 'failedToEnhanceImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to style image, please try again.`
  String get failedToStyleImagePleaseTryAgain {
    return Intl.message(
      'Failed to style image, please try again.',
      name: 'failedToStyleImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Please try again or open the app again.`
  String get pleaseTryAgainOrOpenTheAppAgain {
    return Intl.message(
      'Please try again or open the app again.',
      name: 'pleaseTryAgainOrOpenTheAppAgain',
      desc: '',
      args: [],
    );
  }

  /// `Open app`
  String get openApp {
    return Intl.message(
      'Open app',
      name: 'openApp',
      desc: '',
      args: [],
    );
  }

  /// `Would like to access your photos`
  String get wouldLikeToAccessYourPhotos {
    return Intl.message(
      'Would like to access your photos',
      name: 'wouldLikeToAccessYourPhotos',
      desc: '',
      args: [],
    );
  }

  /// `to access photos on your device to edit or share image.`
  String get toAccessPhotosOnYourDeviceToEditOrShare {
    return Intl.message(
      'to access photos on your device to edit or share image.',
      name: 'toAccessPhotosOnYourDeviceToEditOrShare',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open mail, please try gain.`
  String get failedToOpenMailPleaseTryGain {
    return Intl.message(
      'Failed to open mail, please try gain.',
      name: 'failedToOpenMailPleaseTryGain',
      desc: '',
      args: [],
    );
  }

  /// `Open browser`
  String get openBrowser {
    return Intl.message(
      'Open browser',
      name: 'openBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open browser, please try again`
  String get failedToOpenBrowserPleaseTryAgain {
    return Intl.message(
      'Failed to open browser, please try again',
      name: 'failedToOpenBrowserPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save image, please try again.`
  String get failedToSaveImagePleaseTryAgain {
    return Intl.message(
      'Failed to save image, please try again.',
      name: 'failedToSaveImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Download now`
  String get downloadNow {
    return Intl.message(
      'Download now',
      name: 'downloadNow',
      desc: '',
      args: [],
    );
  }

  /// `Your app is outdated.`
  String get yourAppIsOutdated {
    return Intl.message(
      'Your app is outdated.',
      name: 'yourAppIsOutdated',
      desc: '',
      args: [],
    );
  }

  /// `Your app version is no longer supported. You're missing out on new features and critical fixes. Please update today.`
  String get yourAppVersionIsNoLongerSupportedYoureMissingOut {
    return Intl.message(
      'Your app version is no longer supported. You\'re missing out on new features and critical fixes. Please update today.',
      name: 'yourAppVersionIsNoLongerSupportedYoureMissingOut',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
