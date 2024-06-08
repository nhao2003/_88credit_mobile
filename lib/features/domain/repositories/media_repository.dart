import 'dart:io';
import '../../../core/resources/data_state.dart';

abstract class MediaRepository {
  // API remote
  Future<DataState<String>> uploadMedia(File media, String? folderName);
}
