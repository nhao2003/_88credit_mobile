import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

abstract class EkycRemoteDataSrc {
  Future<HttpResponse<String>> initEkycRequest();
  Future<HttpResponse<void>> sendOCRFront(String requestId, File image);
  Future<HttpResponse<void>> sendOCRBack(String requestId, File image);
  Future<HttpResponse<void>> sendFace(String requestId, File image);
  Future<HttpResponse<void>> sendVideoSefie(String requestId, File video);
  Future<HttpResponse<void>> submit(String requestId);
}

class EkycRemoteDataSrcImpl implements EkycRemoteDataSrc {
  final Dio client;

  EkycRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<String>> initEkycRequest() {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> sendOCRFront(String requestId, File image) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> sendOCRBack(String requestId, File image) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> sendFace(String requestId, File image) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> sendVideoSefie(String requestId, File video) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> submit(String requestId) {
    throw UnimplementedError();
  }
}
