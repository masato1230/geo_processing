class Geometry {
  String type;
  ArrayList<Coordinate> coordinates = new ArrayList<Coordinate>();

  Geometry(String type_, JSONArray coordinatesJSONArray) {
    type = type_;
    for (int i = 0; i < coordinatesJSONArray.size(); i++) {
      JSONArray coordinateJSONArray = coordinatesJSONArray.getJSONArray(i);
      
      float lon = coordinateJSONArray.getFloat(0);
      float lat = coordinateJSONArray.getFloat(1);
      Coordinate coordinate = new Coordinate(lat, lon);
      
      coordinates.add(coordinate);
    }
  }
}
