import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const subtitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
  
  static const caption = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}