import 'package:flutter/material.dart';

class CustomButtonForm extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final bool isLoading;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final IconData? icon;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomButtonForm({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.icon,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    // 🎨 Obtener el tema actual
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // 🎨 Determinar colores según el tema
    final bgColor = backgroundColor ?? colorScheme.primary;
    final fgColor = textColor ?? colorScheme.onPrimary; // Color del texto sobre el botón
    
    // 🎨 Colores cuando está deshabilitado (usando el tema)
    final disabledBgColor = colorScheme.surfaceContainer;
    final disabledFgColor = colorScheme.onSurface.withOpacity(0.38);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        // ⚡ Deshabilitar si está cargando o no habilitado
        onPressed: (isLoading || !isEnabled) ? null : onPressed,
        
        style: ElevatedButton.styleFrom(
          // 🎨 Color de fondo
          backgroundColor: bgColor,
          
          // 🎨 Color del texto e íconos
          foregroundColor: fgColor,
          
          // 🎨 Colores cuando está deshabilitado
          disabledBackgroundColor: disabledBgColor,
          disabledForegroundColor: disabledFgColor,
          
          // 📐 Forma del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          
          // 🌟 Elevación (sombra)
          elevation: (isLoading || !isEnabled) ? 0 : 2,
          
          // 📏 Padding interno
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min, // ← IMPORTANTE: centra el contenido
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: fontSize + 4,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// 🏭 Factory para crear botón primario rápidamente
  factory CustomButtonForm.primary({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
  }) {
    return CustomButtonForm(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
    );
  }

  /// 🏭 Factory para crear botón secundario
  factory CustomButtonForm.secondary({
    required String text,
    required VoidCallback onPressed,
    required BuildContext context,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomButtonForm(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      backgroundColor: colorScheme.secondaryContainer,
      textColor: colorScheme.onSecondaryContainer,
      fontWeight: FontWeight.normal,
    );
  }

  /// 🏭 Factory para crear botón de peligro/eliminar
  factory CustomButtonForm.danger({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
  }) {
    return CustomButtonForm(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      backgroundColor: Colors.red[600],
      textColor: Colors.white,
    );
  }

  /// 🏭 Factory para crear botón de éxito
  factory CustomButtonForm.success({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
  }) {
    return CustomButtonForm(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      backgroundColor: Colors.green[600],
      textColor: Colors.white,
    );
  }

  /// 🏭 Factory para crear botón outline (con borde)
  factory CustomButtonForm.outline({
    required String text,
    required VoidCallback onPressed,
    required BuildContext context,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
    Color? borderColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = borderColor ?? colorScheme.primary;
    return CustomButtonForm(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      backgroundColor: Colors.transparent,
      textColor: color,
    );
  }

  /// 🏭 Factory para crear botón terciario
  factory CustomButtonForm.tertiary({
    required String text,
    required VoidCallback onPressed,
    required BuildContext context,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomButtonForm(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      backgroundColor: colorScheme.tertiaryContainer,
      textColor: colorScheme.onTertiaryContainer,
      fontWeight: FontWeight.normal,
    );
  }

  /// 🏭 Factory para crear botón de advertencia/warning
  factory CustomButtonForm.warning({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isEnabled = true,
    IconData? icon,
  }) {
    return CustomButtonForm(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      backgroundColor: Colors.orange[600],
      textColor: Colors.white,
    );
  }
}