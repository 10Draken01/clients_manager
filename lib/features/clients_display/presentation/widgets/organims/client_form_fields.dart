import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/custom_text_field.dart';
import 'package:clients_manager/features/clients_display/presentation/widgets/atoms/form_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientFormFields extends StatelessWidget {
  final TextEditingController claveController;
  final TextEditingController nombreController;
  final TextEditingController celularController;
  final TextEditingController emailController;
  final bool isEditing;

  const ClientFormFields({
    super.key,
    required this.claveController,
    required this.nombreController,
    required this.celularController,
    required this.emailController,
    this.isEditing = false,
  });

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es obligatorio';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email es obligatorio';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email válido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Celular es obligatorio';
    }
    if (value.length != 10) {
      return 'El celular debe tener 10 dígitos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormSectionTitle(
          title: 'Información del Cliente',
          icon: Icons.person_outline,
        ),
        
        CustomTextField(
          controller: claveController,
          label: 'Clave del Cliente',
          hint: 'CLT-001',
          icon: Icons.key,
          enabled: !isEditing,
          readOnly: isEditing,
          validator: (value) => _validateRequired(value, 'Clave del cliente'),
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: nombreController,
          label: 'Nombre Completo',
          hint: 'Juan Pérez',
          icon: Icons.person,
          keyboardType: TextInputType.name,
          validator: (value) => _validateRequired(value, 'Nombre'),
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: celularController,
          label: 'Celular',
          hint: '9611234567',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: _validatePhone,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: emailController,
          label: 'Email',
          hint: 'ejemplo@correo.com',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
      ],
    );
  }
}