import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/icon_option_item.dart';
import 'package:flutter/material.dart';

class IconSelectorGrid extends StatelessWidget {
  final List<String> icons;
  final int selectedIndex;
  final Function(int) onIconSelected;

  const IconSelectorGrid({
    super.key,
    required this.icons,
    required this.selectedIndex,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return IconOptionItem(
          iconPath: icons[index],
          isSelected: selectedIndex == index,
          index: index,
          onTap: () => onIconSelected(index),
        );
      },
    );
  }
}