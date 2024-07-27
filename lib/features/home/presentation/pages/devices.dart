import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/constants/constants.dart';
import 'package:iot_app_prot1/features/home/domain/entities/device.dart';
import 'package:iot_app_prot1/features/home/presentation/riverpod/device_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iot_app_prot1/shared_widgets/custom_snackbar.dart';

class Devices extends ConsumerStatefulWidget {
  const Devices({super.key});

  @override
  ConsumerState<Devices> createState() => _DevicesState();
}

class _DevicesState extends ConsumerState<Devices> {
  @override
  Widget build(BuildContext context) {
    var deviceDetails = ref.watch(deviceDetailsProvider("UWNHFXzYiVCx7nz5AdGI"));

    return deviceDetails.when(
      data: (devices) {
        if (devices.isEmpty) {
          return const Center(child: Text('Nessun dispositivo trovato'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: devices.length,
          itemBuilder: (BuildContext context, int index) {
            final device = devices[index];
            return CustomExpansionTileCard(
              device: device,
              onPressed: (deviceId) async {
                if (device.status == -1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackbar.show(
                      context,
                      AppLocalizations.of(context)!.snackbar_update_error,
                      AppLocalizations.of(context)!.snackbar_update_error_description,
                    ),
                  );
                  return;
                }

                await updateDeviceStatus(deviceId, device.status);
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Errore durante il recupero dei dispositivi: $error')),
    );
  }

  Future<void> updateDeviceStatus(String deviceId, int status) async {
    if (status == -1) {
      return;
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('user').doc("UWNHFXzYiVCx7nz5AdGI").collection('devices').doc(deviceId).update({
      'status': status == 1 ? 0 : 1,
    });

    ref.refresh(deviceDetailsProvider("UWNHFXzYiVCx7nz5AdGI"));
  }
}

class CustomExpansionTileCard extends StatelessWidget {
  final Device device;
  final Function onPressed;

  const CustomExpansionTileCard({
    super.key,
    required this.device,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> statusAndColor = selectStatusAndColor(device.status, context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ExpansionTileCard(
        baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        expandedColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        expandedTextColor: Colors.black,
        title: Text("${device.type}-${device.location}"),
        shadowColor: Colors.transparent,
        trailing: IconButton(
          icon: const Icon(Icons.power_settings_new_rounded),
          onPressed: () => onPressed(device.id),
        ),
        subtitle: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 6.5,
              child: Icon(
                Icons.circle_rounded,
                color: statusAndColor["color"],
                size: 12,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(statusAndColor["status"]),
          ],
        ),
        children: <Widget>[
          const Divider(thickness: 0.5, height: 1),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(batteryIcon(device.battery, device.charging)),
                        Text(device.charging ? "In Carica..." : "${device.battery}%"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("DeviceID:"),
                          Text("${AppLocalizations.of(context)!.label_device}:"),
                          Text("${AppLocalizations.of(context)!.label_place}:"),
                          Text("${AppLocalizations.of(context)!.label_installation}:"),
                          Text("${AppLocalizations.of(context)!.label_time_slot}:"),
                        ],
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${device.id.substring(0, 6)}...${device.id.substring(device.id.length - 6)}"),
                          Text(device.type),
                          Text(device.location),
                          Text(formatDateTime(device.date)),
                          Text("${formatTime(device.timeSlot["start"].toDate())} - ${formatTime(device.timeSlot["end"].toDate())}"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Map<String, dynamic> selectStatusAndColor(int status, BuildContext context) {
  Map<String, dynamic> statusAndColor = {};

  if (status == 1) {
    statusAndColor["status"] = "Online";
    statusAndColor["color"] = Colors.green.shade400;
  } else if (status == 0) {
    statusAndColor["status"] = "Offline";
    statusAndColor["color"] = Colors.red.shade400;
  } else {
    statusAndColor["status"] = AppLocalizations.of(context)!.label_problem;
    statusAndColor["color"] = Colors.yellow.shade400;
  }

  return statusAndColor;
}

IconData batteryIcon(int battery, bool isCharging) {
  if (isCharging) {
    return Icons.battery_charging_full_rounded;
  }

  if (battery <= 5) {
    return Icons.battery_0_bar_rounded;
  } else if (battery <= 10) {
    return Icons.battery_1_bar_rounded;
  } else if (battery <= 25) {
    return Icons.battery_2_bar_rounded;
  } else if (battery <= 40) {
    return Icons.battery_3_bar_rounded;
  } else if (battery <= 60) {
    return Icons.battery_4_bar_rounded;
  } else if (battery <= 75) {
    return Icons.battery_5_bar_rounded;
  } else if (battery <= 90) {
    return Icons.battery_6_bar_rounded;
  } else {
    return Icons.battery_full_rounded;
  }
}
