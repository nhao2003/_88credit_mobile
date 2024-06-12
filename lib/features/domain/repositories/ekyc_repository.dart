import 'dart:io';
import '../../../core/resources/data_state.dart';

abstract class EkycRepository {
  // Future<DataState<String>> uploadMedia(File media, String? folderName);
  Future<DataState<String>> initEkycRequest();
  Future<DataState<void>> sendOCRFront(String requestId, File image);
  Future<DataState<void>> sendOCRBack(String requestId, File image);
  Future<DataState<void>> sendFace(String requestId, File image);
  Future<DataState<void>> sendVideoSefie(String requestId, File video);
  Future<DataState<void>> submit(String requestId);
}
