
import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  SafeAreaView,
} from "react-native";

export default function App() {
  const [budget, setBudget] = useState("");
  const [days, setDays] = useState("");
  const [city, setCity] = useState("ليماسول");
  const [showPlan, setShowPlan] = useState(false);

  const createPlan = () => {
    if (!budget || !days) {
      alert("يرجى إدخال الميزانية وعدد الأيام");
      return;
    }

    setShowPlan(true);
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content}>
        
        <Text style={styles.logo}>🇨🇾 Easy Cyprus</Text>
        <Text style={styles.subtitle}>
          خطط لرحلتك في قبرص بسهولة
        </Text>

        <View style={styles.card}>
          <Text style={styles.title}>✈️ خطط رحلتك</Text>

          <Text style={styles.label}>💰 ميزانية الرحلة (€)</Text>
          <TextInput
            style={styles.input}
            placeholder="مثال: 500"
            keyboardType="numeric"
            value={budget}
            onChangeText={setBudget}
          />

          <Text style={styles.label}>📅 عدد الأيام</Text>
          <TextInput
            style={styles.input}
            placeholder="مثال: 5"
            keyboardType="numeric"
            value={days}
            onChangeText={setDays}
          />

          <Text style={styles.label}>📍 المدينة</Text>

          <View style={styles.cities}>
            {["ليماسول", "لارنكا", "نيقوسيا", "بافوس"].map((item) => (
              <TouchableOpacity
                key={item}
                style={[
                  styles.cityButton,
                  city === item && styles.selectedCity,
                ]}
                onPress={() => setCity(item)}
              >
                <Text
                  style={[
                    styles.cityText,
                    city === item && styles.selectedCityText,
                  ]}
                >
                  {item}
                </Text>
              </TouchableOpacity>
            ))}
          </View>

          <TouchableOpacity
            style={styles.mainButton}
            onPress={createPlan}
          >
            <Text style={styles.mainButtonText}>
              ✨ أنشئ خطتي السياحية
            </Text>
          </TouchableOpacity>
        </View>

        {showPlan && (
          <View style={styles.planCard}>
            <Text style={styles.planTitle}>
              🗺️ خطتك في {city}
            </Text>

            <Text style={styles.info}>
              💶 الميزانية: {budget} €
            </Text>

            <Text style={styles.info}>
              📅 المدة: {days} أيام
            </Text>

            <View style={styles.day}>
              <Text style={styles.dayTitle}>☀️ اليوم الأول</Text>
              <Text style={styles.dayText}>
                🏖️ جولة في المدينة والشاطئ
              </Text>
              <Text style={styles.dayText}>
                🍽️ غداء اقتصادي
              </Text>
              <Text style={styles.dayText}>
                🌅 مشاهدة غروب الشمس
              </Text>
            </View>

            <View style={styles.day}>
              <Text style={styles.dayTitle}>🌴 اليوم الثاني</Text>
              <Text style={styles.dayText}>
                🏛️ زيارة أهم المعالم السياحية
              </Text>
              <Text style={styles.dayText}>
                ☕ مقهى محلي
              </Text>
              <Text style={styles.dayText}>
                🍴 عشاء حلال أو عربي
              </Text>
            </View>

            <View style={styles.day}>
              <Text style={styles.dayTitle}>🚗 اليوم الثالث</Text>
              <Text style={styles.dayText}>
                🌊 رحلة واستكشاف أماكن طبيعية
              </Text>
              <Text style={styles.dayText}>
                📸 أماكن للتصوير
              </Text>
            </View>

            <Text style={styles.note}>
              💡 سيتم تطوير الخطة لاحقًا لتشمل السكن
              والمطاعم والمواصلات والأنشطة والأسعار.
            </Text>
          </View>
        )}

        <View style={styles.features}>
          <Text style={styles.featureTitle}>⭐ مميزات Easy Cyprus</Text>

          <Text style={styles.feature}>
            🏨 مقارنة خيارات السكن
          </Text>

          <Text style={styles.feature}>
            🍽️ مطاعم عربية وحلال
          </Text>

          <Text style={styles.feature}>
            🍰 حلويات عربية
          </Text>

          <Text style={styles.feature}>
            🚌 خيارات المواصلات
          </Text>

          <Text style={styles.feature}>
            🎯 أنشطة تناسب ميزانيتك
          </Text>

          <Text style={styles.feature}>
            💰 خيارات اقتصادية للسائح
          </Text>
        </View>

      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f5f7fa",
  },

  content: {
    padding: 20,
    paddingBottom: 40,
  },

  logo: {
    fontSize: 32,
    fontWeight: "bold",
    textAlign: "center",
    color: "#1769aa",
    marginTop: 20,
  },

  subtitle: {
    fontSize: 17,
    textAlign: "center",
    color: "#555",
    marginTop: 8,
    marginBottom: 25,
  },

  card: {
    backgroundColor: "#ffffff",
    borderRadius: 20,
    padding: 20,
    elevation: 4,
  },

  title: {
    fontSize: 24,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 20,
    color: "#222",
  },

  label: {
    fontSize: 16,
    fontWeight: "bold",
    marginBottom: 8,
    marginTop: 12,
    textAlign: "right",
  },

  input: {
    height: 50,
    borderWidth: 1,
    borderColor: "#ddd",
    borderRadius: 12,
    paddingHorizontal: 15,
    fontSize: 16,
    textAlign: "right",
    backgroundColor: "#fafafa",
  },

  cities: {
    flexDirection: "row",
    flexWrap: "wrap",
    justifyContent: "space-between",
    marginTop: 5,
  },

  cityButton: {
    borderWidth: 1,
    borderColor: "#1769aa",
    borderRadius: 12,
    paddingVertical: 10,
    paddingHorizontal: 12,
    marginBottom: 8,
  },

  selectedCity: {
    backgroundColor: "#1769aa",
  },

  cityText: {
    color: "#1769aa",
    fontWeight: "bold",
  },

  selectedCityText: {
    color: "#fff",
  },

  mainButton: {
    backgroundColor: "#1769aa",
    borderRadius: 14,
    paddingVertical: 16,
    marginTop: 20,
  },

  mainButtonText: {
    color: "#fff",
    textAlign: "center",
    fontSize: 18,
    fontWeight: "bold",
  },

  planCard: {
    backgroundColor: "#fff",
    borderRadius: 20,
    padding: 20,
    marginTop: 20,
    elevation: 3,
  },

  planTitle: {
    fontSize: 23,
    fontWeight: "bold",
    textAlign: "center",
    color: "#1769aa",
    marginBottom: 15,
  },

  info: {
    fontSize: 16,
    textAlign: "right",
    marginBottom: 8,
  },

  day: {
    backgroundColor: "#f1f7fc",
    borderRadius: 14,
    padding: 15,
    marginTop: 12,
  },

  dayTitle: {
    fontSize: 18,
    fontWeight: "bold",
    textAlign: "right",
    marginBottom: 8,
  },

  dayText: {
    fontSize: 15,
    textAlign: "right",
    marginTop: 5,
    color: "#444",
  },

  note: {
    fontSize: 14,
    textAlign: "right",
    color: "#666",
    marginTop: 18,
    lineHeight: 22,
  },

  features: {
    backgroundColor: "#fff",
    borderRadius: 20,
    padding: 20,
    marginTop: 20,
  },

  featureTitle: {
    fontSize: 21,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 15,
  },

  feature: {
    fontSize: 16,
    textAlign: "right",
    marginVertical: 7,
  },
});
