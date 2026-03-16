import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_provider.dart';
import '../../utils/theme.dart';
import '../home/home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

  // Form data
  final _nameController = TextEditingController();
  final _ageController = TextEditingController(text: '25');
  String _skinType = 'normal';
  String _country = 'India';
  String _state = '';
  String _climate = 'tropical';
  String _budget = 'medium';
  bool _hasBeard = false;
  bool _smokingHabit = false;
  bool _drinkingHabit = false;
  List<String> _skinConcerns = [];

  final List<String> _concerns = [
    'Acne & Pimples',
    'Dark Spots',
    'Oiliness',
    'Dryness',
    'Dullness',
    'Dark Circles',
    'Uneven Tone',
    'Wrinkles',
    'Large Pores',
    'Blackheads',
  ];

  final List<Map<String, String>> _indianStates = [
    {'name': 'Andhra Pradesh', 'climate': 'tropical'},
    {'name': 'Delhi', 'climate': 'dry'},
    {'name': 'Gujarat', 'climate': 'dry'},
    {'name': 'Karnataka', 'climate': 'tropical'},
    {'name': 'Kerala', 'climate': 'humid'},
    {'name': 'Maharashtra', 'climate': 'tropical'},
    {'name': 'Punjab', 'climate': 'cold'},
    {'name': 'Rajasthan', 'climate': 'dry'},
    {'name': 'Tamil Nadu', 'climate': 'humid'},
    {'name': 'West Bengal', 'climate': 'humid'},
    {'name': 'Uttar Pradesh', 'climate': 'dry'},
    {'name': 'Himachal Pradesh', 'climate': 'cold'},
    {'name': 'Goa', 'climate': 'humid'},
    {'name': 'Other', 'climate': 'tropical'},
  ];

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage++);
    } else {
      _saveProfile();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage--);
    }
  }

  Future<void> _saveProfile() async {
    final profile = UserProfile(
      name: _nameController.text.trim(),
      age: int.tryParse(_ageController.text) ?? 25,
      skinType: _skinType,
      country: _country,
      state: _state,
      climate: _climate,
      budget: _budget,
      hasBeard: _hasBeard,
      smokingHabit: _smokingHabit,
      drinkingHabit: _drinkingHabit,
      skinConcerns: _skinConcerns,
    );
    await context.read<UserProvider>().saveProfile(profile);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgressBar(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildPage1BasicInfo(),
                    _buildPage2SkinType(),
                    _buildPage3Location(),
                    _buildPage4Budget(),
                    _buildPage5Lifestyle(),
                  ],
                ),
              ),
              _buildNavButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final titles = [
      'Who Are You?',
      'Your Skin Type',
      'Your Location',
      'Your Budget',
      'Your Lifestyle',
    ];
    final subtitles = [
      'Let\'s personalize your skincare journey',
      'We\'ll recommend products for your skin',
      'Climate affects your skin greatly',
      'We have options for every budget',
      'Honest answers = better results',
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: SkinorTheme.accent.withAlpha(120),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  "assets/pngs/main_logo.png",
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF1DA1F2),
                    Color(0xFFB0C4DE),
                  ],
                ).createShader(bounds),
                child: const Text(
                  'SKINOR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            titles[_currentPage],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitles[_currentPage],
            style:
                const TextStyle(color: SkinorTheme.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(_totalPages, (i) {
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: i <= _currentPage
                    ? SkinorTheme.accent
                    : SkinorTheme.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPage1BasicInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildTextField('Your Name', _nameController, Icons.person_outline),
          const SizedBox(height: 16),
          _buildTextField('Your Age', _ageController, Icons.cake_outlined,
              keyboardType: TextInputType.number),
          const SizedBox(height: 24),
          const Text(
            'What are your skin concerns?',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _concerns.map((c) {
              final selected = _skinConcerns.contains(c);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selected) {
                      _skinConcerns.remove(c);
                    } else {
                      _skinConcerns.add(c);
                    }
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? SkinorTheme.accent.withOpacity(0.2)
                        : SkinorTheme.cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          selected ? SkinorTheme.accent : SkinorTheme.divider,
                    ),
                  ),
                  child: Text(
                    c,
                    style: TextStyle(
                      color: selected
                          ? SkinorTheme.accent
                          : SkinorTheme.textSecondary,
                      fontSize: 13,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPage2SkinType() {
    final types = [
      {
        'id': 'oily',
        'label': 'Oily',
        'icon': '💧',
        'desc': 'Shiny, large pores, prone to acne'
      },
      {
        'id': 'dry',
        'label': 'Dry',
        'icon': '🏜️',
        'desc': 'Tight, flaky, rough texture'
      },
      {
        'id': 'combination',
        'label': 'Combination',
        'icon': '⚖️',
        'desc': 'Oily T-zone, dry cheeks'
      },
      {
        'id': 'normal',
        'label': 'Normal',
        'icon': '✨',
        'desc': 'Balanced, minimal issues'
      },
      {
        'id': 'sensitive',
        'label': 'Sensitive',
        'icon': '🌸',
        'desc': 'Reacts easily, redness prone'
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: types.map((t) {
          final selected = _skinType == t['id'];
          return GestureDetector(
            onTap: () => setState(() => _skinType = t['id']!),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: selected
                    ? SkinorTheme.accent.withOpacity(0.15)
                    : SkinorTheme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected ? SkinorTheme.accent : SkinorTheme.divider,
                  width: selected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Text(t['icon']!, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['label']!,
                          style: TextStyle(
                            color: selected ? SkinorTheme.accent : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          t['desc']!,
                          style: TextStyle(
                              color: SkinorTheme.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle,
                        color: SkinorTheme.accent, size: 22),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPage3Location() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Your State',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _indianStates.map((s) {
              final selected = _state == s['name'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _state = s['name']!;
                    _climate = s['climate']!;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? SkinorTheme.accent.withOpacity(0.2)
                        : SkinorTheme.cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          selected ? SkinorTheme.accent : SkinorTheme.divider,
                    ),
                  ),
                  child: Text(
                    s['name']!,
                    style: TextStyle(
                      color: selected
                          ? SkinorTheme.accent
                          : SkinorTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (_state.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: SkinorTheme.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: SkinorTheme.accent.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Text('🌡️', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detected Climate',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _climate.toUpperCase(),
                        style: TextStyle(
                          color: SkinorTheme.accentGold,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPage4Budget() {
    final budgets = [
      {
        'id': 'low',
        'label': 'Budget Friendly',
        'range': 'Under ₹500/month',
        'icon': '🪙',
        'desc': 'Dermatologist-recommended affordable brands'
      },
      {
        'id': 'medium',
        'label': 'Mid Range',
        'range': '₹500 - ₹2000/month',
        'icon': '💰',
        'desc': 'Quality products from popular brands'
      },
      {
        'id': 'high',
        'label': 'Premium',
        'range': 'Above ₹2000/month',
        'icon': '💎',
        'desc': 'Luxury & dermatologist-grade products'
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: budgets.map((b) {
          final selected = _budget == b['id'];
          return GestureDetector(
            onTap: () => setState(() => _budget = b['id']!),
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: selected
                    ? SkinorTheme.accentGold.withOpacity(0.1)
                    : SkinorTheme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      selected ? SkinorTheme.accentGold : SkinorTheme.divider,
                  width: selected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Text(b['icon']!, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b['label']!,
                          style: TextStyle(
                            color: selected
                                ? SkinorTheme.accentGold
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          b['range']!,
                          style: const TextStyle(
                              color: Color(0xFF00D4AA),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          b['desc']!,
                          style: TextStyle(
                              color: SkinorTheme.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPage5Lifestyle() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildToggleTile(
            '🧔 Do you have a beard?',
            'We\'ll include beard care in your routine',
            _hasBeard,
            (v) => setState(() => _hasBeard = v),
          ),
          const SizedBox(height: 12),
          _buildToggleTile(
            '🚬 Do you smoke?',
            'Smoking accelerates skin aging. We\'ll help manage it.',
            _smokingHabit,
            (v) => setState(() => _smokingHabit = v),
          ),
          const SizedBox(height: 12),
          _buildToggleTile(
            '🍺 Do you drink alcohol?',
            'Alcohol dehydrates skin. We\'ll suggest hydration tips.',
            _drinkingHabit,
            (v) => setState(() => _drinkingHabit = v),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  SkinorTheme.accent.withOpacity(0.15),
                  SkinorTheme.accentGold.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: SkinorTheme.accent.withOpacity(0.3)),
            ),
            child: Column(
              children: const [
                Text('🎉', style: TextStyle(fontSize: 32)),
                SizedBox(height: 8),
                Text(
                  'You\'re all set!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Your personalized skincare routine is ready. Let\'s upgrade your skin!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFB0C4DE), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile(
      String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SkinorTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SkinorTheme.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: TextStyle(
                        color: SkinorTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: SkinorTheme.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: SkinorTheme.accent),
      ),
    );
  }

  Widget _buildNavButtons() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _prevPage,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: SkinorTheme.divider),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Back'),
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text(
                _currentPage == _totalPages - 1
                    ? 'Start My Journey 🚀'
                    : 'Continue',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
