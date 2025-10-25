// import 'package:flutter/material.dart';
// import 'package:graphview/GraphView.dart';
// import 'package:lekra/data/models/referral_model.dart';
// import 'package:lekra/services/constants.dart';

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
//       final rootNode = Node.Id(root.referralCode ?? 'unknown-${root.hashCode}');
//       graph.addEdge(mainRoot, rootNode);
//       _addChildren(rootNode, root);
//     }

//     graph.addNode(mainRoot);
//   }

//   void _addChildren(Node parentNode, ReferralModel parentModel) {
//     for (var child in parentModel.referrals ?? []) {
//       final childNode =
//           Node.Id(child.referralCode ?? 'unknown-${child.hashCode}');
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

//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.6,
//       child: InteractiveViewer(
//         constrained: false,
//         boundaryMargin: const EdgeInsets.all(100),
//         minScale: 0.2,
//         maxScale: 2.0,
//         child: GraphView(
//           graph: graph,
//           algorithm:
//               BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
//           builder: (Node node) {
//             var email = node.key!.value as String;
//             final referral = _findReferralByReferralCode(widget.roots, email);
//             return _buildNode(context, referral, email);
//           },
//         ),
//       ),
//     );
//   }

//   ReferralModel? _findReferralByReferralCode(
//       List<ReferralModel> list, String referralCode) {
//     for (var r in list) {
//       if (r.referralCode == referralCode) return r;
//       var found = _findReferralByReferralCode(r.referrals ?? [], referralCode);
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
//               PriceConverter.convertToNumberFormat(
//                   double.parse(model?.wallet ?? "0.0")),
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

// import 'package:flutter/material.dart';
// import 'package:graphview/GraphView.dart';
// import 'package:lekra/data/models/referral_model.dart';
// import 'package:lekra/services/constants.dart';

// class ReferralGraphTree extends StatefulWidget {
//   final List<ReferralModel> roots;
//   const ReferralGraphTree({super.key, required this.roots});

//   @override
//   State<ReferralGraphTree> createState() => _ReferralGraphTreeState();
// }

// class _ReferralGraphTreeState extends State<ReferralGraphTree> {
//   late Graph graph;
//   final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

//   final TransformationController _transformationController =
//       TransformationController();
//   double _currentScale = 1.0;
//   final double _minScale = 0.2;
//   final double _maxScale = 2.5;

//   String? _errorMessage;
//   bool _isBuilding = false;

//   @override
//   void initState() {
//     super.initState();
//     graph = Graph()..isTree = true;
//     _buildGraph();
//   }

//   @override
//   void dispose() {
//     _transformationController.dispose();
//     super.dispose();
//   }

//   void _buildGraph() {
//     // build graph in try/catch and update UI state on error
//     try {
//       setState(() {
//         _isBuilding = true;
//         _errorMessage = null;
//         graph = Graph()..isTree = true;
//       });

//       final mainRoot = Node.Id("My Referrals");
//       // Always add main root first
//       graph.addNode(mainRoot);

//       for (var root in widget.roots) {
//         final rootNode =
//             Node.Id(root.referralCode ?? 'unknown-${root.hashCode}');
//         graph.addEdge(mainRoot, rootNode);
//         _addChildren(rootNode, root);
//       }

//       setState(() {
//         _isBuilding = false;
//       });
//     } catch (e, st) {
//       // log if you want. For now store human friendly message
//       setState(() {
//         _errorMessage = 'Failed to build graph: ${e.toString()}';
//         _isBuilding = false;
//       });
//     }
//   }

//   void _addChildren(Node parentNode, ReferralModel parentModel) {
//     for (var child in parentModel.referrals ?? []) {
//       final childNode =
//           Node.Id(child.referralCode ?? 'unknown-${child.hashCode}');
//       graph.addEdge(parentNode, childNode);
//       _addChildren(childNode, child);
//     }
//   }

