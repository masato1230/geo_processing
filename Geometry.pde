// class Feature {
//   Geometry geoMetry;

//   Feature(String type_, JSONObject geometryJsonArray) {
//     type = type_;
//     y = y_;
//     diameter = diameter_;
//     name = s;
//   }
// }

class Geometry {
    String type;
    float lat;
    float lon;

    Geometry(String type_, JSONArray coordinates_) {
      type = type_;
      JSONArray values = coordinates_.getJSONArray(0);

      for (int i = 0; i < values.size(); i++) {
        lon = values.getFloat(0);
        lat = values.getFloat(1);
      }
    }
  }
