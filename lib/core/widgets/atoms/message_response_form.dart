import 'package:flutter/material.dart';

class MessageResponseForm extends StatelessWidget {
  final String message;
  final bool isSuccess;
  final bool isDark;
  const MessageResponseForm({
    super.key,
    required this.message,
    required this.isSuccess,
    required this.isDark
  });

  @override
  Widget build(BuildContext context) {
    // 🎨 Colores según el tema y el tipo de mensaje
    final Color backgroundColor;
    final Color borderColor;
    final Color textColor;
    final IconData icon;

    if (isSuccess) {
      // ✅ Mensaje de éxito
      backgroundColor = isDark
          ? Color(0xFF1B5E20).withOpacity(0.3) // Verde oscuro con transparencia
          : Colors.green[50]!;
      borderColor = isDark ? Color(0xFF4CAF50) : Colors.green;
      textColor = isDark ? Color(0xFF81C784) : Colors.green[900]!;
      icon = Icons.check_circle_outline;
    } else {
      // ❌ Mensaje de error
      backgroundColor = isDark
          ? Color(0xFFB71C1C).withOpacity(0.3) // Rojo oscuro con transparencia
          : Colors.red[50]!;
      borderColor = isDark ? Color(0xFFEF5350) : Colors.red;
      textColor = isDark ? Color(0xFFEF9A9A) : Colors.red[900]!;
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
