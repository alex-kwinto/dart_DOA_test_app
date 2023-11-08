import 'package:flutter/material.dart';

class FilterIcons extends StatelessWidget {
  final Map<String, bool> flags;
  final icons = <Icon>[];

  FilterIcons({required this.flags}) {
    flags.forEach((key, value) {
      final icon = Icon(
        getIconForFlag(key),
        size: 16,
        color: value ? Colors.black : Colors.grey,
      );
      icons.add(icon);
    });
  }

  IconData getIconForFlag(String flagKey) {
    switch (flagKey) {
      case 'nsfw':
        return Icons.work_off;
      case 'religious':
        return Icons.church;
      case 'political':
        return Icons.how_to_reg;
      case 'racist':
        return Icons.group_off;
      case 'sexist':
        return Icons.volunteer_activism;
      case 'explicit':
        return Icons.explicit;
      default:
        // Return a default icon (you can customize this as needed)
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: icons);
  }
}