//   void _setScale(double scale) {
//     final clamped = scale.clamp(_minScale, _maxScale);
//     setState(() {
//       _currentScale = clamped;
//       // set transformation matrix to scale only (no translation)
//       _transformationController.value = Matrix4.identity()..scale(clamped);
//     });
//   }

//   void _zoomIn() => _setScale(_currentScale * 1.2);
//   void _zoomOut() => _setScale(_currentScale / 1.2);
//   void _resetZoom() => _setScale(1.0);

//   ReferralModel? _findReferralByReferralCode(
//       List<ReferralModel> list, String referralCode) {
//     for (var r in list) {
//       if (r.referralCode == referralCode) return r;
//       var found = _findReferralByReferralCode(r.referrals ?? [], referralCode);
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
//             color: Colors.grey.withOpacity(0.25),
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
//               // guarded parsing — if wallet is already double/string safe
//               PriceConverter.convertToNumberFormat(
//                   double.tryParse(model?.wallet ?? "0") ?? 0.0),
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

//   @override
//   Widget build(BuildContext context) {
//     builder
//       ..siblingSeparation = (40)
//       ..levelSeparation = (80)
//       ..subtreeSeparation = (60)
//       ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

//     // If there was an error building the graph, show friendly UI with retry
//     if (_errorMessage != null) {
//       return SizedBox(
//         height: MediaQuery.of(context).size.height * 0.6,
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.error_outline, color: Colors.red.shade400, size: 48),
//               const SizedBox(height: 12),
//               Text(
//                 _errorMessage!,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton.icon(
//                 onPressed: () => _buildGraph(),
//                 icon: const Icon(Icons.refresh),
//                 label: const Text("Retry"),
//               )
//             ],
//           ),
//         ),
//       );
//     }

//     // Loading indicator while building graph
//     if (_isBuilding) {
//       return SizedBox(
//         height: MediaQuery.of(context).size.height * 0.6,
//         child: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.6,
//       child: Stack(
//         children: [
//           InteractiveViewer(
//             constrained: false,
//             boundaryMargin: const EdgeInsets.all(100),
//             minScale: _minScale,
//             maxScale: _maxScale,
//             transformationController: _transformationController,
//             child: GraphView(
//               graph: graph,
//               algorithm:
//                   BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
//               builder: (Node node) {
//                 var value = node.key!.value as String;
//                 final referral = _findReferralByReferralCode(widget.roots, value);
//                 return _buildNode(context, referral, value);
//               },
//             ),
//           ),

//           // Zoom controls (floating column)
//           Positioned(
//             right: 12,
//             bottom: 12,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 FloatingActionButton(
//                   heroTag: 'zoom_in',
//                   mini: true,
//                   onPressed: _zoomIn,
//                   child: const Icon(Icons.add),
//                 ),
//                 const SizedBox(height: 8),
//                 FloatingActionButton(
//                   heroTag: 'zoom_out',
//                   mini: true,
//                   onPressed: _zoomOut,
//                   child: const Icon(Icons.remove),
//                 ),
//                 const SizedBox(height: 8),
//                 FloatingActionButton(
//                   heroTag: 'zoom_reset',
//                   mini: true,
//                   onPressed: _resetZoom,
//                   child: const Icon(Icons.refresh),
//                 ),
//               ],
//             ),
//           ),

//           // Optional small scale indicator on top-left
//           Positioned(
//             left: 8,
//             top: 8,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.6),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 "Scale: ${_currentScale.toStringAsFixed(2)}x",
//                 style: const TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:lekra/data/models/referral_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class ReferralGraphTree extends StatefulWidget {
  final List<ReferralModel> roots;
  const ReferralGraphTree({super.key, required this.roots});

  @override
  State<ReferralGraphTree> createState() => _ReferralGraphTreeState();
}

