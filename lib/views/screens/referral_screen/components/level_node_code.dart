// import 'package:flutter/material.dart';
// import 'package:lekra/data/models/referral_model.dart';

// class ReferralTreeByLevel extends StatelessWidget {
//   final List<ReferralModel> roots;
//   const ReferralTreeByLevel({super.key, required this.roots});

//   @override
//   Widget build(BuildContext context) {
//     final levels = _bfsLevels(roots);
//     return ListView.builder(
//       itemCount: levels.length,
//       padding: const EdgeInsets.only(top: 8, bottom: 16),
//       itemBuilder: (context, levelIndex) {
//         final nodes = levels[levelIndex];
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 6.0),
//               child: Text('Level ${levelIndex + 1}',
//                   style: const TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             SizedBox(
//               height: 110,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: nodes.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 12),
//                 itemBuilder: (context, idx) {
//                   final n = nodes[idx];
//                   return _LevelNodeCard(node: n);
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static List<List<ReferralModel>> _bfsLevels(List<ReferralModel> roots) {
//     final result = <List<ReferralModel>>[];
//     final queue = <MapEntry<ReferralModel, int>>[];

//     for (var r in roots) queue.add(MapEntry(r, 0));

//     while (queue.isNotEmpty) {
//       final entry = queue.removeAt(0);
//       final node = entry.key;
//       final depth = entry.value;
//       if (result.length <= depth) result.add([]);
//       result[depth].add(node);
//       for (var c in node.referrals  ?? []) {
//         queue.add(MapEntry(c, depth + 1));
//       }
//     }
//     return result;
//   }
// }

// class _LevelNodeCard extends StatelessWidget {
//   final ReferralModel node;
//   const _LevelNodeCard({required this.node});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(node.name ?? "", style: const TextStyle(fontWeight: FontWeight.w600)),
//           const SizedBox(height: 6),
//           Text(node.email ?? "", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
//           const SizedBox(height: 6),
//           Text('Children: ${node.referrals?.length }',
//               style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
//         ],
//       ),
//     );
//   }
// }
