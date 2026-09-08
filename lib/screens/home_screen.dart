import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/city_info.dart';
import '../widgets/location_privacy_dialog.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const HomeScreen({super.key, required this.onLanguageChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  Map<String, dynamic>? _budgetResult;

  final DatabaseReference _restaurantsRef = FirebaseDatabase.instance.ref('restaurants');
  final DatabaseReference _carOfficesRef = FirebaseDatabase.instance.ref('car_offices');

  GoogleMapController? _mapController;
  static const LatLng _cyprusCenter = LatLng(34.9823, 33.1424);

  final Set<Marker> _cyprusMarkers = {
    const Marker(
      markerId: MarkerId('ayia_napa'),
      position: LatLng(34.9885, 34.0018),
      infoWindow: InfoWindow(title: 'أيانابا'),
    ),
    const Marker(
      markerId: MarkerId('larnaca'),
      position: LatLng(34.9229, 33.6233),
      infoWindow: InfoWindow(title: 'لارنكا'),
    ),
    const Marker(
      markerId: MarkerId('limassol'),
      position: LatLng(34.6786, 33.0413),
      infoWindow: InfoWindow(title: 'ليماسول'),
    ),
    const Marker(
      markerId: MarkerId('paphos'),
      position: LatLng(34.7754, 32.4245),
      infoWindow: InfoWindow(title: 'بافوس'),
    ),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPrivacyAndLocationDialog();
    });
  }

  @override
  void dispose() {
    _budgetController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  void _showPrivacyAndLocationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LocationAndPrivacyDialog(
        onPermissionGranted: () {},
      ),
    );
  }

  void _calculateBudget() {
    double total = double.tryParse(_budgetController.text) ?? 0;
    int days = int.tryParse(_daysController.text) ?? 1;

    if (total > 0 && days > 0) {
      setState(() {
        _budgetResult = {
          'stayPerNight': (total * 0.45) / days,
          'foodPerDay': (total * 0.30) / days,
          'transportPerDay': (total * 0.15) / days,
          'emergencyTotal': (total * 0.10),
        };
      });
    }
  }

  Future<void> _openWhatsApp(String phone) async {
    if (phone.isEmpty) return;
    final Uri url = Uri.parse("https://wa.me/$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل قبرص السياحي'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (langCode) => widget.onLanguageChange(Locale(langCode)),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'ar', child: Text('العربية')),
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'de', child: Text('Deutsch')),
              PopupMenuItem(value: 'ru', child: Text('Русский')),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBudgetCard(),
            const SizedBox(height: 24),
            _buildMapSection(),
            const SizedBox(height: 24),
            _buildCitiesSection(),
            const SizedBox(height: 24),
            _buildRestaurantsSection(),
            const SizedBox(height: 24),
            _buildCarOfficesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.teal),
                SizedBox(width: 8),
                Text('مخطط الميزانية الذكي',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'الميزانية الكلية (€)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.euro),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _daysController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'عدد الأيام',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                onPressed: _calculateBudget,
                child: const Text('حساب التوزيع المقترح'),
              ),
            ),
            if (_budgetResult != null) ...[
              const Divider(height: 24),
              Text('• الفنادق والإقامة: ${_budgetResult!['stayPerNight'].toStringAsFixed(1)} € / ليلة'),
              Text('• المطاعم والوجبات: ${_budgetResult!['foodPerDay'].toStringAsFixed(1)} € / يومياً'),
              Text('• المواصلات والسيارات: ${_budgetResult!['transportPerDay'].toStringAsFixed(1)} € / يومياً'),
              Text('• هامش الطوارئ والأنشطة: ${_budgetResult!['emergencyTotal'].toStringAsFixed(1)} €'),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('خريطة قبرص التفاعلية',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.teal, width: 2),
          ),
          clipBehavior: Clip.antiAlias,
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(target: _cyprusCenter, zoom: 8.2),
            markers: _cyprusMarkers,
            onMapCreated: (controller) => _mapController = controller,
          ),
        ),
      ],
    );
  }

  Widget _buildCitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('المحافظات والطقس',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cyprusCities.length,
            itemBuilder: (context, index) {
              final city = cyprusCities[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(left: 12),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 95,
                        color: Colors.teal.shade200,
                        child: const Center(
                          child: Icon(Icons.landscape, size: 45, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(city.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text('الطقس: ${city.temp}°C | ${city.weatherCondition}',
                                style: const TextStyle(color: Colors.teal, fontSize: 12)),
                            Text(city.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('المطاعم والأسعار المحدثة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: _restaurantsRef.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
              return const Text('لا توجد مطاعم مضافة حالياً.');
            }

            Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<dynamic> list = map.values.toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                var rest = list[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.restaurant, color: Colors.teal),
                    title: Text(rest['name'] ?? ''),
                    subtitle: Text('المحافظة: ${rest['city']}'),
                    trailing: Text('${rest['avgMealPrice']} €',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCarOfficesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('مكاتب السيارات والتوصيل',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: _carOfficesRef.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
              return const Text('لا توجد مكاتب سيارات مضافة.');
            }

            Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<dynamic> list = map.values.toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                var office = list[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.directions_car, color: Colors.teal),
                    title: Text(office['name'] ?? ''),
                    subtitle: Text(
                        '${office['city']} - ${office['offersDelivery'] == true ? "توصيل متوفر 🚚" : "بدون توصيل"}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.chat, color: Colors.green),
                      onPressed: () => _openWhatsApp(office['whatsappPhone'] ?? ''),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
