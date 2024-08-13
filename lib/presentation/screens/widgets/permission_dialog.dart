import 'package:auto_silent_app/domain/utils/enums.dart';
import 'package:auto_silent_app/presentation/cubits/permission_cubit/permission_cubit.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionDialogbox extends StatelessWidget {
  final PermissionType title;
  final String message;
  const PermissionDialogbox(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: colorScheme.surface,
      contentPadding:
          const EdgeInsets.only(top: 25, right: 20, left: 20, bottom: 20),
      content: Text(message, style: textTheme.h2Regular),
      actions: [
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
                textStyle: textTheme.h4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              if (title == PermissionType.dndPermission) {
                // print("DND ");
                context.read<PermissionCubit>().askDNDPermission();
              } else {
                context.read<PermissionCubit>().askAlarmPermission();
              }
              Navigator.pop(context);
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
