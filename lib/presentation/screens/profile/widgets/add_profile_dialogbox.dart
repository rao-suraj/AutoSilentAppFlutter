import 'package:auto_silent_app/gen/assets.gen.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/presentation/screens/widgets/custom_switch.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:auto_silent_app/presentation/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddProfileDialogbox extends StatefulWidget {
  final double volumeLevel;
  final double ringerLevel;
  const AddProfileDialogbox(
      {super.key, required this.volumeLevel, required this.ringerLevel});

  @override
  State<AddProfileDialogbox> createState() => _AddProfileDialogboxState();
}

class _AddProfileDialogboxState extends State<AddProfileDialogbox> {
  late double selectedVolumeLevel = 0.7;
  late double selectedRingerLevel = 0.5;
  bool isDND = false;
  bool isVibration = false;
  String? title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectedVolumeLevel = widget.volumeLevel;
    selectedRingerLevel = widget.ringerLevel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: colorScheme.surface,
      contentPadding:
          const EdgeInsets.only(top: 25, right: 20, left: 20, bottom: 20),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                width: 190,
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title can't be empty";
                    }
                    return null;
                  },
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Icon(
                  AppIcons.content_copy,
                  size: 28,
                ),
              )
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Volume Level",
                  style: textTheme.h3ExtraBold.copyWith(color: colorScheme.onPrimary),
                ),
                const Gap(3),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(10)),
                  child: Slider(
                    value: selectedVolumeLevel,
                    activeColor:colorScheme.primary ,
                    divisions: 10,
                    onChanged: (level) {
                      setState(() {
                        selectedVolumeLevel = level;
                      });
                    },
                    label:
                        "${selectedVolumeLevel * 10}", // because the value is in double
                  ),
                )
              ],
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ringer Level",
                  style:textTheme.h3ExtraBold.copyWith(color: colorScheme.onPrimary),
                ),
                const Gap(3),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(10)),
                  child: Slider(
                    activeColor: isDND ||
                            isVibration // if both the DND and Vibration are not active then ringer volume can be set
                        ? Colors.grey
                        : colorScheme.primary,
                    value: selectedRingerLevel,
                    divisions: 10,
                    onChanged: (level) {
                      setState(() {
                        // if the user sets the ringer volume then the DND and Vibration must be deactivated
                        isDND = isVibration = false;
                        selectedRingerLevel = level;
                      });
                    },
                    label: "${selectedRingerLevel * 10}",
                  ),
                )
              ],
            ),
            const Gap(10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.onPrimary),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Assets.images.dndIcon.svg(
                          width: 30,
                          colorFilter: ColorFilter.mode(
                              colorScheme.primary, BlendMode.srcIn)),
                      const Gap(10),
                      CustomSwitch(
                          value: false,
                          width: 45,
                          height: 24,
                          onChange: (value) {
                            setState(() {
                              setState(() {
                                // if the DND is active the Vibration has to be deactivated
                                if (isDND) {
                                  isDND = false;
                                } else {
                                  isDND = true;
                                  isVibration = false;
                                }
                              });
                            });
                          })
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.onPrimary),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Assets.images.vibrationIcon.svg(
                          width: 30,
                          colorFilter: ColorFilter.mode(
                              colorScheme.primary, BlendMode.srcIn)),
                      const Gap(10),
                      CustomSwitch(
                          value: false,
                          width: 45,
                          height: 24,
                          onChange: (value) {
                            setState(() {
                              // if vibration is active then DND has to be deactivated
                              if (isVibration) {
                                isVibration = false;
                              } else {
                                isVibration = true;
                                isDND = false;
                              }
                            });
                          })
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onPrimary,
                textStyle: textTheme.h3Regular,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: textTheme.h3Medium,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.onPrimary,
              textStyle: textTheme.h3Regular,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<ProfileCubit>().insertProfile(
                    title: title!.capitalize(),
                    volumeLevel: selectedVolumeLevel,
                    ringerLevel: selectedRingerLevel,
                    isDNDActive: isDND,
                    isVibrationActive: isVibration);
                Navigator.pop(context);
              }
            },
            child: Text(
              "Add",
              style: textTheme.h3Medium,
            ),
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
