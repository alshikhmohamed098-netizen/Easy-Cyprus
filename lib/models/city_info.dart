class CityInfo {
  final String name;
  final String description;
  final List<String> images;
  final double temp;
  final String weatherCondition;

  CityInfo({
    required this.name,
    required this.description,
    required this.images,
    required this.temp,
    required this.weatherCondition,
  });
}

final List<CityInfo> cyprusCities = [
  CityInfo(
    name: 'أيانابا (Ayia Napa)',
    description: 'معروفة بشواطئها الفيروزية الساحرة ومناظرها الطبيعية الخلابة.',
    images: List.generate(5, (i) => 'assets/images/ayia_napa_${i + 1}.jpg'),
    temp: 29.0,
    weatherCondition: 'مشمس ☀️',
  ),
  CityInfo(
    name: 'لارنكا (Larnaca)',
    description: 'تتميز بأشجار النخيل المترامية على الشاطئ والبحيرة الملحية.',
    images: List.generate(5, (i) => 'assets/images/larnaca_${i + 1}.jpg'),
    temp: 28.5,
    weatherCondition: 'معتدل 🌤️',
  ),
  CityInfo(
    name: 'ليماسول (Limassol)',
    description: 'قلب قبرص التجاري والحديث مع المارينا والمطاعم الراقية.',
    images: List.generate(5, (i) => 'assets/images/limassol_${i + 1}.jpg'),
    temp: 27.8,
    weatherCondition: 'صافٍ 🌤️',
  ),
  CityInfo(
    name: 'بافوس (Paphos)',
    description: 'مزيج رائع بين المواقع الأثرية القديمة والطبيعة الجبلية.',
    images: List.generate(5, (i) => 'assets/images/paphos_${i + 1}.jpg'),
    temp: 26.5,
    weatherCondition: 'مشمس ☀️',
  ),
];
