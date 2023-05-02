import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension Restyle on SnapEdit {
  Future<SnapEditResponse<RestyleEffectsResponse?>> getRestyleEffects([String lang = 'en']) async {
    try {
      ClientResponse<String> response = await ClientHttp.instance.get<String>(
        '${config.endPoints.restyleEffects}?lang=$lang',
        headers: config.headers,
      );
       
      return handleResponse<RestyleEffectsResponse>(response, (p0) => RestyleEffectsResponse.fromJson(p0));
    } catch (error) {
      return SnapEditResponse<RestyleEffectsResponse>(message: error.toString());
    }
  }

  Future<SnapEditResponse<RestyleImageResponse?>> restyle(RestyleBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'style_id': body.styleId};

      if (body.imageId == null && body.inputImage == null) {
        return SnapEditResponse<RestyleImageResponse?>(message: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<RestyleImageResponse?>(message: 'Input image is not valid.');
        parts.add(MultipartBody<File>(key: 'input_image', data: file));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.restyleImage}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<RestyleImageResponse>(response, (p0) => RestyleImageResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<RestyleImageResponse?>(message: error.toString());
    }
  }
}
