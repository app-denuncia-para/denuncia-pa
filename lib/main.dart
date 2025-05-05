import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'denuncia_anonima_page.dart';
import 'boletim_online_page.dart';
import 'delegacias_proximas_page.dart';
import 'bombeiro_emergencia_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DenunciePA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: const Color(0xFFD32F2F),
          secondary: const Color(0xFF1976D2),
          surface: const Color(0xFFFFFFFF),
          background: const Color(0xFFF5F5F5),
          error: const Color(0xFFC62828),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF212121),
          onBackground: const Color(0xFF212121),
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(8),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 75,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.0,
              );
            }
            return const TextStyle(fontSize: 0);
          }),
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFD32F2F).withOpacity(0.2),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final Color _policeColor = const Color(0xFF1976D2);
  final Color _firefighterColor = const Color(0xFFD32F2F);
  final Color _samuColor = const Color(0xFF388E3C);
  final Color _otherColor = const Color(0xFF7B1FA2);

  final List<Map<String, dynamic>> _policeOptions = [
    {
      'title': 'Denúncia Anônima',
      'icon': Icons.announcement,
      'color': Color(0xFFD32F2F),
      'bgColor': Color(0xFFFFEBEE),
    },
    {
      'title': 'Boletim Online',
      'icon': Icons.article,
      'color': Color(0xFF1976D2),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'title': 'Delegacias Próximas',
      'icon': Icons.location_pin,
      'color': Color(0xFF388E3C),
      'bgColor': Color(0xFFE8F5E9),
    },
    {
      'title': 'Dúvidas',
      'icon': Icons.help,
      'color': Color(0xFFF57C00),
      'bgColor': Color(0xFFFFF3E0),
    },
  ];

  final List<Map<String, dynamic>> _firefighterOptions = [
    {
      'title': 'Emergência',
      'icon': Icons.emergency_outlined,
      'color': Color(0xFFD32F2F),
      'bgColor': Color(0xFFFFEBEE),
      'phone': '193'
    },
    {
      'title': 'Dúvidas',
      'icon': Icons.help_outline,
      'color': Color(0xFF1976D2),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'title': 'Ligar',
      'icon': Icons.phone,
      'color': Color(0xFF388E3C),
      'bgColor': Color(0xFFE8F5E9),
      'phone': '193'
    },
  ];

  final List<Map<String, dynamic>> _samuOptions = [
    {
      'title': 'Emergência',
      'icon': Icons.medical_services_outlined,
      'color': Color(0xFFD32F2F),
      'bgColor': Color(0xFFFFEBEE),
      'phone': '192'
    },
    {
      'title': 'Dúvidas',
      'icon': Icons.help_outline,
      'color': Color(0xFF1976D2),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'title': 'Ligar',
      'icon': Icons.phone,
      'color': Color(0xFF388E3C),
      'bgColor': Color(0xFFE8F5E9),
      'phone': '192'
    },
  ];

  final List<Map<String, dynamic>> _otherReports = [
    {
      'title': 'Violência Doméstica',
      'phone': 'Disque 180',
      'icon': Icons.warning_amber,
      'color': Color(0xFF7B1FA2),
      'bgColor': Color(0xFFF3E5F5),
    },
    {
      'title': 'Direitos Humanos',
      'phone': 'Disque 100',
      'icon': Icons.people,
      'color': Color(0xFF1976D2),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'title': 'Meio Ambiente',
      'phone': 'Disque 0800-61-8080',
      'icon': Icons.nature,
      'color': Color(0xFF388E3C),
      'bgColor': Color(0xFFE8F5E9),
    },
    {
      'title': 'Procon',
      'phone': '151',
      'icon': Icons.shopping_cart,
      'color': Color(0xFFF57C00),
      'bgColor': Color(0xFFFFF3E0),
    },
    {
      'title': 'Denúncia Anônima',
      'phone': '181',
      'icon': Icons.security,
      'color': Color(0xFFD32F2F),
      'bgColor': Color(0xFFFFEBEE),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'DenunciePA',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              smallSize: 8,
              backgroundColor: Colors.amber[700],
              child: const Icon(Icons.notifications_outlined, size: 26),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: isSmallScreen ? 50 : 60,
                    height: isSmallScreen ? 50 : 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3), width: 2),
                    ),
                    child: Icon(Icons.person_outline,
                        color: Colors.white, size: isSmallScreen ? 26 : 30),
                  ),
                  SizedBox(width: isSmallScreen ? 12 : 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Serviços de Emergência',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Belém - Pará',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: isSmallScreen ? 8 : 12,
              crossAxisSpacing: isSmallScreen ? 8 : 12,
              childAspectRatio: isSmallScreen ? 0.85 : 1.0,
              children: [
                _buildServiceCard(
                  context,
                  icon: Icons.local_police,
                  title: 'Polícia Militar',
                  phone: '190',
                  color: _policeColor,
                  bgColor: const Color(0xFFE3F2FD),
                  options: _policeOptions,
                  serviceName: 'Polícia Militar',
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.fire_truck,
                  title: 'Bombeiros',
                  phone: '193',
                  color: _firefighterColor,
                  bgColor: const Color(0xFFFFEBEE),
                  options: _firefighterOptions,
                  serviceName: 'Corpo de Bombeiros',
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.medical_services,
                  title: 'SAMU',
                  phone: '192',
                  color: _samuColor,
                  bgColor: const Color(0xFFE8F5E9),
                  options: _samuOptions,
                  serviceName: 'SAMU',
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.help_outline,
                  title: 'Outros',
                  phone: 'Disque 181',
                  color: _otherColor,
                  bgColor: const Color(0xFFF3E5F5),
                  options: _otherReports,
                  serviceName: 'Outros Canais',
                  isOther: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/image.png',
                      height: isSmallScreen ? 50 : 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.security,
                            size: isSmallScreen ? 35 : 40, color: Colors.grey);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Governo do Estado do Pará',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Denuncie com segurança',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 11 : 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String phone,
    required Color color,
    required Color bgColor,
    required List<Map<String, dynamic>> options,
    required String serviceName,
    bool isOther = false,
  }) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Card(
      color: bgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => isOther
            ? _showOtherReports(context)
            : _showOptionsModal(context, serviceName, options),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isSmallScreen ? 44 : 52,
                height: isSmallScreen ? 44 : 52,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: isSmallScreen ? 24 : 28, color: color),
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 15 : 17,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: isSmallScreen ? 4 : 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  phone,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Toque para opções',
                style: TextStyle(
                  fontSize: isSmallScreen ? 10 : 11,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsModal(
      BuildContext context, String title, List<Map<String, dynamic>> options) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              isSmallScreen ? 16 : 20,
              isSmallScreen ? 16 : 20,
              isSmallScreen ? 16 : 20,
              isSmallScreen ? 30 : 40),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Text(
                '$title - Opções',
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: isSmallScreen ? 8 : 12,
                  crossAxisSpacing: isSmallScreen ? 8 : 12,
                  childAspectRatio: isSmallScreen ? 1.1 : 1.2,
                  children: options.map((option) {
                    return _buildOptionCard(context, option);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionCard(BuildContext context, Map<String, dynamic> option) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Card(
      color: option['bgColor'],
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pop(context);
          _handleOptionSelection(context, option);
        },
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isSmallScreen ? 36 : 44,
                height: isSmallScreen ? 36 : 44,
                decoration: BoxDecoration(
                  color: (option['color'] as Color).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(option['icon'],
                    color: option['color'], size: isSmallScreen ? 20 : 24),
              ),
              SizedBox(height: isSmallScreen ? 6 : 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  option['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleOptionSelection(
      BuildContext context, Map<String, dynamic> option) {
    switch (option['title']) {
      case 'Denúncia Anônima':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DenunciaAnonimaPage(),
          ),
        );
        break;
      case 'Boletim Online':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BoletimOnlinePage(),
          ),
        );
        break;
      case 'Delegacias Próximas':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DelegaciasProximasPage(),
          ),
        );
        break;
      case 'Emergência':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BombeiroEmergenciaPage(),
          ),
        );
        break;
      case 'Dúvidas':
        _showFaq(context);
        break;
      default:
        if (option['phone'] != null) {
          _callNumber(option['phone'].toString().replaceAll('Disque ', ''));
        }
        break;
    }
  }

  void _showFaq(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Dúvidas Frequentes',
            style: TextStyle(
              fontSize: isSmallScreen ? 18 : 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          content: Text(
            'Em caso de emergência, ligue para os números indicados.\n\nPara dúvidas sobre denúncias, entre em contato com nossa central de atendimento.',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Fechar',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showOtherReports(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              isSmallScreen ? 16 : 20,
              isSmallScreen ? 16 : 20,
              isSmallScreen ? 16 : 20,
              isSmallScreen ? 30 : 40),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Text(
                'Outros Canais de Denúncia',
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _otherReports.length,
                  itemBuilder: (context, index) {
                    final report = _otherReports[index];
                    return _buildReportItem(context, report);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReportItem(BuildContext context, Map<String, dynamic> report) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      color: report['bgColor'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 16,
            vertical: isSmallScreen ? 8 : 12),
        onTap: () =>
            _callNumber(report['phone'].toString().replaceAll('Disque ', '')),
        leading: Container(
          width: isSmallScreen ? 40 : 44,
          height: isSmallScreen ? 40 : 44,
          decoration: BoxDecoration(
            color: (report['color'] as Color).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            report['icon'],
            color: report['color'],
            size: isSmallScreen ? 22 : 24,
          ),
        ),
        title: Text(
          report['title'],
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          report['phone'],
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        ),
      ),
    );
  }

  Future<void> _callNumber(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível realizar a chamada para $number'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    return NavigationBar(
      height: isSmallScreen ? 65 : 70,
      backgroundColor: Colors.white,
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onItemTapped,
      indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined,
              size: isSmallScreen ? 22 : 24,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          selectedIcon: Icon(Icons.home,
              size: isSmallScreen ? 22 : 24,
              color: Theme.of(context).colorScheme.primary),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.report_outlined,
              size: isSmallScreen ? 22 : 24,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          selectedIcon: Icon(Icons.report,
              size: isSmallScreen ? 22 : 24,
              color: Theme.of(context).colorScheme.primary),
          label: 'Denúncias',
        ),
        NavigationDestination(
          icon: Icon(Icons.info_outline,
              size: isSmallScreen ? 22 : 24,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          selectedIcon: Icon(Icons.info,
              size: isSmallScreen ? 22 : 24,
              color: Theme.of(context).colorScheme.primary),
          label: 'Informações',
        ),
      ],
    );
  }
}
