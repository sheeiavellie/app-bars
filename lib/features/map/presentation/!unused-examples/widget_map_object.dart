import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as MapKit;

class WidgetMapObject extends Equatable implements MapKit.MapObject {
  static const _kType = 'WidgetMapObject';

  const WidgetMapObject({
    required this.mapId,
    required this.point,
    this.zIndex = 0.0,
    this.onTap,
    this.onDragStart,
    this.onDrag,
    this.onDragEnd,
    this.consumeTapEvents = false,
    this.isVisible = true,
    this.isDraggable = false,
    this.opacity = 0.5,
    this.direction = 0,
    this.widgetPlacemark,
  });

  /// The geometry of the map object.
  final MapKit.Point point;

  /// z-order
  ///
  /// Affects:
  /// 1. Rendering order.
  /// 2. Dispatching of UI events(taps and drags are dispatched to objects with higher z-indexes first).
  final double zIndex;

  /// Callback to call when this placemark receives a tap
  final MapKit.TapCallback<WidgetMapObject>? onTap;

  /// True if the placemark consumes tap events.
  /// If not, the map will propagate tap events to other map objects at the point of tap.
  final bool consumeTapEvents;

  /// Raised when dragging mode is active for the given map object.
  final MapKit.DragStartCallback<WidgetMapObject>? onDragStart;

  /// Raised when the user is moving a finger and the map object follows it.
  final MapKit.DragCallback<WidgetMapObject>? onDrag;

  /// Raised when the user released the tap.
  final MapKit.DragEndCallback<WidgetMapObject>? onDragEnd;

  /// Manages visibility of the object on the map.
  final bool isVisible;

  /// Manages if map object can be dragged by the user.
  final bool isDraggable;

  /// Opacity multiplicator for the placemark content.
  /// Values below 0 will be set to 0.
  final double opacity;

  /// Angle between the direction of an object and the direction to north.
  /// Measured in degrees.
  final double direction;

  final PlacemarkWidget? widgetPlacemark;

  WidgetMapObject copyWith({
    MapKit.Point? point,
    double? zIndex,
    MapKit.TapCallback<WidgetMapObject>? onTap,
    MapKit.DragStartCallback<WidgetMapObject>? onDragStart,
    MapKit.DragCallback<WidgetMapObject>? onDrag,
    MapKit.DragEndCallback<WidgetMapObject>? onDragEnd,
    bool? consumeTapEvents,
    bool? isVisible,
    bool? isDraggable,
    double? opacity,
    double? direction,
    PlacemarkWidget? widgetPlacemark,
  }) {
    return WidgetMapObject(
      mapId: mapId,
      point: point ?? this.point,
      zIndex: zIndex ?? this.zIndex,
      onTap: onTap ?? this.onTap,
      onDragStart: onDragStart ?? this.onDragStart,
      onDrag: onDrag ?? this.onDrag,
      onDragEnd: onDragEnd ?? this.onDragEnd,
      consumeTapEvents: consumeTapEvents ?? this.consumeTapEvents,
      isVisible: isVisible ?? this.isVisible,
      isDraggable: isDraggable ?? this.isDraggable,
      opacity: opacity ?? this.opacity,
      direction: direction ?? this.direction,
      widgetPlacemark: widgetPlacemark ?? this.widgetPlacemark,
    );
  }

  @override
  final MapKit.MapObjectId mapId;

  @override
  WidgetMapObject clone() => copyWith();

  @override
  WidgetMapObject dup(MapKit.MapObjectId mapId) {
    return WidgetMapObject(
      mapId: mapId,
      point: point,
      zIndex: zIndex,
      onTap: onTap,
      onDragStart: onDragStart,
      onDrag: onDrag,
      onDragEnd: onDragEnd,
      consumeTapEvents: consumeTapEvents,
      isVisible: isVisible,
      isDraggable: isDraggable,
      opacity: opacity,
      direction: direction,
      widgetPlacemark: widgetPlacemark,
    );
  }

  @override
  void _tap(MapKit.Point point) {
    if (onTap != null) {
      onTap!(this, point);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': mapId.value,
      'point': point.toJson(),
      'zIndex': zIndex,
      'consumeTapEvents': consumeTapEvents,
      'isVisible': isVisible,
      'isDraggable': isDraggable,
      'opacity': opacity,
      'direction': direction,
      'widgetPlacemark': widgetPlacemark
    };
  }

  @override
  Map<String, dynamic> _createJson() {
    return toJson()..addAll({
      'type': _kType
    });
  }

  @override
  Map<String, dynamic> _updateJson(MapKit.MapObject previous) {
    assert(mapId == previous.mapId);

    return toJson()..addAll({
      'type': _kType
    });
  }

  @override
  Map<String, dynamic> _removeJson() {
    return {
      'id': mapId.value,
      'type': _kType
    };
  }

  @override
  List<Object?> get props => <Object?>[
    mapId,
    point,
    zIndex,
    consumeTapEvents,
    isVisible,
    isDraggable,
    opacity,
    direction,
    widgetPlacemark,
  ];

  @override
  bool get stringify => true;

}

class PlacemarkWidget extends Equatable {
  final Map<String, dynamic> _json;

  const PlacemarkWidget._(this._json);

  factory PlacemarkWidget.single(PlacemarkWidgetStyle style) {
    return PlacemarkWidget._({
      'type': 'single',
      'style': style.toJson()
    });
  }

  Map<String, dynamic> toJson() => _json;

  @override
  List<Object> get props => <Object>[
    _json
  ];

  @override
  bool get stringify => true;
}

class PlacemarkWidgetStyle extends Equatable {
  final WidgetDescriptor image;

  final Offset anchor;

  final MapKit.RotationType rotationType;

  final double zIndex;

  final bool isFlat;

  final bool isVisible;

  final double scale;

  final MapKit.MapRect? tappableArea;

  /// Creates an icon to be used to represent a [PlacemarkMapObject] on the map.
  const PlacemarkWidgetStyle({
    required this.image,
    this.anchor = const Offset(0.5, 0.5),
    this.rotationType = MapKit.RotationType.noRotation,
    this.zIndex = 0,
    this.isFlat = false,
    this.isVisible = true,
    this.scale = 1,
    this.tappableArea
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image.toJson(),
      'anchor': {
        'dx': anchor.dx,
        'dy': anchor.dy,
      },
      'rotationType': rotationType.index,
      'zIndex': zIndex,
      'isFlat': isFlat,
      'isVisible': isVisible,
      'scale': scale,
      'tappableArea': tappableArea?.toJson()
    };
  }

  @override
  List<Object?> get props => <Object?>[
    anchor,
    rotationType,
    zIndex,
    isFlat,
    isVisible,
    scale,
    tappableArea
  ];

  @override
  bool get stringify => true;
}

class WidgetDescriptor extends Equatable {
  final Map<String, dynamic> _json;

  const WidgetDescriptor._(this._json);

  factory WidgetDescriptor.fromAssetImage(String assetName) {
    return WidgetDescriptor._({
      'type': 'fromAssetImage',
      'assetName': assetName
    });
  }

  Map<String, dynamic> toJson() => _json;

  @override
  List<Object> get props => <Object>[
    _json
  ];

  @override
  bool get stringify => true;
}
