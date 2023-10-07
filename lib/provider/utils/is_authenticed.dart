import 'package:flutter/material.dart';
import 'package:projects/provider/auth.provider.dart';
import 'package:provider/provider.dart';

bool isAuthenticated(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  return authProvider.isAuthenticated;
}
