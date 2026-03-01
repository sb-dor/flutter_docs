import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:motor/motor.dart';

void main() {
  runApp(AnimatedBottomSheetApp());
}

class AnimatedBottomSheetApp extends StatelessWidget {
  const AnimatedBottomSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AnimatedBottomSheet());
  }
}

class AnimatedBottomSheet extends StatefulWidget {
  const AnimatedBottomSheet({super.key});

  @override
  State<AnimatedBottomSheet> createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet> {
  void _openCourseSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const CourseBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F0F0F),

        title: Text(
          'Catalog',
          style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Search bar
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 12),
                  Icon(CupertinoIcons.search, color: Color(0xFF8E8E93), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Search courses...',
                    style: TextStyle(color: Color(0xFF8E8E93), fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Featured Courses',
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 16),
            _CourseCard(
              title: 'Basic Course',
              subtitle: 'Hair Coloring Fundamentals',
              listeners: 67,
              lots: 202,
              price: '€ 220',
              onTap: () => _openCourseSheet(context),
            ),
            const SizedBox(height: 14),
            _CourseCard(
              title: 'Advanced Coloring',
              subtitle: 'Balayage & Highlights',
              listeners: 134,
              lots: 89,
              price: '€ 380',
              gradientStart: const Color(0xFF3D7FDB),
              gradientEnd: const Color(0xFF7B4FBF),
              onTap: () => _openCourseSheet(context),
            ),
            const SizedBox(height: 14),
            _CourseCard(
              title: 'Color Correction',
              subtitle: 'Fix & Transform Techniques',
              listeners: 48,
              lots: 55,
              price: '€ 290',
              gradientStart: const Color(0xFFDB5F3D),
              gradientEnd: const Color(0xFFBF4F7B),
              onTap: () => _openCourseSheet(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.title,
    required this.subtitle,
    required this.listeners,
    required this.lots,
    required this.price,
    required this.onTap,
    this.gradientStart = const Color(0xFFE87DA5),
    this.gradientEnd = const Color(0xFF9B59B6),
  });

  final String title;
  final String subtitle;
  final int listeners;
  final int lots;
  final String price;
  final VoidCallback onTap;
  final Color gradientStart;
  final Color gradientEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientStart, gradientEnd],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.person_2,
                        color: Colors.white.withValues(alpha: 0.75),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$listeners listeners',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 13),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        CupertinoIcons.play_circle,
                        color: Colors.white.withValues(alpha: 0.75),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$lots lots',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 13),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseBottomSheet extends StatefulWidget {
  const CourseBottomSheet({super.key});

  @override
  State<CourseBottomSheet> createState() => _CourseBottomSheetState();
}

