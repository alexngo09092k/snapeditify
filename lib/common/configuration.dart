import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapretouch/common/app_internet.dart';
import 'package:snapretouch/common/app_shared.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_config.dart';
import 'package:snapretouch/modules/firebase/models/firebase_config.dart';

import 'package:snapretouch/services/services.dart';

import 'logs.dart';

part './configuration/api_config.dart';

part 'configuration/app_config.dart';

part 'configuration/configuration.dart';
