import 'dart:io';
import 'package:_88credit_mobile/features/data/models/back_card_info.dart';
import 'package:_88credit_mobile/features/data/models/front_card_info.dart';
import '../../../core/resources/data_state.dart';

abstract class EkycRepository {
  // Future<DataState<String>> uploadMedia(File media, String? folderName);
  Future<DataState<String>> initEkycRequest();
  Future<DataState<FrontCardInfo>> sendOCRFront(String requestId, File image);
  Future<DataState<BackCardInfo>> sendOCRBack(String requestId, File image);
  Future<DataState<void>> sendFace(String requestId, File image);
  Future<DataState<void>> sendVideoSefie(String requestId, File video);
  Future<DataState<void>> submit(String requestId);
}
