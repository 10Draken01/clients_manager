import 'package:flutter/material.dart';

class MessageResponseForm extends StatelessWidget {
  final String message;
  final bool isSuccess;
  
  const MessageResponseForm({
    super.key,
    required this.message,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    // 🎨 Colores según el tema y el tipo de mensaje
    final Color backgroundColor;
    final Color borderColor;
    final Color textColor;
    final IconData icon;

    if (isSuccess) {
      // ✅ Mensaje de éxito
      backgroundColor = isDark
          ? colorScheme.primary.withOpacity(0.15)
          : colorScheme.primary.withOpacity(0.1);
      borderColor = isDark ? colorScheme.primary : Colors.green;
      textColor = isDark ? Colors.green[300]! : Colors.green[900]!;
      icon = Icons.check_circle_outline;
    } else {
      // ❌ Mensaje de error
      backgroundColor = isDark
          ? colorScheme.error.withOpacity(0.15)
          : colorScheme.error.withOpacity(0.1);
      borderColor = isDark ? colorScheme.error : Colors.red;
      textColor = isDark ? Colors.red[300]! : Colors.red[900]!;
      icon = Icons.error_outline;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: borderColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}