class _ReferralGraphTreeState extends State<ReferralGraphTree>
    with SingleTickerProviderStateMixin {
  late Graph graph;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  final TransformationController _transformationController =
      TransformationController();
  double _currentScale = 1.0;
  final double _minScale = 0.2;
  final double _maxScale = 2.5;

  String? _errorMessage;
  bool _isBuilding = false;

  late final AnimationController _animController;
  Animation<double>? _scaleAnim;

  // Node sizing constants (keep consistent across widgets)
  static const double _nodeWidth = 140.0;
  static const double _rootNodeWidth = 160.0;

    Matrix4 _scaleMatrix(double s) => Matrix4.diagonal3Values(s, s, s);


  @override
  void initState() {
    super.initState();
    graph = Graph()..isTree = true;
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _buildGraph();
  }

  @override
  void dispose() {
    _animController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _buildGraph() {
    try {
      setState(() {
        _isBuilding = true;
        _errorMessage = null;
        graph = Graph()..isTree = true;
      });

      final mainRoot = Node.Id("My Referrals");
      graph.addNode(mainRoot);

      for (var root in widget.roots) {
        final rootNode =
            Node.Id(root.referralCode ?? 'unknown-${root.hashCode}');
        graph.addEdge(mainRoot, rootNode);
        _addChildren(rootNode, root);
      }

      setState(() {
        _isBuilding = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to build graph: ${e.toString()}';
        _isBuilding = false;
      });
    }
  }

  void _addChildren(Node parentNode, ReferralModel parentModel) {
    for (var child in parentModel.referrals ?? []) {
      final childNode =
          Node.Id(child.referralCode ?? 'unknown-${child.hashCode}');
      graph.addEdge(parentNode, childNode);
      _addChildren(childNode, child);
    }
  }

  void _setScale(double scale) {
    final clamped = scale.clamp(_minScale, _maxScale);
    _animateScale(_currentScale, clamped);
  }

  void _animateScale(double from, double to) {
    _scaleAnim?.removeListener(_onAnimate);
    _animController.stop();
    _scaleAnim = Tween<double>(begin: from, end: to).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic))
      ..addListener(_onAnimate);
    _animController
      ..reset()
      ..forward();
    _currentScale = to; // update target so future calls work
  }

 void _onAnimate() {
  final value = _scaleAnim?.value ?? _currentScale;
  _transformationController.value = _scaleMatrix(value);
}


  void _zoomIn() => _setScale(_currentScale * 1.2);
  void _zoomOut() => _setScale(_currentScale / 1.2);
  void _resetZoom() => _setScale(1.0);

  // ---------------- Fit / full screen ----------------

  // compute depth helpers (same logic as earlier)
  int _maxDepth(ReferralModel? node) {
    if (node == null) return 0;
    if (node.referrals == null || node.referrals!.isEmpty) return 1;
    int maxChild = 0;
    for (var c in node.referrals!) {
      maxChild = (_maxDepth(c) > maxChild) ? _maxDepth(c) : maxChild;
    }
    return 1 + maxChild;
  }

  int _treeDepth() {
    if (widget.roots.isEmpty) return 1;
    int maxd = 0;
    for (var root in widget.roots) {
      maxd = (_maxDepth(root) > maxd) ? _maxDepth(root) : maxd;
    }
    // +1 for mainRoot
    return maxd + 1;
  }

  int _maxNodesPerLevel() {
    if (widget.roots.isEmpty) return 1;
    final queue = <ReferralModel?>[];
    // level 1 children of "My Referrals"
    for (var r in widget.roots) queue.add(r);
    int maxPer = queue.length;
    while (queue.isNotEmpty) {
      final next = <ReferralModel?>[];
      maxPer = (queue.length > maxPer) ? queue.length : maxPer;
      while (queue.isNotEmpty) {
        final node = queue.removeAt(0);
        if (node == null) continue;
        for (var c in node.referrals ?? []) next.add(c);
      }
      queue.addAll(next);
    }
    return maxPer;
  }

  Graph _createGraphFromRoots(List<ReferralModel> roots) {
    final g = Graph()..isTree = true;
    final mainRoot = Node.Id("My Referrals");
    g.addNode(mainRoot);
    for (var root in roots) {
      final rootNode = Node.Id(root.referralCode ?? 'unknown-${root.hashCode}');
      g.addEdge(mainRoot, rootNode);
      _addChildrenToGraph(g, rootNode, root);
    }
    return g;
  }

  void _addChildrenToGraph(
      Graph g, Node parentNode, ReferralModel parentModel) {
    for (var child in parentModel.referrals ?? []) {
      final childNode =
          Node.Id(child.referralCode ?? 'unknown-${child.hashCode}');
      g.addEdge(parentNode, childNode);
      _addChildrenToGraph(g, childNode, child);
    }
  }

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
      width: isMainRoot ? _rootNodeWidth : _nodeWidth,
      decoration: BoxDecoration(
        color: isMainRoot ? Colors.blue.shade100 : Colors.white,
        border: Border.all(
            color: isMainRoot ? Colors.blue : Colors.blueAccent, width: 1.2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:  0.25),
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
                  double.tryParse(model?.wallet ?? "0") ?? 0.0),
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

  // Open full-screen page (uses dedicated widget which handles animation correctly)
  void _openFullScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return FullScreenReferralTree(roots: widget.roots);
    }));
  }

  @override
  Widget build(BuildContext context) {
    builder
      ..siblingSeparation = (40)
      ..levelSeparation = (80)
      ..subtreeSeparation = (60)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    if (_errorMessage != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade400, size: 48),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => _buildGraph(),
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
              )
            ],
          ),
        ),
      );
    }

    if (_isBuilding) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        children: [
          InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: _minScale,
            maxScale: _maxScale,
            transformationController: _transformationController,
            child: GraphView(
              graph: graph,
              algorithm:
                  BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
              builder: (Node node) {
                var value = node.key!.value as String;
                final referral =
                    _findReferralByReferralCode(widget.roots, value);
                return _buildNode(context, referral, value);
              },
            ),
          ),
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
                  heroTag: 'zoom_reset',
                  mini: true,
                  onPressed: _resetZoom,
                  child: const Icon(Icons.refresh),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'full_screen',
                  mini: true,
                  onPressed: _openFullScreen,
                  child: const Icon(Icons.fullscreen),
                ),
              ],
            ),
          ),
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha:  0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Scale: ${_currentScale.toStringAsFixed(2)}x",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full screen page that fits the entire tree and animates to the fit scale.
/// This is a dedicated StatefulWidget so it can use SingleTickerProviderStateMixin
class FullScreenReferralTree extends StatefulWidget {
  final List<ReferralModel> roots;
  const FullScreenReferralTree({super.key, required this.roots});

