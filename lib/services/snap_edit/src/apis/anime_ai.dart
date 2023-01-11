import 'dart:io';

import 'package:fluttering/fluttering.dart';
import 'package:phosart/services/snap_edit/snap_edit.dart';
import 'package:phosart/services/snap_edit/src/models/body/anime_ai_image_body.dart';
import 'package:phosart/services/snap_edit/src/models/body/anime_ai_video_body.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_image_response.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_styles_response.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_video_response.dart';
import 'package:phosart/services/snap_edit/src/utils.dart';

extension EnimeAI on SnapEdit {
  Future<SnapEditResponse<AnimeStylesResponse?>> getAnimeStyles([String lang = 'en']) async {
    try {
      ClientResponse<Map<String, dynamic>> response = await ClientHttp.instance.get<Map<String, dynamic>>(
        '${config.baseUrl}${config.endPoints.animeStyles}?lang=$lang',
        headers: config.headers,
      );

      return handleResponse<AnimeStylesResponse>(response, (p0) => AnimeStylesResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<AnimeStylesResponse?>(error: 'Something wrongs');
    }
  }

  Future<SnapEditResponse<AnimeImageResponse?>> animeRestyle(AnimeAIImageBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'style': body.style};

      if (body.imageId == null && body.inputImage == null) {
        return SnapEditResponse<AnimeImageResponse?>(data: null, error: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<AnimeImageResponse?>(data: null, error: 'Input image is not valid.');
        parts.add(MultipartBody<File>(key: 'input_image', data: file));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.animeImageAI}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<AnimeImageResponse>(response, (p0) => AnimeImageResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<AnimeImageResponse?>(error: 'Something wrongs');
    }
  }

  Future<SnapEditResponse<AnimeVideoResponse?>> animeVideoEffect(AnimeAIVideoBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'style': body.style};

      data['image_id'] = body.imageId;
      data['output_image_id'] = body.outputImageId;

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.animeVideoAIPro}',
        data,
        parts,
        headers: config.headers,
      );

      return handleResponse<AnimeVideoResponse>(response, (p0) => AnimeVideoResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<AnimeVideoResponse?>(error: 'Something wrongs');
    }
  }
}
