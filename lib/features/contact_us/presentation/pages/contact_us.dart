import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/contact_us/domain/entities/contact_us_entities.dart';
import 'package:iot_app_prot1/features/contact_us/presentation/riverpod/providers.dart';
import 'package:iot_app_prot1/shared_widgets/custom_dropdown.dart';
import 'package:iot_app_prot1/shared_widgets/custom_snackbar.dart';
import 'package:iot_app_prot1/shared_widgets/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUs extends ConsumerStatefulWidget {
  const ContactUs({super.key});

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends ConsumerState<ContactUs> {
  final TextEditingController reasonsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String selectedReason = AppLocalizations.of(context)!.option_problem1;
    List<String> options = [
      AppLocalizations.of(context)!.option_problem1,
      AppLocalizations.of(context)!.option_problem2,
      AppLocalizations.of(context)!.option_problem3,
      AppLocalizations.of(context)!.option_other,
    ];

    List<String> descriptions = [
      AppLocalizations.of(context)!.option_problem1_description,
      AppLocalizations.of(context)!.option_problem2_description,
      AppLocalizations.of(context)!.option_problem3_description,
      AppLocalizations.of(context)!.option_other_description,
    ];
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomDropdown(
                  label: "${AppLocalizations.of(context)!.label_type}:",
                  options: options,
                  descriptions: descriptions,
                  selectedDevice: selectedReason,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedReason = newValue;
                      });
                    }
                  },
                ),
                CustomTextField(
                  controller: reasonsController,
                  hintText: "${AppLocalizations.of(context)!.label_motivations}:",
                  maxLength: 1024,
                  maxLines: 6,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () async {
                    final sendMessage = ref.read(sendMessageProvider);
                    try {
                      await sendMessage(
                        ContactUsEntities(
                          description: reasonsController.text,
                          problem: selectedReason,
                          solved: false,
                        ),
                      );
                      CustomSnackbar.show(
                        context,
                        AppLocalizations.of(context)!.snackbar_contacctus_sent,
                        AppLocalizations.of(context)!.snackbar_contacctus_sent_description,
                      );
                    } catch (error) {
                      CustomSnackbar.show(
                        context,
                        AppLocalizations.of(context)!.snackbar_contacctus_error,
                        AppLocalizations.of(context)!.snackbar_contacctus_error,
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.button_send,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                  indent: 24,
                  endIndent: 24,
                  height: 48,
                ),
                Column(children: [
                  const Column(
                    children: [
                      Icon(Icons.home_work_rounded),
                      Text("Via della Tristezze, 46, Udine (UD)"),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Column(
                    children: [
                      Icon(Icons.phone),
                      Text("0432 785612"),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      const Icon(Icons.access_time_filled_rounded),
                      Text(AppLocalizations.of(context)!.label_days),
                      const Text("08:00 - 17:00"),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      );
    });
  }
}
