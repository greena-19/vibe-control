
import 'package:flutter/material.dart';

// ============================================================
// VIBE CONTROL
// In-Class Activity 03
// Cyber-Tactile Music Control Studio
// ============================================================

void main() {
  runApp(const VibeControlApp());
}

// ============================================================
// ROOT APPLICATION - DARK / LIGHT THEME
// ============================================================

class VibeControlApp extends StatefulWidget {
  const VibeControlApp({super.key});

  @override
  State<VibeControlApp> createState() =>
      _VibeControlAppState();
}

class _VibeControlAppState extends State<VibeControlApp> {

  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIBE CONTROL',

      debugShowCheckedModeBanner: false,

      theme: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),

      home: ControlDeckScreen(
        isDark: isDarkMode,

        onToggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

// ============================================================
// MAIN CONTROL DECK
// ============================================================

class ControlDeckScreen extends StatefulWidget {

  final bool isDark;
  final VoidCallback onToggleTheme;

  const ControlDeckScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ControlDeckScreen> createState() =>
      _ControlDeckScreenState();
}

class _ControlDeckScreenState
    extends State<ControlDeckScreen> {

  // Dashboard state variables
  int totalTaps = 0;

  double powerLevel = 65.0;

  String systemStatus = "READY";

  // Updates dashboard after a button is pressed
  void _triggerAction(String actionName) {

    setState(() {
      totalTaps++;

      systemStatus = "$actionName ACTIVATED";
    });
  }

  @override
  Widget build(BuildContext context) {

    // ========================================================
    // MILESTONE 2 - POWER OVERLOAD DETECTION
    // ========================================================

    // Detect when power exceeds 80%
    final bool isOverload = powerLevel > 80;

    // Background changes color above 80%
    final screenBg = isOverload
        ? (widget.isDark
            ? const Color(0xFF3A1712)
            : const Color(0xFFFBE6DF))
        : (widget.isDark
            ? const Color(0xFF1E1F29)
            : const Color(0xFFE0E5EC));

    // Dashboard card background
    final cardBg = widget.isDark
        ? const Color(0xFF282A36)
        : Colors.white;

    return Scaffold(

      backgroundColor: screenBg,

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        title: const Text(
          "VIBE CONTROL",

          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 18,
          ),
        ),

        backgroundColor: Colors.transparent,

        elevation: 0,

        actions: [

          // Dark / Light theme toggle
          IconButton(
            icon: Icon(
              widget.isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),

            tooltip: 'Toggle Theme',

            onPressed: widget.onToggleTheme,
          ),
        ],
      ),

      // ======================================================
      // MAIN SCREEN
      // ======================================================

      body: SingleChildScrollView(

        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.center,

          children: [

            // =================================================
            // LIVE STATUS DASHBOARD
            // =================================================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: cardBg,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      widget.isDark ? 0.3 : 0.08,
                    ),

                    blurRadius: 15,

                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,

                children: [

                  // TOTAL TAPS

                  Column(
                    children: [

                      const Text(
                        "TOTAL TAPS",

                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "$totalTaps",

                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // DIVIDER

                  Container(
                    width: 1,
                    height: 40,

                    color:
                        Colors.grey.withOpacity(0.3),
                  ),

                  // ENERGY LEVEL

                  Column(
                    children: [

                      const Text(
                        "ENERGY LEVEL",

                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${powerLevel.toInt()}%",

                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,

                          // Energy turns red above 80%
                          color: isOverload
                              ? Colors.redAccent
                              : Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =================================================
            // LIVE SYSTEM STATUS
            // =================================================

            Text(
              "STATUS: $systemStatus",

              textAlign: TextAlign.center,

              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,

                color: widget.isDark
                    ? Colors.tealAccent
                    : Colors.teal.shade700,
              ),
            ),

            const SizedBox(height: 28),

            // =================================================
            // MILESTONE 1 - MUSIC CONTROL BUTTONS
            // =================================================

            Wrap(

              spacing: 20,

              runSpacing: 20,

              alignment: WrapAlignment.center,

              children: [

                // PLAY BUTTON

                TactileButton(
                  icon: Icons.play_arrow,

                  label: "PLAY",

                  accentColor: Colors.greenAccent,

                  isDark: widget.isDark,

                  onPressed: () =>
                      _triggerAction("MUSIC PLAY"),
                ),

                // PAUSE BUTTON

                TactileButton(
                  icon: Icons.pause,

                  label: "PAUSE",

                  accentColor: Colors.amber,

                  isDark: widget.isDark,

                  onPressed: () =>
                      _triggerAction("MUSIC PAUSE"),
                ),

                // NEXT TRACK BUTTON

                TactileButton(
                  icon: Icons.skip_next,

                  label: "NEXT",

                  accentColor: Colors.cyanAccent,

                  isDark: widget.isDark,

                  onPressed: () =>
                      _triggerAction("NEXT TRACK"),
                ),

                // VOLUME BUTTON

                TactileButton(
                  icon: Icons.volume_up,

                  label: "VOLUME",

                  accentColor: Colors.redAccent,

                  isDark: widget.isDark,

                  onPressed: () =>
                      _triggerAction("VOLUME BOOST"),
                ),
              ],
            ),

            const SizedBox(height: 36),

            // =================================================
            // POWER CALIBRATION
            // =================================================

            Text(
              "Power Calibration: ${powerLevel.toInt()}%",

              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            Slider(

              value: powerLevel,

              min: 0,

              max: 100,

              activeColor: isOverload
                  ? Colors.redAccent
                  : Colors.blueAccent,

              inactiveColor:
                  Colors.grey.withOpacity(0.3),

              // Update power immediately
              onChanged: (newVal) {

                setState(() {
                  powerLevel = newVal;
                });
              },
            ),

            // =================================================
            // MILESTONE 2 - OVERLOAD WARNING
            // =================================================

            if (isOverload)

              const Padding(
                padding: EdgeInsets.only(top: 12),

                child: Text(
                  "⚠️ POWER OVERLOAD - ABOVE 80%",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REUSABLE 3D TACTILE BUTTON
// ============================================================

class TactileButton extends StatefulWidget {

  final IconData icon;

  final String label;

  final Color accentColor;

  final bool isDark;

  final VoidCallback onPressed;

  const TactileButton({
    super.key,

    required this.icon,

    required this.label,

    required this.accentColor,

    required this.isDark,

    required this.onPressed,
  });

  @override
  State<TactileButton> createState() =>
      _TactileButtonState();
}

class _TactileButtonState
    extends State<TactileButton> {

  // Each button manages its own pressed state
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    final baseColor = widget.isDark
        ? const Color(0xFF222430)
        : const Color(0xFFE0E5EC);

    final darkShadow = widget.isDark
        ? Colors.black87
        : const Color(0xFFA3B1C6);

    final lightShadow = widget.isDark
        ? const Color(0xFF2F3244)
        : Colors.white;

    return GestureDetector(

      // Finger touches button
      onTapDown: (_) {

        setState(() {
          isPressed = true;
        });
      },

      // Finger releases button
      onTapUp: (_) {

        setState(() {
          isPressed = false;
        });

        widget.onPressed();
      },

      // Cancelled touch
      onTapCancel: () {

        setState(() {
          isPressed = false;
        });
      },

      child: AnimatedContainer(

        duration:
            const Duration(milliseconds: 100),

        width: 140,

        height: 140,

        decoration: BoxDecoration(

          color: baseColor,

          borderRadius:
              BorderRadius.circular(24),

          // Dual opposing shadows create 3D depth
          boxShadow: isPressed

              // PRESSED SHADOWS
              ? [

                  BoxShadow(
                    color:
                        darkShadow.withOpacity(0.5),

                    offset: const Offset(2, 2),

                    blurRadius: 4,
                  ),

                  BoxShadow(
                    color:
                        lightShadow.withOpacity(0.5),

                    offset: const Offset(-2, -2),

                    blurRadius: 4,
                  ),
                ]

              // UNPRESSED SHADOWS
              : [

                  BoxShadow(
                    color:
                        darkShadow.withOpacity(0.7),

                    offset: const Offset(8, 8),

                    blurRadius: 16,
                  ),

                  BoxShadow(
                    color:
                        lightShadow.withOpacity(0.9),

                    offset: const Offset(-8, -8),

                    blurRadius: 16,
                  ),
                ],
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // BUTTON ICON

            Icon(
              widget.icon,

              size: isPressed ? 40 : 46,

              color: isPressed
                  ? widget.accentColor
                  : (widget.isDark
                      ? Colors.white70
                      : Colors.black87),
            ),

            const SizedBox(height: 8),

            // BUTTON LABEL

            Text(
              widget.label,

              style: TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 12,

                letterSpacing: 1.1,

                color: isPressed
                    ? widget.accentColor
                    : (widget.isDark
                        ? Colors.white54
                        : Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}