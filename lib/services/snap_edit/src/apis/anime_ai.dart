import 'dart:io';

import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';
import 'package:snapedit/services/snap_edit/src/models/response/anime_image_response.dart';
import 'package:snapedit/services/snap_edit/src/models/response/anime_styles_response.dart';
import 'package:snapedit/services/snap_edit/src/models/response/anime_video_response.dart';
import 'package:snapedit/services/snap_edit/src/utils.dart';

extension EnimeAI on SnapEdit {
  Future<SnapEditResponse<AnimeStylesResponse?>> getAnimeStyles([String lang = 'en']) async {
    ClientResponse<Map<String, dynamic>> response = await ClientHttp.instance.get<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.animeStyles}?lang=$lang',
      headers: config.headers,
    );

    return handleResponse<AnimeStylesResponse>(response, (p0) => AnimeStylesResponse.fromMap(p0));
  }

  Future<SnapEditResponse<AnimeImageResponse?>> animeImageAI(RestyleBody body) async {
    final List<MultipartBody> parts = [];
    final Map<String, dynamic> data = {'style_id': body.styleId};

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
  }

  Future<SnapEditResponse<AnimeVideoResponse?>> animeVideoAI(RestyleBody body) async {
    final List<MultipartBody> parts = [];
    final Map<String, dynamic> data = {'style_id': body.styleId};

    if (body.imageId == null && body.inputImage == null) {
      return SnapEditResponse<AnimeVideoResponse?>(data: null, error: 'Input image and image id, the both are null.');
    }

    if (body.imageId != null) data['image_id'] = body.imageId!;

    File? file;
    if (body.inputImage != null) {
      file = await uint8ListToFile(body.inputImage!);
      if (file == null) return SnapEditResponse<AnimeVideoResponse?>(data: null, error: 'Input image is not valid.');
      parts.add(MultipartBody<File>(key: 'input_image', data: file));
    }

    ClientResponse response = await ClientHttp.instance.postMultipart(
      '${config.baseUrl}${config.endPoints.animeImageAI}',
      data,
      parts,
      headers: config.headers,
    );

    if (file != null && await file.exists()) file.delete();

    return handleResponse<AnimeVideoResponse>(response, (p0) => AnimeVideoResponse.fromMap(p0));
  }
}
