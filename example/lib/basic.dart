import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:maplibre_gl_example/util.dart';

class BasicMap extends StatefulWidget {
  const BasicMap({super.key});

  @override
  State<BasicMap> createState() => _BasicMapState();
}

class _BasicMapState extends State<BasicMap> {

  late MaplibreMapController _map;

  final point1 =  LatLng(5.332025, -4.020256);
  final point2 =   LatLng(5.332077, -4.021418);

  void _onMapCreated(MaplibreMapController controller) async {
      _map = controller;
         
  }

  void _onStyleLoaded() async {
    await addImageFromAsset(_map, "marker", "assets/symbols/custom-marker.png");
    _map.addGeoJsonSource("sourceid", _buildFeature(point1));
    _map.addSymbolLayer("sourceid", "layerId", const SymbolLayerProperties(
        iconImage: "marker",
        iconAllowOverlap: true,
        iconSize: 1.1) );
    print("layers added");
  }

  Map<String, Object> _buildFeature(LatLng point) {
    return {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "properties": {},
          "geometry": {
            "type": "Point",
            "coordinates": [point.longitude, point.latitude]
          }
        }
      ]
    };
  }


 void _rotateLayer() async {
   await _map.setLayerIconRotate("layerId", 90);
  //  await _map.setLayerIconImage("layerId", "marker");
 }

   void _zoomIn() async {
    _map.zoomIn();
  }

  void _zoomOut() async {
    _map.zoomOut();
  }


  @override
  Widget build(BuildContext context) {
    final MaplibreMap _MapView = MaplibreMap(
        styleString: "https://api.maptiler.com/maps/2afdb0dd-9e92-482e-9187-6aa93334a9db/style.json?key=kj2srrilWCAxNSj4WpmF",
        initialCameraPosition:  CameraPosition(target: point1, zoom: 13),
        onMapCreated: _onMapCreated,
        onStyleLoadedCallback: _onStyleLoaded,
        annotationOrder: const [
          AnnotationType.fill,
          AnnotationType.line,
          AnnotationType.symbol,
          AnnotationType.circle,
        ],
    );


    return Scaffold(
      body: _MapView,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          FloatingActionButton(
            onPressed: _rotateLayer,
            child: const Icon(Icons.place),
          ),
          FloatingActionButton(
            onPressed: _zoomIn,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _zoomOut,
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}