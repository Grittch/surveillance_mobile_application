import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/core/utils/screen_size/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iot_app_prot1/shared_widgets/custom_textfield.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Profile> {
  final TextEditingController nameController = TextEditingController(text: "Mario Rossi");
  final TextEditingController emailController = TextEditingController(text: "mario.rossi@mail.com");
  final TextEditingController phoneController = TextEditingController(text: "+39 3274589217");
  final TextEditingController addressController = TextEditingController(text: "Via da Casa Mia, 14, Brescia (BS)");
  final TextEditingController passwordController = TextEditingController(text: "PassTest1234");

  bool isVisible = false;
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    final size = ref.watch(screenSizeProvider);
    final textScaleFactor = size.width / 400;
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: size.height * 0.82,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35 * textScaleFactor,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.account_circle_rounded,
                        size: 70 * textScaleFactor,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: nameController,
                        hintText: AppLocalizations.of(context)!.label_name,
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(controller: emailController, hintText: "Email", keyboardType: TextInputType.emailAddress),
              CustomTextField(controller: phoneController, hintText: AppLocalizations.of(context)!.label_phone, keyboardType: TextInputType.phone),
              CustomTextField(
                  controller: addressController, hintText: AppLocalizations.of(context)!.label_address, keyboardType: TextInputType.streetAddress),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: passwordController,
                      enabled: isEnabled,
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: CheckboxListTile(
                      title: Text(
                        AppLocalizations.of(context)!.option_show_password,
                      ),
                      value: isVisible,
                      enabled: isEnabled,
                      onChanged: (value) {
                        setState(() {
                          isVisible = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                ),
                onPressed: () {
                  setState(() {
                    isEnabled = !isEnabled;
                    isVisible = isVisible == true ? !isVisible : isVisible;
                  });
                },
                child: Text(
                  AppLocalizations.of(context)!.button_edit,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
