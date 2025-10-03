import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 📝 Esta clase es como una "receta" para crear cada campo del formulario
/// Le dice al formulario: "Este campo es de email, este es de contraseña", etc.
class FormFieldConfig {
  // 🆔 Identificador único del campo (como su nombre)
  final String id;
  
  // 🎨 Textos que se muestran
  final String labelText;
  final String? hintText;
  final String? helperText;
  
  // 🎭 Tipo de campo
  final FormFieldType type;
  
  // ✅ Validación
  final String? Function(String?)? validator;
  final bool isRequired;
  
  // 🎯 Íconos
  final IconData? prefixIcon;
  
  // ⌨️ Configuración del teclado
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  
  // 📏 Tamaño
  final int? maxLines;
  final int? maxLength;
  
  // 🚫 Restricciones de entrada
  final List<TextInputFormatter>? inputFormatters;
  
  // 💡 Valor inicial
  final String? initialValue;
  
  // 🎨 Personalización visual
  final bool enabled;

  FormFieldConfig({
    required this.id,
    required this.labelText,
    this.hintText,
    this.helperText,
    this.type = FormFieldType.text,
    this.validator,
    this.isRequired = false,
    this.prefixIcon,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.initialValue,
    this.enabled = true,
  });

  /// 🏭 Factory para crear campo de Username rápidamente
  factory FormFieldConfig.username({
    String id = 'username',
    String labelText = 'Username',
    String? hintText,
    bool isRequired = true,
    TextInputAction? textInputAction,
  }) {
    return FormFieldConfig(
      id: id,
      labelText: labelText,
      hintText: hintText ?? 'usuario_ejemplo24',
      type: FormFieldType.text,
      isRequired: isRequired,
      prefixIcon: Icons.person,
      keyboardType: TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'El username es obligatorio';
        }
        if (value != null && value.isNotEmpty) {
          final usernameRegex = RegExp(r'^[a-zA-Z0-9._-]{3,16}$');
          if (!usernameRegex.hasMatch(value.trim())) {
            return 'Username inválido';
          }
        }
        return null;
      },
    );
  }

  /// 🏭 Factory para crear campo de Email rápidamente
  factory FormFieldConfig.email({
    String id = 'email',
    String labelText = 'Email',
    String? hintText,
    bool isRequired = true,
    TextInputAction? textInputAction,
  }) {
    return FormFieldConfig(
      id: id,
      labelText: labelText,
      hintText: hintText ?? 'ejemplo@correo.com',
      type: FormFieldType.email,
      isRequired: isRequired,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'El email es obligatorio';
        }
        if (value != null && value.isNotEmpty) {
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value.trim())) {
            return 'Email inválido';
          }
        }
        return null;
      },
    );
  }

  /// 🏭 Factory para crear campo de Contraseña
  factory FormFieldConfig.password({
    String id = 'password',
    String labelText = 'Contraseña',
    String? hintText,
    bool isRequired = true,
    int minLength = 6,
    TextInputAction? textInputAction,
  }) {
    return FormFieldConfig(
      id: id,
      labelText: labelText,
      hintText: hintText ?? '••••••••',
      type: FormFieldType.password,
      isRequired: isRequired,
      prefixIcon: Icons.lock_outline,
      textInputAction: textInputAction ?? TextInputAction.done,
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'La contraseña es obligatoria';
        }
        if (value != null && value.isNotEmpty && value.length < minLength) {
          return 'Mínimo $minLength caracteres';
        }
        return null;
      },
    );
  }

  /// 🏭 Factory para crear campo de Teléfono
  factory FormFieldConfig.phone({
    String id = 'phone',
    String labelText = 'Teléfono',
    String? hintText,
    bool isRequired = true,
    int digits = 10,
    TextInputAction? textInputAction,
  }) {
    return FormFieldConfig(
      id: id,
      labelText: labelText,
      hintText: hintText ?? '9611234567',
      type: FormFieldType.phone,
      isRequired: isRequired,
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction ?? TextInputAction.next,
      maxLength: digits,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'El teléfono es obligatorio';
        }
        if (value != null && value.isNotEmpty && value.length != digits) {
          return 'Debe tener $digits dígitos';
        }
        return null;
      },
    );
  }

  /// 🏭 Factory para campo de texto normal
  factory FormFieldConfig.text({
    required String id,
    required String labelText,
    String? hintText,
    bool isRequired = false,
    IconData? prefixIcon,
    TextInputAction? textInputAction,
    int maxLines = 1,
  }) {
    return FormFieldConfig(
      id: id,
      labelText: labelText,
      hintText: hintText,
      type: FormFieldType.text,
      isRequired: isRequired,
      prefixIcon: prefixIcon,
      textInputAction: textInputAction ?? TextInputAction.next,
      maxLines: maxLines,
      validator: isRequired
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return '$labelText es obligatorio';
              }
              return null;
            }
          : null,
    );
  }
}

/// 📦 Enum para los tipos de campos
/// Es como una lista de "sabores" de campos que podemos crear
enum FormFieldType {
  text,      // Texto normal
  email,     // Email
  password,  // Contraseña
  phone,     // Teléfono
  number,    // Solo números
  multiline, // Texto largo (varias líneas)
}