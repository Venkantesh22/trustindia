import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
 
  final String label;
  final bool isActive;
 
  final Function()? onTap;
  const DrawerItem({
    super.key,
   
    required this.label,
    required this.isActive,
    required this.onTap,
   
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2094F3) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
      
      
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF1F2937)
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
