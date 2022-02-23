Geometry[] geometries;
JSONObject json;

void setup() {
  size(640, 360);
  loadData();
}

void draw() {
  background(255);
  
  loadData();
  if (geometries != null) {
    print(geometries[0].type);
  }
}

void loadData() {
  // Load json
  json = loadJSONObject("nyc-streets.geojson");
  JSONArray featureData = json.getJSONArray("features");
  
  for (int i = 0; i < featureData.size(); i++) {
    JSONObject featureJSONObject = featureData.getJSONObject(i);
    // Feature以外のデータは除外
    if (featureJSONObject.getString("type") != "Feature") continue;
    
    // geometryのJsonオブジェクトを取得
    JSONObject geometryJSONObject = featureJSONObject.getJSONObject("geometry");
    // typeがLineString以外のものを除外
    if (geometryJSONObject.getString("type") != "LineString") continue;
    
    // パース
    Geometry geometry = new Geometry(
      featureJSONObject.getString("type"),
      featureJSONObject.getJSONArray("geometry")
     );
    geometries[i] = geometry;
  }
}