import 'package:equatable/equatable.dart';

class AdvertisementEnity extends Equatable {
  final String id;
  final String thumbnail;
  final String link;

  const AdvertisementEnity({
    required this.id,
    required this.thumbnail,
    required this.link,
  });

  @override
  List<Object> get props => [id, thumbnail, link];
}
