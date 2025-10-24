// import 'package:flutter/material.dart';
// import 'package:graphview/GraphView.dart';
// import 'package:lekra/data/models/referral_model.dart';

// class ReferralGraphTree extends StatefulWidget {
//   final List<ReferralModel> roots;
//   const ReferralGraphTree({super.key, required this.roots});

//   @override
//   State<ReferralGraphTree> createState() => _ReferralGraphTreeState();
// }

// class _ReferralGraphTreeState extends State<ReferralGraphTree> {
//   final Graph graph = Graph()..isTree = true;
//   final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

//   @override
//   void initState() {
//     super.initState();
//     _buildGraph();
//   }

//   void _buildGraph() {
//     graph.nodes.clear();

//     final mainRoot = Node.Id("My Referrals");

//     for (var root in widget.roots) {
//       final rootNode = Node.Id(root.email ?? 'unknown-${root.hashCode}');
//       graph.addEdge(mainRoot, rootNode);
//       _addChildren(rootNode, root);
//     }

//     graph.addNode(mainRoot);
//   }

//   void _addChildren(Node parentNode, ReferralModel parentModel) {
//     for (var child in parentModel.referrals ?? []) {
//       final childNode = Node.Id(child.email ?? 'unknown-${child.hashCode}');
//       graph.addEdge(parentNode, childNode);
//       _addChildren(childNode, child);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     builder
//       ..siblingSeparation = (40)
//       ..levelSeparation = (80)
//       ..subtreeSeparation = (60)
//       ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

//     return InteractiveViewer(
//       constrained: false,
//       boundaryMargin: const EdgeInsets.all(100),
//       minScale: 0.2,
//       maxScale: 2.0,
//       child: GraphView(
//         graph: graph,
//         algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
//         builder: (Node node) {
//           var email = node.key!.value as String;
//           final referral = _findReferralByEmail(widget.roots, email);
//           return _buildNode(context, referral, email);
//         },
//       ),
//     );
//   }

//   ReferralModel? _findReferralByEmail(List<ReferralModel> list, String email) {
//     for (var r in list) {
//       if (r.email == email) return r;
//       var found = _findReferralByEmail(r.referrals ?? [], email);
//       if (found != null) return found;
//     }
//     return null;
//   }

//   Widget _buildNode(BuildContext context, ReferralModel? model, String name) {
//     final isMainRoot = name == "My Referrals";
//     return Container(
//       padding: const EdgeInsets.all(8),
//       width: isMainRoot ? 160 : 140,
//       decoration: BoxDecoration(
//         color: isMainRoot ? Colors.blue.shade100 : Colors.white,
//         border: Border.all(
//             color: isMainRoot ? Colors.blue : Colors.blueAccent, width: 1.2),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.25),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             isMainRoot ? name : (model?.name ?? "Unknown"),
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//               color: isMainRoot ? Colors.blueAccent : Colors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           if (!isMainRoot) ...[
//             const SizedBox(height: 4),
//             Text(
//               "₹${model?.wallet ?? '0.00'}",
//               style: const TextStyle(
//                 color: Colors.green,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 13,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:lekra/data/models/referral_model.dart';
import 'package:lekra/services/constants.dart';

class ReferralGraphTree extends StatefulWidget {
  final List<ReferralModel> roots;
  const ReferralGraphTree({super.key, required this.roots});

  @override
  State<ReferralGraphTree> createState() => _ReferralGraphTreeState();
}