class _CourseBottomSheetState extends State<CourseBottomSheet> with TickerProviderStateMixin {
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  final minChildSize = 0.5;
  final maxChildSize = 1.0;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.addListener(_onSheetChanged);
    });
  }

  @override
  void dispose() {
    _sheetController
      ..removeListener(_onSheetChanged)
      ..dispose();
    super.dispose();
  }

  void _onSheetChanged() {
    final expanded = _sheetController.size >= maxChildSize;
    if (expanded != _isExpanded) {
      setState(() => _isExpanded = expanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: maxChildSize - 0.01,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      expand: false,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Color(0xFF1C1C1E)),
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        // SliverAppBar(
                        //   backgroundColor: Color(0xFF1C1C1E),
                        //   title: Text("Cupertino sheet dialog", style: TextStyle(color: Colors.white)),
                        //   leading: CupertinoNavigationBarBackButton(
                        //     onPressed: () {
                        //       Navigator.pop(context);
                        //     },
                        //     color: Colors.blue,
                        //   ),
                        // ),
                        SliverToBoxAdapter(
                          child: SingleMotionBuilder(
                            motion: CupertinoMotion.snappy(),
                            value: _isExpanded ? 200.0 : 350.0,
                            builder: (context, height, child) =>
                                SizedBox(height: height, child: child),
                            child: MotionBuilder<Alignment>(
                              motion: CupertinoMotion.bouncy(),
                              value: _isExpanded ? Alignment.center : Alignment.bottomCenter,
                              converter: AlignmentMotionConverter(),
                              builder: (context, alignment, child) =>
                                  Align(alignment: alignment, child: child),
                              child: Image.asset(
                                'assets/images/iphone.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 350,
                              ),
                            ),
                          ),
                        ),
                        // Drag handle
                        // Dark card content
                        SliverToBoxAdapter(
                          child: Container(
                            color: const Color(0xFF1C1C1E),
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _StatChip(count: '67', label: 'Listeners'),
                                    const SizedBox(width: 20),
                                    _StatChip(count: '202', label: 'lots'),
                                    const Spacer(),
                                    CupertinoButton(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 10,
                                      ),
                                      color: CupertinoColors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.add,
                                            color: CupertinoColors.black,
                                            size: 15,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Subscribe',
                                            style: TextStyle(
                                              color: CupertinoColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'A comprehensive course for hairdressers who want to master modern hair coloring techniques. During this 2-day intensive training, experienced technologists will guide participants through the fundamentals of color theory, provide structured algorithms for working with clients.',
                                  style: TextStyle(
                                    color: Color(0xFFAAAAAA),
                                    fontSize: 14,
                                    height: 1.55,
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 13,
                                        color: Color(0xFF5E9BF5),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'show more',
                                        style: TextStyle(color: Color(0xFF5E9BF5), fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Info rows
                        SliverToBoxAdapter(
                          child: Container(
                            color: const Color(0xFF1C1C1E),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                _InfoRow(
                                  icon: CupertinoIcons.location,
                                  label: 'Location',
                                  value: 'Professional Training Center',
                                ),
                                _Divider(),
                                _InfoRow(
                                  icon: CupertinoIcons.globe,
                                  label: 'Language',
                                  value: 'English',
                                ),
                                _Divider(),
                                _PriceRow(
                                  icon: CupertinoIcons.money_euro,
                                  label: 'Price',
                                  originalPrice: '€ 280.00',
                                  discountPrice: '€ 220.00',
                                ),
                                _Divider(),
                                _InfoRow(
                                  icon: CupertinoIcons.creditcard,
                                  label: 'Cashback',
                                  value: '€ 400.00',
                                  valueColor: const Color(0xFF34C759),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: Container(
                            color: const Color(0xFF1C1C1E),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                _InfoRow(
                                  icon: CupertinoIcons.location,
                                  label: 'Location',
                                  value: 'Professional Training Center',
                                ),
                                _Divider(),
                                _InfoRow(
                                  icon: CupertinoIcons.globe,
                                  label: 'Language',
                                  value: 'English',
                                ),
                                _Divider(),
                                _PriceRow(
                                  icon: CupertinoIcons.money_euro,
                                  label: 'Price',
                                  originalPrice: '€ 280.00',
                                  discountPrice: '€ 220.00',
                                ),
                                _Divider(),
                                _InfoRow(
                                  icon: CupertinoIcons.creditcard,
                                  label: 'Cashback',
                                  value: '€ 400.00',
                                  valueColor: const Color(0xFF34C759),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Teacher
                        SliverToBoxAdapter(
                          child: Container(
                            color: const Color(0xFF1C1C1E),
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                            child: const Text(
                              'Teacher',
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: Container(
                            color: const Color(0xFF1C1C1E),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const _TeacherCard(
                              name: 'Senior Color Educator',
                              title: 'Lead Technical Trainer',
                              subtitle: 'Advanced General Expert',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 30,
                    left: 15,
                    child: LiquidGlassLayer(
                      settings: const LiquidGlassSettings(
                        thickness: 30,
                        blur: 1,
                        // ✅ Тёмный тинт стекла
                        glassColor: Colors.black54,
                        // чёрный с alpha 0x33 (~20%)
                        // ✅ Усиливаем видимость outline края
                        // Уменьшаем яркость подсветки — меньше белого на краях
                        lightIntensity: 0.3,
                        ambientStrength: 0.2,
                      ),
                      // 3. Add your LiquidGlass widgets here
                      child: LiquidGlass(
                        shape: LiquidRoundedSuperellipse(borderRadius: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const SizedBox.square(
                            dimension: 50,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(Icons.arrow_back_ios, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.count, required this.label});

  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$count ',
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: label,
            style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: const Color(0xFF3A3A3C),
      margin: const EdgeInsets.symmetric(vertical: 2),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.icon, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF8E8E93), size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 16)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? CupertinoColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String originalPrice;
  final String discountPrice;

  const _PriceRow({
    required this.icon,
    required this.label,
    required this.originalPrice,
    required this.discountPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF8E8E93), size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 16)),
          const Spacer(),
          Text(
            originalPrice,
            style: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
              decorationColor: Color(0xFF8E8E93),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            discountPrice,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeacherCard extends StatelessWidget {
  final String name;
  final String title;
  final String subtitle;

  const _TeacherCard({required this.name, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF9B59B6), Color(0xFFE87DA5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(CupertinoIcons.person_fill, color: CupertinoColors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 13)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 13)),
              ],
            ),
          ),
          const Icon(CupertinoIcons.chevron_right, color: Color(0xFF8E8E93), size: 16),
        ],
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({super.key, required this.onVerticalDragUpdate});

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: Container(
        width: double.infinity,
        color: colorScheme.onSurface,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 32.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
