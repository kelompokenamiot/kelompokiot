#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#include <DHT.h>
#include <DHT_U.h>
#include <NTPClient.h>
#include <WiFiUdp.h>

#define DHT_PIN_1 D1
#define DHT_PIN_2 D2
#define DHTTYPE DHT22
#define FIREBASE_HOST "sensordht22-70d71-default-rtdb.asia-southeast1.firebasedatabase.app"
#define FIREBASE_AUTH "5656sp63Ou5b9PWCyQw5HEXTRVqU5UvcliQuxFuH"
#define WIFI_SSID "bekatonik ria 4"
#define WIFI_PASSWORD "Lims1121"

DHT dht1(DHT_PIN_1, DHTTYPE);
DHT dht2(DHT_PIN_2, DHTTYPE);

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP);

float humidity1, temp_C1, temp_F1, humidity2, temp_C2, temp_F2;

unsigned long previousMillis1 = 0;
unsigned long previousMillis2 = 0; 
const long interval1 = 600000;     
const long interval2 = 1000;       

void setup() {
  Serial.begin(9600);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());

  dht1.begin();
  dht2.begin();

  timeClient.begin();

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  delay(1000);
}

void loop() {
  unsigned long currentMillis = millis();

  // Upload data setiap 10 menit
  if (currentMillis - previousMillis1 >= interval1) {
    previousMillis1 = currentMillis;

    timeClient.update();
    String currentTime = timeClient.getFormattedTime();

    temp_C1 = dht1.readTemperature();
    temp_F1 = dht1.readTemperature(true);
    humidity1 = dht1.readHumidity();

    temp_C2 = dht2.readTemperature();
    temp_F2 = dht2.readTemperature(true);
    humidity2 = dht2.readHumidity();

    saveData("sensor1_10min", currentTime, humidity1, temp_C1, temp_F1);
    saveData("sensor2_10min", currentTime, humidity2, temp_C2, temp_F2);
  }

  // Upload data setiap 1 detik
  if (currentMillis - previousMillis2 >= interval2) {
    previousMillis2 = currentMillis;

    timeClient.update();


    temp_C1 = dht1.readTemperature();
    temp_F1 = dht1.readTemperature(true);
    humidity1 = dht1.readHumidity();

    temp_C2 = dht2.readTemperature();
    temp_F2 = dht2.readTemperature(true);
    humidity2 = dht2.readHumidity();

    saveDataDetail("sensor1", humidity1, temp_C1, temp_F1);
    saveDataDetail("sensor2", humidity2, temp_C2, temp_F2);
  }
}

void saveData(const char *sensor, String currentTime, float humidity, float temp_C, float temp_F) {
  String path = "/" + String(sensor) + "/" + currentTime ;

  Firebase.setFloat(path + "/humidity", humidity);
  if (Firebase.failed()) {
    Serial.print("setting ");
    Serial.print(path);
    Serial.print("/humidity failed:");
    Serial.println(Firebase.error());
    return;
  }
  delay(1000);

  Firebase.setFloat(path + "/temp_C", temp_C);
  if (Firebase.failed()) {
    Serial.print("setting ");
    Serial.print(path);
    Serial.print("/TemperatureC failed:");
    Serial.println(Firebase.error());
    return;
  }
  delay(1000);

  Firebase.setFloat(path + "/temp_F", temp_F);
  if (Firebase.failed()) {
    Serial.print("setting ");
    Serial.print(path);
    Serial.print("/TemperatureF failed:");
    Serial.println(Firebase.error());
    return;
  }
  delay(1000);
}

void saveDataDetail(const char *sensor,  float humidity, float temp_C, float temp_F) {
  String path = "/" + String(sensor);

  Firebase.setFloat(path + "/humidity", humidity);
  if (Firebase.failed()) {
    Serial.print("setting ");
    Serial.print(path);
    Serial.print("/humidity failed:");
    Serial.println(Firebase.error());
    return;
  }
  delay(1000);

  Firebase.setFloat(path + "/temp_C", temp_C);
  if (Firebase.failed()) {
    Serial.print("setting ");
    Serial.print(path);
    Serial.print("/TemperatureC failed:");
    Serial.println(Firebase.error());
    return;
  }
  delay(1000);

  Firebase.setFloat(path + "/temp_F", temp_F);
  if (Firebase.failed()) {
    Serial.print("setting ");
    Serial.print(path);
    Serial.print("/TemperatureF failed:");
    Serial.println(Firebase.error());
    return;
  }
  delay(1000);
}
