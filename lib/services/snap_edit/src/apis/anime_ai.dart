import 'dart:io';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension EnimeAI on SnapEdit {
  Future<SnapEditResponse<RestyleEffectsResponse?>> getAnimeStyles([String lang = 'en']) async {
    try {
      ClientResponse<Map<String, dynamic>> response = await ClientHttp.instance.get<Map<String, dynamic>>(
        '${config.endPoints.animeEffects}?lang=$lang',
        headers: config.headers,
      );

      return handleResponse<RestyleEffectsResponse>(response, (p0) => RestyleEffectsResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<RestyleEffectsResponse?>(message: error.toString());
    }
  }

  Future<SnapEditResponse<AnimeResponse?>> animeImage(AnimeBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'style': body.style};

      if (body.imageId == null && body.inputImage == null) {
        return SnapEditResponse<AnimeResponse?>(message: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<AnimeResponse?>(message: 'Input image is not valid.');
        parts.add(MultipartBody<File>(key: 'input_image', data: file));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.animeImage}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<AnimeResponse?>(response, (p0) {
        if (p0 is Map<String, dynamic>) return AnimeResponse.fromMap(p0);
        Debug.log("ANIME IMAGE NO RESPONSE");
        return null;
      });
    } catch (error) {
      return SnapEditResponse<AnimeResponse?>(message: error.toString());
    }
  }
}