  @override
  State<FullScreenReferralTree> createState() => _FullScreenReferralTreeState();
}

class _FullScreenReferralTreeState extends State<FullScreenReferralTree>
    with SingleTickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  late final AnimationController _animController;
  Animation<double>? _anim;

  // local sizing constants (match parent widget)
  static const double _nodeWidth = 140.0;
  static const double _rootNodeWidth = 160.0;
  static const double _nodeHeight = 80.0;

  final BuchheimWalkerConfiguration _builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    // compute fit scale after layout
    WidgetsBinding.instance.addPostFrameCallback((_) => _fitToScreen());
  }

  @override
  void dispose() {
    _animController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // --- helpers to compute depth / max nodes per level (same logic)
  int _maxDepth(ReferralModel? node) {
    if (node == null) return 0;
    if (node.referrals == null || node.referrals!.isEmpty) return 1;
    int maxChild = 0;
    for (var c in node.referrals!) {
      maxChild = (_maxDepth(c) > maxChild) ? _maxDepth(c) : maxChild;
    }
    return 1 + maxChild;
  }

  int _treeDepth() {
    if (widget.roots.isEmpty) return 1;
    int maxd = 0;
    for (var root in widget.roots) {
      maxd = (_maxDepth(root) > maxd) ? _maxDepth(root) : maxd;
    }
    return maxd + 1;
  }

  int _maxNodesPerLevel() {
    if (widget.roots.isEmpty) return 1;
    final queue = <ReferralModel?>[];
    for (var r in widget.roots) queue.add(r);
    int maxPer = queue.length;
    while (queue.isNotEmpty) {
      final next = <ReferralModel?>[];
      maxPer = (queue.length > maxPer) ? queue.length : maxPer;
      while (queue.isNotEmpty) {
        final node = queue.removeAt(0);
        if (node == null) continue;
        for (var c in node.referrals ?? []) next.add(c);
      }
      queue.addAll(next);
    }
    return maxPer;
  }

  double _computeFitScale(Size screen) {
    final screenW = screen.width;
    final screenH = screen.height;

    final depth = _treeDepth(); // levels including main root
    final maxNodes = _maxNodesPerLevel();

    final siblingSeparation = 40.0; // same as builder.siblingSeparation
    final levelSeparation = 80.0; // same as builder.levelSeparation

    final requiredWidth = (maxNodes * _nodeWidth) +
        ((maxNodes - 1) * siblingSeparation) +
        200; // margin buffer
    final requiredHeight =
        (depth * _nodeHeight) + ((depth - 1) * levelSeparation) + 200;

    var fit = (screenW / requiredWidth).clamp(0.2, 2.5);
    final fitH = (screenH / requiredHeight).clamp(0.2, 2.5);
    fit = fit < fitH ? fit : fitH;
    if (fit.isInfinite || fit.isNaN) return 1.0;
    return fit;
  }

  Graph _createGraphFromRoots(List<ReferralModel> roots) {
    final g = Graph()..isTree = true;
    final mainRoot = Node.Id("My Referrals");
    g.addNode(mainRoot);
    void addChildren(Graph gg, Node parent, ReferralModel parentModel) {
      for (var child in parentModel.referrals ?? []) {
        final childNode =
            Node.Id(child.referralCode ?? 'unknown-${child.hashCode}');
        gg.addEdge(parent, childNode);
        addChildren(gg, childNode, child);
      }
    }

    for (var root in roots) {
      final rootNode = Node.Id(root.referralCode ?? 'unknown-${root.hashCode}');
      g.addEdge(mainRoot, rootNode);
      addChildren(g, rootNode, root);
    }
    return g;
  }

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
      width: isMainRoot ? _rootNodeWidth : _nodeWidth,
      decoration: BoxDecoration(
        color: isMainRoot ? Colors.blue.shade100 : Colors.white,
        border: Border.all(
            color: isMainRoot ? Colors.blue : Colors.blueAccent, width: 1.2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:  0.25),
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
                  double.tryParse(model?.wallet ?? "0") ?? 0.0),
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

  // compute fit scale and animate to it
  void _fitToScreen() {
    final size = MediaQuery.of(context).size;
    final fitScale = _computeFitScale(size);

    _anim?.removeListener(_onAnim);
    _animController.reset();
    _anim = Tween<double>(begin: 1.0, end: fitScale).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    )..addListener(_onAnim);

    _animController.forward();
  }



  Matrix4 _scaleMatrix(double s) => Matrix4.diagonal3Values(s, s, s);

 void _onAnim() {
  final value = _anim?.value ?? 1.0;
  _controller.value = _scaleMatrix(value);
}


  @override
  Widget build(BuildContext context) {
    _builder
      ..siblingSeparation = (40)
      ..levelSeparation = (80)
      ..subtreeSeparation = (60)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    final graph = _createGraphFromRoots(widget.roots);

    return Scaffold(
      appBar: const CustomAppBar2(title: "Referral Tree"),
      body: SafeArea(
        child: InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(100),
          transformationController: _controller,
          minScale: 0.2,
          maxScale: 2.5,
          child: GraphView(
            graph: graph,
            algorithm:
                BuchheimWalkerAlgorithm(_builder, TreeEdgeRenderer(_builder)),
            builder: (Node node) {
              var value = node.key!.value as String;
              final referral = _findReferralByReferralCode(widget.roots, value);
              return _buildNode(context, referral, value);
            },
          ),
        ),
      ),
    );
  }
}
