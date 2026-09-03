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

  const dailyBudget =
    budget && days ? Math.round(Number(budget) / Number(days)) : 0;

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content}>
        <Text style={styles.logo}>Easy Cyprus 🇨🇾</Text>

        <Text style={styles.title}>خطط رحلتك إلى قبرص بسهولة</Text>

        <Text style={styles.subtitle}>
          أدخل ميزانيتك وعدد الأيام، وسنساعدك في إنشاء خطة مناسبة لرحلتك.
        </Text>

        <View style={styles.card}>
          <Text style={styles.label}>💰 ميزانية الرحلة</Text>

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
            {["ليماسول", "لارنكا", "بافوس", "نيقوسيا"].map((item) => (
              <TouchableOpacity
                key={item}
                style={[
                  styles.cityButton,
                  city === item && styles.citySelected,
                ]}
                onPress={() => setCity(item)}
              >
                <Text
                  style={[
                    styles.cityText,
                    city === item && styles.cityTextSelected,
                  ]}
                >
                  {item}
                </Text>
              </TouchableOpacity>
            ))}
          </View>

          <TouchableOpacity style={styles.mainButton} onPress={createPlan}>
            <Text style={styles.mainButtonText}>✨ أنشئ خطتي</Text>
          </TouchableOpacity>
        </View>

        {showPlan && (
          <View style={styles.planCard}>
            <Text style={styles.planTitle}>🎉 خطتك المقترحة</Text>

            <Text style={styles.info}>
              📍 المدينة: {city}
            </Text>

            <Text style={styles.info}>
              📅 مدة الرحلة: {days} أيام
            </Text>

            <Text style={styles.info}>
              💰 الميزانية اليومية التقريبية: {dailyBudget}
            </Text>

            <View style={styles.dayCard}>
              <Text style={styles.dayTitle}>اليوم 1 🌊</Text>
              <Text style={styles.dayText}>
                • الوصول واستكشاف المدينة
              </Text>
              <Text style={styles.dayText}>
                • جولة في المنطقة القديمة
              </Text>
              <Text style={styles.dayText}>
                • عشاء اقتصادي
              </Text>
            </View>

            <View style={styles.dayCard}>
              <Text style={styles.dayTitle}>اليوم 2 🏖️</Text>
              <Text style={styles.dayText}>
                • زيارة أحد الشواطئ الجميلة
              </Text>
              <Text style={styles.dayText}>
                • وقت للراحة والتصوير
              </Text>
              <Text style={styles.dayText}>
                • تجربة مطعم محلي
              </Text>
            </View>

            <View style={styles.dayCard}>
              <Text style={styles.dayTitle}>اليوم 3 🍽️</Text>
              <Text style={styles.dayText}>
                • جولة سياحية جديدة
              </Text>
              <Text style={styles.dayText}>
                • تجربة الأكل القبرصي
              </Text>
              <Text style={styles.dayText}>
                • حلويات ومقهى
              </Text>
            </View>

            <View style={styles.specialCard}>
              <Text style={styles.specialTitle}>
                🕌 خيارات عربية وحلال
              </Text>

              <Text style={styles.specialText}>
                سنضيف لاحقًا قائمة المطاعم العربية والحلال والحلويات العربية
                مع الأسعار والمواقع.
              </Text>
            </View>

            <View style={styles.specialCard}>
              <Text style={styles.specialTitle}>
                💡 نصيحة Easy Cyprus
              </Text>

              <Text style={styles.specialText}>
                قارن الأسعار قبل الحجز، واختر الأنشطة المناسبة لميزانيتك.
              </Text>
            </View>
          </View>
        )}

        <Text style={styles.footer}>
          Easy Cyprus 🇨🇾
        </Text>

        <Text style={styles.footerText}>
          رحلتك إلى قبرص... أسهل وأذكى
        </Text>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#F5F8FC",
  },

  content: {
    padding: 20,
    paddingBottom: 40,
  },

  logo: {
    fontSize: 30,
    fontWeight: "bold",
    textAlign: "center",
    color: "#1677C8",
    marginTop: 20,
  },

  title: {
    fontSize: 23,
    fontWeight: "bold",
    textAlign: "center",
    color: "#172B4D",
    marginTop: 15,
  },

  subtitle: {
    fontSize: 15,
    textAlign: "center",
    color: "#667085",
    lineHeight: 24,
    marginTop: 10,
    marginBottom: 20,
  },

  card: {
    backgroundColor: "#FFFFFF",
    borderRadius: 18,
    padding: 20,
    elevation: 4,
  },

  label: {
    fontSize: 16,
    fontWeight: "bold",
    color: "#172B4D",
    marginBottom: 8,
    marginTop: 8,
  },

  input: {
    height: 52,
    borderWidth: 1,
    borderColor: "#D0D5DD",
    borderRadius: 12,
    paddingHorizontal: 15,
    fontSize: 16,
    backgroundColor: "#FAFAFA",
    textAlign: "right",
  },

  cities: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: 8,
    marginBottom: 15,
  },

  cityButton: {
    borderWidth: 1,
    borderColor: "#B8C4D6",
    borderRadius: 20,
    paddingHorizontal: 14,
    paddingVertical: 9,
    marginBottom: 5,
  },

  citySelected: {
    backgroundColor: "#1677C8",
    borderColor: "#1677C8",
  },

  cityText: {
    color: "#344054",
    fontSize: 14,
  },

  cityTextSelected: {
    color: "#FFFFFF",
    fontWeight: "bold",
  },

  mainButton: {
    backgroundColor: "#1677C8",
    borderRadius: 14,
    paddingVertical: 16,
    marginTop: 10,
  },

  mainButtonText: {
    color: "#FFFFFF",
    fontSize: 18,
    fontWeight: "bold",
    textAlign: "center",
  },

  planCard: {
    backgroundColor: "#FFFFFF",
    borderRadius: 18,
    padding: 20,
    marginTop: 20,
    elevation: 4,
  },

  planTitle: {
    fontSize: 24,
    fontWeight: "bold",
    color: "#172B4D",
    textAlign: "center",
    marginBottom: 18,
  },

  info: {
    fontSize: 16,
    color: "#344054",
    marginBottom: 10,
    textAlign: "right",
  },

  dayCard: {
    backgroundColor: "#F2F7FC",
    borderRadius: 14,
    padding: 15,
    marginTop: 12,
  },

  dayTitle: {
    fontSize: 18,
    fontWeight: "bold",
    color: "#1677C8",
    marginBottom: 8,
    textAlign: "right",
  },

  dayText: {
    fontSize: 15,
    color: "#475467",
    lineHeight: 25,
    textAlign: "right",
  },

  specialCard: {
    backgroundColor: "#FFF8E7",
    borderRadius: 14,
    padding: 15,
    marginTop: 12,
  },

  specialTitle: {
    fontSize: 17,
    fontWeight: "bold",
    color: "#8A5A00",
    textAlign: "right",
    marginBottom: 6,
  },

  specialText: {
    fontSize: 14,
    color: "#6B5B35",
    lineHeight: 23,
    textAlign: "right",
  },

  footer: {
    fontSize: 20,
    fontWeight: "bold",
    color: "#1677C8",
    textAlign: "center",
    marginTop: 30,
  },

  footerText: {
    fontSize: 14,
    color: "#667085",
    textAlign: "center",
    marginTop: 5,
  },
});
