import 'package:bars/features/map/domain/app_lat_long.dart';
import 'package:bars/features/map/domain/entities/bar.dart';

class BarModel extends BarEntity {
  const BarModel({
    int ? id,
    String ? image_name,
    String ? name,
    String ? description,
    String ? char_emoji,
    AppLatLong ? geolocation,
    String ? author,
    String ? image_url,
  });

  factory BarModel.fromJson(Map<String, dynamic> map) {
    return BarModel(
      id: map['id'] ?? 0,
      image_name: map['image_name'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      char_emoji: map['char_emoji'] ?? 1,
      geolocation: AppLatLong(
        lat: map['geolocation']['x'] ?? const StPetersburgLocation().lat, 
        long: map['geolocation']['y'] ?? const StPetersburgLocation().long,
      ),
      author: map['author'] ?? "",
      image_url: map['image_url'] ?? "",
    );
  }
}
