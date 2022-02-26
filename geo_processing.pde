ArrayList<Geometry> geometries = new ArrayList<Geometry>();
JSONObject json;

void setup() {
  size(1000, 1000);
  loadData();
  stroke(225);
  fill(200);
  noLoop(); // 重いからdrawは一回だけ
}

void draw() {
  background(0);
  for (Geometry geometry : geometries) {
    drawGeometry(geometry);
  }

  // テキスト
  text("New York City", 80, 800); // 日本語は文字化けします
  text("by Masato Ishikawa", 70, 815);
}

void loadData() {
  // Load json
  json = loadJSONObject("nyc-streets.geojson");
  JSONArray featureData = json.getJSONArray("features");

  for (int i = 0; i < featureData.size(); i++) {
    JSONObject featureJSONObject = featureData.getJSONObject(i);
    // Feature以外のデータは除外
    try {
      // geometryのJsonオブジェクトを取得
      JSONObject geometryJSONObject = featureJSONObject.getJSONObject("geometry");
      // typeがLineString以外のものを除外

      // パース
      Geometry geometry = new Geometry(
        geometryJSONObject.getString("type"),
        geometryJSONObject.getJSONArray("coordinates")
        );
      geometries.add(geometry);
    }
    catch(Exception e) {
      //println(e);
    }
  }
 }

void drawGeometry(Geometry geometry) {
  ArrayList<Coordinate> coordinates = geometry.coordinates;

  for (int i = 1; i < coordinates.size(); i++) {
    Coordinate fixedStartCoordinate = mapCoordinateToWindow(coordinates.get(i-1));
    Coordinate fixedEndCoordinate = mapCoordinateToWindow(coordinates.get(i));
    line(fixedStartCoordinate.lon, fixedStartCoordinate.lat, fixedEndCoordinate.lon, fixedEndCoordinate.lat);
  }
}

Coordinate mapCoordinateToWindow(Coordinate coordinate) {
  return new Coordinate(
    map(coordinate.lat, 40.55, 40.92, 0 + 50, 1000 - 50),
    map(coordinate.lon, -74.05, -73.69, 0 + 50, 1000 - 50)
    );
}

/** Windowをクリックすると画像が保存され終了する */
void mousePressed() {
  save("output.jpeg");
  exit();
}
