import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DelegaciasProximasPage extends StatefulWidget {
  const DelegaciasProximasPage({super.key});

  @override
  State<DelegaciasProximasPage> createState() => _DelegaciasProximasPageState();
}

class _DelegaciasProximasPageState extends State<DelegaciasProximasPage> {
  // Lista fictícia de delegacias - em uma aplicação real, você buscaria essas informações de uma API
  final List<Map<String, dynamic>> _delegacias = [
    {
      'nome': 'DELEGACIA GERAL DO ESTADO',
      'endereco': 'Av. Gov. José Malcher, 630 - Nazaré, Belém - PA',
      'telefone': '(91) 3218-3200',
      'horario': '24 horas',
      'distancia': '1.2 km',
      'lat': -1.455021,
      'lng': -48.502368,
    },
    {
      'nome': 'DELEGACIA DA MULHER',
      'endereco': 'Tv. Dom Romualdo de Seixas, 1445 - Umarizal, Belém - PA',
      'telefone': '(91) 3241-3366',
      'horario': '08:00 às 18:00',
      'distancia': '2.5 km',
      'lat': -1.453456,
      'lng': -48.492345,
    },
    {
      'nome': 'DELEGACIA DO TURISTA',
      'endereco': 'Av. Presidente Vargas, 119 - Campina, Belém - PA',
      'telefone': '(91) 3218-3250',
      'horario': '08:00 às 18:00',
      'distancia': '3.1 km',
      'lat': -1.456789,
      'lng': -48.503456,
    },
    {
      'nome': 'DELEGACIA DA CRIANÇA E ADOLESCENTE',
      'endereco': 'Tv. Quintino Bocaiúva, 1516 - Nazaré, Belém - PA',
      'telefone': '(91) 3218-3270',
      'horario': '08:00 às 18:00',
      'distancia': '1.8 km',
      'lat': -1.454321,
      'lng': -48.498765,
    },
  ];

  Future<void> _abrirMapa(double lat, double lng) async {
    final url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o mapa')),
      );
    }
  }

  Future<void> _ligarParaDelegacia(String telefone) async {
    final url = Uri.parse('tel:${telefone.replaceAll(RegExp(r'[^0-9]'), '')}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível realizar a chamada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delegacias Próximas'),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Mapa (simulado)
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, size: 50, color: Color(0xFFD32F2F)),
                  const SizedBox(height: 10),
                  Text(
                    'Mapa das Delegacias',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.explore),
                    label: const Text('Abrir no Mapa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                    ),
                    onPressed: () => _abrirMapa(
                        _delegacias[0]['lat'], _delegacias[0]['lng']),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Toque em uma delegacia para ver mais opções',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _delegacias.length,
              itemBuilder: (context, index) {
                final delegacia = _delegacias[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      _mostrarOpcoesDelegacia(context, delegacia);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            delegacia['nome'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  delegacia['endereco'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                delegacia['telefone'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.directions_walk,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                delegacia['distancia'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarOpcoesDelegacia(
      BuildContext context, Map<String, dynamic> delegacia) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              delegacia['nome'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              delegacia['endereco'],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Abrir no Mapa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _abrirMapa(delegacia['lat'], delegacia['lng']);
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.phone),
                label: const Text('Ligar para Delegacia'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _ligarParaDelegacia(delegacia['telefone']);
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Fechar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
