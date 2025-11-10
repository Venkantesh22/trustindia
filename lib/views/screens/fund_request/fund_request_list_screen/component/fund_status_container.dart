// // Status chip styles
// import 'package:flutter/material.dart';
// import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';

// class StatusChip extends StatelessWidget {
//   const StatusChip({required this.status, required this.onTapView});

//   final FundStatus status;
//   final VoidCallback onTapView;

//   @override
//   Widget build(BuildContext context) {
//     final _config = _statusConfig(status);
//     final chip = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: _config.bg,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(_config.icon, size: 14, color: _config.fg),
//           const SizedBox(width: 6),
//           Text(
//             _config.label,
//             style: TextStyle(
//               color: _config.fg,
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );

//     // Make "View" actionable

//     return chip;
//   }

//   _ChipConfig _statusConfig(FundStatus status) {
//     switch (status) {
//       case FundStatus.pending:
//         return _ChipConfig(
//           label: 'Pending',
//           bg: const Color(0xFFFFF3E0), // light orange
//           fg: const Color(0xFFFB8C00),
//           icon: Icons.hourglass_top_rounded,
//         );
//       case FundStatus.successful:
//         return _ChipConfig(
//           label: 'Successful',
//           bg: const Color(0xFFE8F5E9), // light green
//           fg: const Color(0xFF388E3C),
//           icon: Icons.check_circle_rounded,
//         );
//       case FundStatus.cancelled:
//         return _ChipConfig(
//           label: 'Cancelled',
//           bg: const Color(0xFFFFEBEE), // light red
//           fg: const Color(0xFFD32F2F),
//           icon: Icons.cancel_rounded,
//         );
//       case FundStatus.unknown:
//         // TODO: Handle this case.
//         throw UnimplementedError();
//     }
//   }
// }

// class _ChipConfig {
//   final String label;
//   final Color bg;
//   final Color fg;
//   final IconData icon;
//   const _ChipConfig({
//     required this.label,
//     required this.bg,
//     required this.fg,
//     required this.icon,
//   });
// }

// Status chip styles
import 'package:flutter/material.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.status,
  });

  final FundStatus status;

  @override
  Widget build(BuildContext context) {
    final cfg = _statusConfig(status);

    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cfg.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(cfg.icon, size: 14, color: cfg.fg),
          const SizedBox(width: 6),
          Text(
            cfg.label,
            style: TextStyle(
              color: cfg.fg,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    // // Make "View" actionable
    // if (status == FundStatus.view && onTapView != null) {
    //   return InkWell(
    //     onTap: onTapView,
    //     borderRadius: BorderRadius.circular(20),
    //     child: chip,
    //   );
    // }

    return chip;
  }

  _ChipConfig _statusConfig(FundStatus status) {
    switch (status) {
      case FundStatus.pending:
        return const _ChipConfig(
          label: 'Pending',
          bg: Color(0xFFFFF3E0), // light orange
          fg: Color(0xFFFB8C00),
          icon: Icons.hourglass_top_rounded,
        );
      case FundStatus.successful:
        return const _ChipConfig(
          label: 'Successful',
          bg: Color(0xFFE8F5E9), // light green
          fg: Color(0xFF388E3C),
          icon: Icons.check_circle_rounded,
        );
      case FundStatus.cancelled:
        return const _ChipConfig(
          label: 'Cancelled',
          bg: Color(0xFFFFEBEE), // light red
          fg: Color(0xFFD32F2F),
          icon: Icons.cancel_rounded,
        );

      case FundStatus.unknown:
      default:
        // ✅ Graceful fallback instead of throwing
        return const _ChipConfig(
          label: 'Unknown',
          bg: Color(0xFFF5F5F5), // light grey
          fg: Color(0xFF616161),
          icon: Icons.help_outline_rounded,
        );
    }
  }
}

class _ChipConfig {
  final String label;
  final Color bg;
  final Color fg;
  final IconData icon;
  const _ChipConfig({
    required this.label,
    required this.bg,
    required this.fg,
    required this.icon,
  });
}
