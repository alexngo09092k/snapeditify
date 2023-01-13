import 'package:fluttering/provider/provider.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';

abstract class ISaveProvider extends Provider {
  EditImageType? type;

  shareImage() {}
}

class SaveProvider extends ISaveProvider {
  static final ISaveProvider _instance = SaveProvider.internal();

  static ISaveProvider get instance => _instance;

  SaveProvider.internal();


  EditImageType? _type;
  
}
