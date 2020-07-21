import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:object_detection/ui/camera_view_singleton.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Recognition {
  int _id;
  String _label;
  double _score;
  Rect _location;

  Recognition(this._id, this._label, this._score, [this._location]);

  String get id => _id.toString();

  String get label => _label;

  double get score => _score;

  Rect get location => _location;

  Rect get renderLocation {
    // ratioX = screenWidth / imageInputWidth
    // ratioY = ratioX if image fits screenWidth with aspectRatio = constant

    double ratioX = CameraViewSingleton.ratio;
    double ratioY = ratioX;

    double transLeft = max(0.1, location.left * ratioX);
    double transTop = max(0.1, location.top * ratioY);
    double transWidth = min(
        location.width * ratioX, CameraViewSingleton.actualPreviewSize.width);
    double transHeight = min(
        location.height * ratioY, CameraViewSingleton.actualPreviewSize.height);

    Rect transformedRect =
        Rect.fromLTWH(transLeft, transTop, transWidth, transHeight);
    return transformedRect;
  }

  @override
  String toString() {
    return 'Recognition(id: $id, label: $label, score: $score, location: $location)';
  }
}