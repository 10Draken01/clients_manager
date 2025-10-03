import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputForm extends StatelessWidget {
  // 📝 Propiedades básicas (required)
  final TextEditingController controller;
  final String labelText;
  
  // 🎨 Propiedades opcionales de texto
  final String? hintText;
  final String? helperText;
  final String? errorText;
  
  // ✅ Validación
  final String? Function(String?)? validator;
  
  // 🎭 Íconos
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  
  // ⌨️ Configuración del teclado
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  
  // 🔒 Seguridad y comportamiento
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autocorrect;
  final bool autofocus;
  
  // 📏 Tamaño
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  
  // 🎯 Focus y callbacks
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  
  // 🎨 Personalización visual (opcional, si no se pasa usa el tema)
  final Color? fillColor;
  final double? borderRadius;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  
  // 🚫 Restricciones
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputForm({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.fillColor,
    this.borderRadius,
    this.border,
    this.contentPadding,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    // 🎨 Obtener el tema actual para usar los colores correctos
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inputTheme = theme.inputDecorationTheme;
    final isDark = theme.brightness == Brightness.dark;
    
    // 🎨 Determinar el color de fondo según el tema
    final backgroundColor = fillColor ?? 
        (enabled 
            ? (isDark ? Color(0xFF2C2C2C) : Colors.white)
            : (isDark ? Color(0xFF1E1E1E) : Colors.grey[100]!));
    
    // 🎨 Determinar el color del borde según el tema
    final borderColor = isDark ? Color(0xFF424242) : Color(0xFFE0E0E0);
    
    // 🎨 Determinar el radio del borde
    final radius = borderRadius ?? 12.0;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autocorrect: autocorrect,
      autofocus: autofocus,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      
      // 🎨 Estilo del texto dentro del input
      style: theme.textTheme.bodyLarge?.copyWith(
        color: enabled ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(0.5),
      ),
      
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        
        // 🎭 Íconos con colores del tema
        prefixIcon: prefixIcon != null 
            ? Icon(
                prefixIcon,
                color: enabled 
                    ? inputTheme.prefixIconColor ?? colorScheme.onSurface.withOpacity(0.6)
                    : colorScheme.onSurface.withOpacity(0.3),
              )
            : null,
        suffixIcon: suffixIcon,
        
        // 🎨 Colores y relleno
        filled: true,
        fillColor: backgroundColor,
        
        // 📏 Padding interno
        contentPadding: contentPadding ?? 
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        
        // 🎨 Estilos de texto (usan el tema)
        labelStyle: inputTheme.labelStyle?.copyWith(
          color: enabled 
              ? colorScheme.onSurface.withOpacity(0.6)
              : colorScheme.onSurface.withOpacity(0.3),
        ),
        hintStyle: inputTheme.hintStyle?.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        helperStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.6),
          fontSize: 12,
        ),
        errorStyle: TextStyle(
          color: colorScheme.error,
          fontSize: 12,
        ),
        
        // 📐 Bordes personalizados
        // Borde normal (cuando no tiene foco)
        border: border ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor),
        ),
        
        // Borde cuando está habilitado
        enabledBorder: border ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor),
        ),
        
        // Borde cuando tiene focus (está activo)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        
        // Borde cuando hay error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1,
          ),
        ),
        
        // Borde cuando hay error y tiene focus
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
        
        // Borde cuando está deshabilitado
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: isDark ? Color(0xFF2C2C2C) : Color(0xFFE0E0E0),
          ),
        ),
      ),
      
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
}