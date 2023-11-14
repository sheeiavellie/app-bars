import 'package:bars/features/map/data/models/app_lat_long.dart';
import 'package:equatable/equatable.dart';

class BarEntity extends Equatable {
  final int ? id;
  final String ? image_name;
  final String ? name;
  final String ? description;
  final String ? char_emoji;
  final AppLatLong ? geolocation;
  final String ? author;
  final String ? image_url;

  const BarEntity({
    this.id,
    this.image_name,
    this.name,
    this.description,
    this.char_emoji,
    this.geolocation,
    this.author,
    this.image_url,
  });
  
  @override
  List<Object?> get props {
    return [
      id,
      image_name,
      name,
      description,
      char_emoji,
      geolocation,
      author,
      image_url,
    ];
  }
}
