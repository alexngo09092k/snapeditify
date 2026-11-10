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

  /// `% accurate`
  String get accurate {
    return Intl.message(
      '% accurate',
      name: 'accurate',
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

  /// `AI`
  String get ai {
    return Intl.message(
      'AI',
      name: 'ai',
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

  /// `Albums`
  String get albums {
    return Intl.message(
      'Albums',
      name: 'albums',
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

  /// `All changes will be lost. Your image will be reverted to its original state.`
  String get allChangesWillBeLostYourImageWillBeReverted {
    return Intl.message(
      'All changes will be lost. Your image will be reverted to its original state.',
      name: 'allChangesWillBeLostYourImageWillBeReverted',
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

  /// `Anime AI`
  String get animeAi {
    return Intl.message(
      'Anime AI',
      name: 'animeAi',
      desc: '',
      args: [],
    );
  }

  /// `Apply Effects`
  String get applyEffects {
    return Intl.message(
      'Apply Effects',
      name: 'applyEffects',
      desc: '',
      args: [],
    );
  }

  /// `Are you happy with`
  String get areYouHappyWith {
    return Intl.message(
      'Are you happy with',
      name: 'areYouHappyWith',
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

  /// `Auto`
  String get auto {
    return Intl.message(
      'Auto',
      name: 'auto',
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

  /// `Best output image quality`
  String get bestOutputImageQuality {
    return Intl.message(
      'Best output image quality',
      name: 'bestOutputImageQuality',
      desc: '',
      args: [],
    );
  }

  /// `Background Color`
  String get bgColor {
    return Intl.message(
      'Background Color',
      name: 'bgColor',
      desc: '',
      args: [],
    );
  }

  /// `Background Opacity`
  String get bgOpacity {
    return Intl.message(
      'Background Opacity',
      name: 'bgOpacity',
      desc: '',
      args: [],
    );
  }

  /// `Black`
  String get blackColor {
    return Intl.message(
      'Black',
      name: 'blackColor',
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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Change Sky`
  String get changeSky {
    return Intl.message(
      'Change Sky',
      name: 'changeSky',
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

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Create ID Photo`
  String get createIdPhoto {
    return Intl.message(
      'Create ID Photo',
      name: 'createIdPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Creating video effects failed. Please try again.`
  String get creatingVideoEffectsFailedPleaseTryAgain {
    return Intl.message(
      'Creating video effects failed. Please try again.',
      name: 'creatingVideoEffectsFailedPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Cutout Objects`
  String get cutoutObjects {
    return Intl.message(
      'Cutout Objects',
      name: 'cutoutObjects',
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

  /// `Download now`
  String get downloadNow {
    return Intl.message(
      'Download now',
      name: 'downloadNow',
      desc: '',
      args: [],
    );
  }

  /// `Edit Background`
  String get editBackground {
    return Intl.message(
      'Edit Background',
      name: 'editBackground',
      desc: '',
      args: [],
    );
  }

  /// `Editor`
  String get editor {
    return Intl.message(
      'Editor',
      name: 'editor',
      desc: '',
      args: [],
    );
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

  /// `Enhance`
  String get enhance {
    return Intl.message(
      'Enhance',
      name: 'enhance',
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

  /// `Enhance Photo`
  String get enhancePhoto {
    return Intl.message(
      'Enhance Photo',
      name: 'enhancePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open browser. Please try again.`
  String get failedToOpenBrowserPleaseTryAgain {
    return Intl.message(
      'Failed to open browser. Please try again.',
      name: 'failedToOpenBrowserPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to open mail. Please try again.`
  String get failedToOpenMailPleaseTryGain {
    return Intl.message(
      'Failed to open mail. Please try again.',
      name: 'failedToOpenMailPleaseTryGain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save image. Please try again.`
  String get failedToSaveImagePleaseTryAgain {
    return Intl.message(
      'Failed to save image. Please try again.',
      name: 'failedToSaveImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Fast Editor`
  String get fastEditor {
    return Intl.message(
      'Fast Editor',
      name: 'fastEditor',
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

  /// `Filter Color`
  String get filterColor {
    return Intl.message(
      'Filter Color',
      name: 'filterColor',
      desc: '',
      args: [],
    );
  }

  /// `Freeform`
  String get freeform {
    return Intl.message(
      'Freeform',
      name: 'freeform',
      desc: '',
      args: [],
    );
  }

  /// `Get it`
  String get getIt {
    return Intl.message(
      'Get it',
      name: 'getIt',
      desc: '',
      args: [],
    );
  }

  /// `HOT`
  String get hot {
    return Intl.message(
      'HOT',
      name: 'hot',
      desc: '',
      args: [],
    );
  }

  /// `Image only`
  String get imageOnly {
    return Intl.message(
      'Image only',
      name: 'imageOnly',
      desc: '',
      args: [],
    );
  }

  /// `Insert your message`
  String get insertYourMessage {
    return Intl.message(
      'Insert your message',
      name: 'insertYourMessage',
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

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Share one of the best photo editing apps with your friends, family and community.`
  String get letsShareOneOfTheBestPhotoEditingAppWith {
    return Intl.message(
      'Share one of the best photo editing apps with your friends, family and community.',
      name: 'letsShareOneOfTheBestPhotoEditingAppWith',
      desc: '',
      args: [],
    );
  }

  /// `Looks like your connection was interrupted. Check your network and try again.`
  String get looksLikeYourComnnectionIsInterruptedCheckNetworkConnectionAnd {
    return Intl.message(
      'Looks like your connection was interrupted. Check your network and try again.',
      name: 'looksLikeYourComnnectionIsInterruptedCheckNetworkConnectionAnd',
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

  /// `No ads – enjoy the best experience`
  String get noAdsBestExperience {
    return Intl.message(
      'No ads – enjoy the best experience',
      name: 'noAdsBestExperience',
      desc: '',
      args: [],
    );
  }

  /// `No ads & best image quality`
  String get noAdsBestImageQuality {
    return Intl.message(
      'No ads & best image quality',
      name: 'noAdsBestImageQuality',
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

  /// `No images found`
  String get notFoundImages {
    return Intl.message(
      'No images found',
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

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `1-Touch`
  String get oneTouch {
    return Intl.message(
      '1-Touch',
      name: 'oneTouch',
      desc: '',
      args: [],
    );
  }

  /// `1-Touch Remove`
  String get oneTouchRemove {
    return Intl.message(
      '1-Touch Remove',
      name: 'oneTouchRemove',
      desc: '',
      args: [],
    );
  }

  /// `Opacity`
  String get opacity {
    return Intl.message(
      'Opacity',
      name: 'opacity',
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

  /// `Open browser`
  String get openBrowser {
    return Intl.message(
      'Open browser',
      name: 'openBrowser',
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

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Please try again or reopen the app.`
  String get pleaseTryAgainOrOpenTheAppAgain {
    return Intl.message(
      'Please try again or reopen the app.',
      name: 'pleaseTryAgainOrOpenTheAppAgain',
      desc: '',
      args: [],
    );
  }

  /// `Radius`
  String get radius {
    return Intl.message(
      'Radius',
      name: 'radius',
      desc: '',
      args: [],
    );
  }

  /// `Rate SnapEditify`
  String get rateSnapeditify {
    return Intl.message(
      'Rate SnapEditify',
      name: 'rateSnapeditify',
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

  /// `Remove Background`
  String get removeBackground {
    return Intl.message(
      'Remove Background',
      name: 'removeBackground',
      desc: '',
      args: [],
    );
  }

  /// `Remove Object`
  String get removeObject {
    return Intl.message(
      'Remove Object',
      name: 'removeObject',
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

  /// `Removed`
  String get removed {
    return Intl.message(
      'Removed',
      name: 'removed',
      desc: '',
      args: [],
    );
  }

  /// `Remover`
  String get remover {
    return Intl.message(
      'Remover',
      name: 'remover',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message(
      'Restore',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Restore Old Photo`
  String get restoreOldPhoto {
    return Intl.message(
      'Restore Old Photo',
      name: 'restoreOldPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Restyle`
  String get restyle {
    return Intl.message(
      'Restyle',
      name: 'restyle',
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

  /// `Save Video`
  String get saveVideo {
    return Intl.message(
      'Save Video',
      name: 'saveVideo',
      desc: '',
      args: [],
    );
  }

  /// `Image saved`
  String get savedImage {
    return Intl.message(
      'Image saved',
      name: 'savedImage',
      desc: '',
      args: [],
    );
  }

  /// `Video saved`
  String get savedVideo {
    return Intl.message(
      'Video saved',
      name: 'savedVideo',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Select background color and photo ratio`
  String get selectBackgroundColorAndPhotoRatio {
    return Intl.message(
      'Select background color and photo ratio',
      name: 'selectBackgroundColorAndPhotoRatio',
      desc: '',
      args: [],
    );
  }

  /// `Select Emoji`
  String get selectEmoji {
    return Intl.message(
      'Select Emoji',
      name: 'selectEmoji',
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

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
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

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Sky`
  String get sky {
    return Intl.message(
      'Sky',
      name: 'sky',
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

  /// `Team`
  String get team {
    return Intl.message(
      'Team',
      name: 'team',
      desc: '',
      args: [],
    );
  }

  /// `Support team`
  String get teamToSupport {
    return Intl.message(
      'Support team',
      name: 'teamToSupport',
      desc: '',
      args: [],
    );
  }

  /// `Text Color`
  String get textColor {
    return Intl.message(
      'Text Color',
      name: 'textColor',
      desc: '',
      args: [],
    );
  }

  /// `Text Size`
  String get textSize {
    return Intl.message(
      'Text Size',
      name: 'textSize',
      desc: '',
      args: [],
    );
  }

  /// `Thai`
  String get thailand {
    return Intl.message(
      'Thai',
      name: 'thailand',
      desc: '',
      args: [],
    );
  }

  /// ` to access photos on your device to edit or share images.`
  String get toAccessPhotosOnYourDeviceToEditOrShare {
    return Intl.message(
      ' to access photos on your device to edit or share images.',
      name: 'toAccessPhotosOnYourDeviceToEditOrShare',
      desc: '',
      args: [],
    );
  }

  /// `Unable to change the sky. Please try again.`
  String get unableToChangeTheSkyOfTheImagePleaseTryAgain {
    return Intl.message(
      'Unable to change the sky. Please try again.',
      name: 'unableToChangeTheSkyOfTheImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to create ID photo. Please try again.`
  String get unableToCreateIdPhotoPleaseTryAgain {
    return Intl.message(
      'Unable to create ID photo. Please try again.',
      name: 'unableToCreateIdPhotoPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to remove object. Please try again.`
  String get unableToDeleteObjectPleaseTryAgain {
    return Intl.message(
      'Unable to remove object. Please try again.',
      name: 'unableToDeleteObjectPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to detect object. Please try again.`
  String get unableToDetectObjectPleaseTryAgain {
    return Intl.message(
      'Unable to detect object. Please try again.',
      name: 'unableToDetectObjectPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to enhance the image. Please try again.`
  String get unableToEnhanceTheImagePleaseTryAgain {
    return Intl.message(
      'Unable to enhance the image. Please try again.',
      name: 'unableToEnhanceTheImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to restore the image. Please try again.`
  String get unableToRestoreTheImagePleaseTryAgain {
    return Intl.message(
      'Unable to restore the image. Please try again.',
      name: 'unableToRestoreTheImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to save image. Please try again.`
  String get unableToSaveImagePleaseTryAgain {
    return Intl.message(
      'Unable to save image. Please try again.',
      name: 'unableToSaveImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to save video. Please try again.`
  String get unableToSaveVideoPleaseTryAgain {
    return Intl.message(
      'Unable to save video. Please try again.',
      name: 'unableToSaveVideoPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to style image. Please try again.`
  String get unableToStyleImagePleaseTryAgain {
    return Intl.message(
      'Unable to style image. Please try again.',
      name: 'unableToStyleImagePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited access to powerful AI features`
  String get unlimitedAccessAiFeatures {
    return Intl.message(
      'Unlimited access to powerful AI features',
      name: 'unlimitedAccessAiFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Premium`
  String get unlockPremium {
    return Intl.message(
      'Unlock Premium',
      name: 'unlockPremium',
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

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Upscale`
  String get upscale {
    return Intl.message(
      'Upscale',
      name: 'upscale',
      desc: '',
      args: [],
    );
  }

  /// `Upscale Image`
  String get upscaleImage {
    return Intl.message(
      'Upscale Image',
      name: 'upscaleImage',
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

  /// `Video Effect`
  String get videoEffect {
    return Intl.message(
      'Video Effect',
      name: 'videoEffect',
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

  /// `Would like to access your photos`
  String get wouldLikeToAccessYourPhotos {
    return Intl.message(
      'Would like to access your photos',
      name: 'wouldLikeToAccessYourPhotos',
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

  /// `You have reached the saved image limit. Please upgrade to Premium or contact support.`
  String get youHaveReachedTheLimitOfSavedImagePleaseUpgrade {
    return Intl.message(
      'You have reached the saved image limit. Please upgrade to Premium or contact support.',
      name: 'youHaveReachedTheLimitOfSavedImagePleaseUpgrade',
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

  /// `Your app version is no longer supported. Update to get new features and critical fixes.`
  String get yourAppVersionIsNoLongerSupportedYoureMissingOut {
    return Intl.message(
      'Your app version is no longer supported. Update to get new features and critical fixes.',
      name: 'yourAppVersionIsNoLongerSupportedYoureMissingOut',
      desc: '',
      args: [],
    );
  }

  /// `Your feedback helps us improve the app experience.`
  String get yourFeedbackOfTheAppAndProvideABetterExperience {
    return Intl.message(
      'Your feedback helps us improve the app experience.',
      name: 'yourFeedbackOfTheAppAndProvideABetterExperience',
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
