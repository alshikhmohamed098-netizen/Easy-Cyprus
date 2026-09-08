import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationAndPrivacyDialog extends StatefulWidget {
  final VoidCallback onPermissionGranted;
  const LocationAndPrivacyDialog({super.key, required this.onPermissionGranted});

  @override
  State<LocationAndPrivacyDialog> createState() => _LocationAndPrivacyDialogState();
}

class _LocationAndPrivacyDialogState extends State<LocationAndPrivacyDialog> {
  bool _accepted = false;

  Future<void> _requestPermission() async {
    if (!_accepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى الموافقة على الشروط أولاً.')),
      );
      return;
    }
    PermissionStatus status = await Permission.locationWhenInUse.request();
    if (status.isGranted && mounted) {
      Navigator.pop(context);
      widget.onPermissionGranted();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFE0F2F1),
              child: Icon(Icons.location_on, size: 35, color: Color(0xFF008080)),
            ),
            const SizedBox(height: 16),
            const Text('استخدام الموقع والخصوصية',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              'نحتاج للوصول إلى موقعك الجغرافي لعرض حالة الطقس والمطاعم والمعالم السياحية القريبة منك في قبرص وتحديدها على الخريطة.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: _accepted,
                  activeColor: const Color(0xFF008080),
                  onChanged: (val) => setState(() => _accepted = val ?? false),
                ),
                const Expanded(
                  child: Text('أوافق على سياسة الخصوصية والشروط والأحكام.',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF008080),
                  foregroundColor: Colors.white,
                ),
                onPressed: _requestPermission,
                child: const Text('الموافقة ومتابعة الإذن'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