class _ReferralGraphTreeState extends State<ReferralGraphTree>
    with TickerProviderStateMixin {
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  // Transform & animation
  final TransformationController _transformationController =
      TransformationController();
  AnimationController? _animController;
  double _currentScale = 1.0;

  // Key to measure graph content size for fit-to-screen
  final GlobalKey _graphKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _buildGraph();
    // Optionally fit to screen after first frame:
    WidgetsBinding.instance.addPostFrameCallback((_) => _fitToScreen());
  }

  @override
  void dispose() {
    _animController?.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _buildGraph() {
    graph.nodes.clear();

    final mainRoot = Node.Id("My Referrals");

    for (var root in widget.roots) {
      final rootNode = Node.Id(root.referralCode ?? 'unknown-${root.hashCode}');
      graph.addEdge(mainRoot, rootNode);
      _addChildren(rootNode, root);
    }

    graph.addNode(mainRoot);
  }

  void _addChildren(Node parentNode, ReferralModel parentModel) {
    for (var child in parentModel.referrals ?? []) {
      final childNode =
          Node.Id(child.referralCode ?? 'unknown-${child.hashCode}');
      graph.addEdge(parentNode, childNode);
      _addChildren(childNode, child);
    }
  }

  // ---------- Zoom / animation helpers ----------
  void _animateScaleTo(double targetScale,
      {Duration duration = const Duration(milliseconds: 300)}) {
    _animController?.dispose();
    _animController = AnimationController(vsync: this, duration: duration);
    final tween = Tween<double>(begin: _currentScale, end: targetScale)
        .chain(CurveTween(curve: Curves.easeInOut));
    final animation = tween.animate(_animController!);
    _animController!.addListener(() {
      final value = animation.value;
      // Keep translation centered (no advanced focal-point math here).
      _transformationController.value = Matrix4.identity()..scale(value);
    });
    _animController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _currentScale = targetScale;
        _animController?.dispose();
        _animController = null;
      }
    });
    _animController!.forward();
  }

  void _zoomIn() {
    final next = (_currentScale * 1.25).clamp(0.1, 4.0);
    _animateScaleTo(next);
  }

  void _zoomOut() {
    final next = (_currentScale / 1.25).clamp(0.1, 4.0);
    _animateScaleTo(next);
  }

  void _resetZoom() {
    _animateScaleTo(1.0);
  }

  Future<void> _fitToScreen() async {
    // Wait a frame so graph has laid out
    await Future.delayed(const Duration(milliseconds: 50));
    final RenderBox? contentBox =
        _graphKey.currentContext?.findRenderObject() as RenderBox?;
    final Size? contentSize = contentBox?.size;

    // viewport size: use MediaQuery (the InteractiveViewer parent area)
    final Size viewportSize = MediaQuery.of(context).size;

    if (contentSize == null ||
        contentSize.width == 0 ||
        contentSize.height == 0) {
      // Nothing to fit; bail out
      return;
    }

    // Calculate scale to fit content into viewport with margin
    final double scaleX = viewportSize.width / contentSize.width;
    final double scaleY = viewportSize.height / contentSize.height;
    // Use the smaller scale and add some padding factor
    double target = min(scaleX, scaleY) * 0.9;

    // Clamp and animate
    target = target.isFinite ? target.clamp(0.1, 3.0) : 1.0;
    _animateScaleTo(target);
  }

  // ---------- Utility: find referral by referralCode ----------
  ReferralModel? _findReferralByReferralCode(
      List<ReferralModel> list, String referralCode) {
    for (var r in list) {
      if (r.referralCode == referralCode) return r;
      var found = _findReferralByReferralCode(r.referrals ?? [], referralCode);
      if (found != null) return found;
    }
    return null;
  }

  Widget _buildNode(BuildContext context, ReferralModel? model, String name) {
    final isMainRoot = name == "My Referrals";
    return Container(
      padding: const EdgeInsets.all(8),
      width: isMainRoot ? 160 : 140,
      decoration: BoxDecoration(
        color: isMainRoot ? Colors.blue.shade100 : Colors.white,
        border: Border.all(
            color: isMainRoot ? Colors.blue : Colors.blueAccent, width: 1.2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            isMainRoot ? name : (model?.name ?? "Unknown"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isMainRoot ? Colors.blueAccent : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          if (!isMainRoot) ...[
            const SizedBox(height: 4),
            Text(
              PriceConverter.convertToNumberFormat(
                  double.parse(model?.wallet ?? '0.00')),
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    builder
      ..siblingSeparation = 40
      ..levelSeparation = 80
      ..subtreeSeparation = 60
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    // Layout: InteractiveViewer + overlay controls
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          InteractiveViewer(
            transformationController: _transformationController,
            constrained: false,
            boundaryMargin: const EdgeInsets.all(200),
            minScale: 0.1,
            maxScale: 4.0,
            child: UnconstrainedBox(
              child: RepaintBoundary(
                key: _graphKey,
                child: ConstrainedBox(
                  // give GraphView a min size so content measures properly
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth * 0.6,
                    minHeight: constraints.maxHeight * 0.6,
                  ),
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    builder: (Node node) {
                      var referralCode = node.key!.value as String;
                      final referral = _findReferralByReferralCode(
                          widget.roots, referralCode);
                      return _buildNode(context, referral, referralCode);
                    },
                  ),
                ),
              ),
            ),
          ),

          // Floating zoom controls (bottom-right)
          Positioned(
            right: 12,
            bottom: 12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'fit',
                  mini: true,
                  onPressed: _fitToScreen,
                  child: const Icon(Icons.fit_screen),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'reset',
                  mini: true,
                  onPressed: _resetZoom,
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
