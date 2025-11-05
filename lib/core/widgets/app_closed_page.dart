import 'dart:math';

import 'package:fada_alhalij_web/core/resources/app_constants.dart';
import 'package:fada_alhalij_web/core/resources/assets_manager.dart';
import 'package:fada_alhalij_web/core/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppClosedPage extends StatefulWidget {
  const AppClosedPage({super.key});

  @override
  State<AppClosedPage> createState() => _AppClosedPageState();
}

class _AppClosedPageState extends State<AppClosedPage>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _logoController;
  late AnimationController _contentController;
  late AnimationController _rotationController;

  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Background animation
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoRotation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
    );

    // Content animation
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _contentSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _contentController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    // Rotation animation for rings
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Start animations
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _contentController.forward();
    });

    // Check app status and navigate
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _logoController.dispose();
    _contentController.dispose();
    _rotationController.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(),

          // Floating Particles
          _buildFloatingParticles(),

          // Main Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Premium Logo
                  _buildPremiumLogo(),
                  SizedBox(height: isTablet ? 60 : 50),

                  // App Name
                  FadeTransition(
                    opacity: _contentFade,
                    child: SlideTransition(
                      position: _contentSlide,
                      child: _buildAppName(isTablet),
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 : 16),

                  SizedBox(height: isTablet ? 60 : 50),

                  // Loading Indicator
                ],
              ),
            ),
          ),

          // Version
          Positioned(
            bottom: isTablet ? 40 : 30,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _contentFade,
              child: _buildVersion(isTablet),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFF1A1A2E),
                  const Color(0xFF16213E),
                  (_backgroundController.value * 2) % 1,
                )!,
                Color.lerp(
                  const Color(0xFF0F3460),
                  const Color(0xFF16213E),
                  (_backgroundController.value * 2 + 0.5) % 1,
                )!,
                Color.lerp(
                  const Color(0xFF533483),
                  const Color(0xFF7B2CBF),
                  (_backgroundController.value * 2 + 0.7) % 1,
                )!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingParticles() {
    return Stack(
      children: List.generate(15, (index) {
        return _FloatingParticle(
          key: ValueKey(index),
          size: (index % 3 + 1) * 3.0,
          duration: Duration(seconds: 10 + (index % 5) * 2),
          delay: Duration(milliseconds: index * 200),
        );
      }),
    );
  }

  Widget _buildPremiumLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScale.value,
          child: Transform.rotate(
            angle: _logoRotation.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF7B2CBF).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Middle ring
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF7B2CBF).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
                // Main logo container
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF9D4EDD),
                        Color(0xFF7B2CBF),
                        Color(0xFF5A189A),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7B2CBF).withOpacity(0.5),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                      BoxShadow(
                        color: const Color(0xFF9D4EDD).withOpacity(0.3),
                        blurRadius: 60,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Image.asset(Assets.logo3, height: 25, width: 25),
                  ),
                ),
                // Rotating ring
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 2 * pi,
                      child: Container(
                        width: 155,
                        height: 155,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: CustomPaint(painter: _DottedCirclePainter()),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppName(bool isTablet) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFE0AAFF), Color(0xFFC77DFF)],
      ).createShader(bounds),
      child: Text(
        'التطبيق مغلق مؤقتًا ',
        style: getSemiBoldStyle(
          fontSize: isTablet ? 48 : 40,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildVersion(bool isTablet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.white.withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.security_rounded,
                  color: Colors.white.withOpacity(0.6),
                  size: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  '${AppConstants.version} الإصدار',
                  style: getMediumStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppConstants.copyright,
            style: TextStyle(
              fontSize: isTablet ? 12 : 11,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingParticle extends StatefulWidget {
  final double size;
  final Duration duration;
  final Duration delay;

  const _FloatingParticle({
    super.key,
    required this.size,
    required this.duration,
    required this.delay,
  });

  @override
  State<_FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<_FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late double _startX;
  late double _startY;

  @override
  void initState() {
    super.initState();
    _startX = (DateTime.now().millisecondsSinceEpoch % 100) / 100;
    _startY = (DateTime.now().microsecondsSinceEpoch % 100) / 100;

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<Offset>(
      begin: Offset(_startX, _startY + 1),
      end: Offset(_startX + 0.2, -0.5),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: _animation.value.dx * size.width,
          top: _animation.value.dy * size.height,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dotCount = 12;
    const radius = 77.5;
    final center = Offset(size.width / 2, size.height / 2);

    for (var i = 0; i < dotCount; i++) {
      final angle = (i * 2 * pi) / dotCount;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
