import 'dart:math';

double? gridToLat(String grid) {
  if (grid.length < 4) return null;
  grid = grid.toUpperCase();
  final l2 = grid.codeUnitAt(1) - 65;
  final d2 = int.tryParse(grid[3]) ?? 0;

  var lat = (l2 * 10 + d2 + 0.5 - 90).toDouble();

  if (grid.length >= 6) {
    final l6 = grid.codeUnitAt(5) - 65;
    lat += (l6 + 0.5) * (1 / 24);
  }

  return lat;
}

double? gridToLon(String grid) {
  if (grid.length < 4) return null;
  grid = grid.toUpperCase();
  final l1 = grid.codeUnitAt(0) - 65;
  final d1 = int.tryParse(grid[2]) ?? 0;

  var lon = (l1 * 20 + d1 * 2 + 1 - 180).toDouble();

  if (grid.length >= 6) {
    final l5 = grid.codeUnitAt(4) - 65;
    lon += (l5 + 0.5) * (2 / 24);
  }

  return lon;
}

double? parseCoord(String? coord) {
  if (coord == null || coord.isEmpty) return null;
  try {
    final direction = coord[0].toUpperCase();
    final parts = coord.substring(1).trim().split(' ');
    if (parts.length < 2) return null;
    final degrees = double.parse(parts[0]);
    final minutes = double.parse(parts[1]);
    double decimal = degrees + (minutes / 60.0);
    if (direction == 'S' || direction == 'W') decimal = -decimal;
    return decimal;
  } catch (_) {
    return null;
  }
}

double haversine(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371.0;
  final dLat = (lat2 - lat1) * pi / 180;
  final dLon = (lon2 - lon1) * pi / 180;
  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

String formatDistance(double km) {
  if (km < 10) return '${km.toStringAsFixed(1)} km';
  if (km < 1000) return '${km.round()} km';
  return '${(km / 1000).toStringAsFixed(1)}k km';
}

String latLonToGrid(double lat, double lon) {
  // Maidenhead grid square (4-char)
  final adjLon = lon + 180;
  final adjLat = lat + 90;

  final fieldLon = (adjLon / 20).floor();
  final fieldLat = (adjLat / 10).floor();
  final subLon = ((adjLon - fieldLon * 20) / 2).floor();
  final subLat = (adjLat - fieldLat * 10).floor();

  final char1 = String.fromCharCode(65 + fieldLon);
  final char2 = String.fromCharCode(65 + fieldLat);
  final char3 = subLon.toString();
  final char4 = subLat.toString();

  // 6-char precision
  final remLon = adjLon - fieldLon * 20 - subLon * 2;
  final remLat = adjLat - fieldLat * 10 - subLat;
  final char5 = String.fromCharCode(97 + (remLon * 12).floor());
  final char6 = String.fromCharCode(97 + (remLat * 24).floor());

  return '$char1$char2$char3$char4$char5$char6';
}

String formatFreq(String? freq) {
  if (freq == null || freq.isEmpty) return '--';
  final value = double.tryParse(freq);
  if (value == null) return freq;
  return '${value.toStringAsFixed(3)} MHz';
}
