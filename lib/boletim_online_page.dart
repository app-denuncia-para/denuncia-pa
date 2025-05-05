import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoletimOnlinePage extends StatefulWidget {
  const BoletimOnlinePage({super.key});

  @override
  State<BoletimOnlinePage> createState() => _BoletimOnlinePageState();
}

class _BoletimOnlinePageState extends State<BoletimOnlinePage> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentPage = 0;
  bool _aceitaTermos = false;

  // Dados do formulário
  final Map<String, String> _formData = {
    'nome': '',
    'documento': '',
    'email': '',
    'telefone': '',
    'cep': '',
    'cidade': '',
    'bairro': '',
    'rua': '',
    'numero': '',
    'complemento': '',
    'tipoOcorrencia': '',
    'localOcorrencia': '',
    'descricao': '',
  };

  final List<String> _tiposOcorrencia = [
    'Roubo/Furto',
    'Violência doméstica',
    'Assédio Sexual',
    'Maus-tratos a Animais',
    'Idosos/Crianças',
    'Importunação',
    'Perturbação de Sossego',
    'Incidente de Trânsito'
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _prosseguir() {
    if (_currentPage == 0) {
      if (!_formKey.currentState!.validate()) return;
      if (!_aceitaTermos) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Você deve aceitar os termos para continuar')),
        );
        return;
      }
      _formKey.currentState!.save();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentPage == 2) {
      // Alterado para página 2 (dados da ocorrência)
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
      _mostrarConfirmacao();
    }
  }

  void _mostrarConfirmacao() {
    final protocolo =
        DateTime.now().millisecondsSinceEpoch.toString().substring(5);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ícone de confirmação
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 50,
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Boletim Realizado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD32F2F),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Entraremos em contato a cada atualização sobre o ocorrido.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(text: 'O número do seu protocolo é\n'),
                    TextSpan(
                      text: '#$protocolo',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Fecha o modal
                    Navigator.pop(context); // Volta para a tela anterior
                  },
                  child: const Text(
                    'ENTENDI',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDadosPessoais() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados Pessoais',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD32F2F),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _formData['nome'] = value!,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'CPF ou Passaporte',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _formData['documento'] = value!,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) return 'Campo obrigatório';
                if (!value.contains('@')) return 'E-mail inválido';
                return null;
              },
              onSaved: (value) => _formData['email'] = value!,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _formData['telefone'] = value!,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Endereço',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD32F2F),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'CEP',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _formData['cep'] = value!,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Cidade',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                    onSaved: (value) => _formData['cidade'] = value!,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Bairro',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                    onSaved: (value) => _formData['bairro'] = value!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Rua',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                    onSaved: (value) => _formData['rua'] = value!,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nº',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                    onSaved: (value) => _formData['numero'] = value!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Complemento (opcional)',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _formData['complemento'] = value ?? '',
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _aceitaTermos,
                  onChanged: (value) {
                    setState(() {
                      _aceitaTermos = value!;
                    });
                  },
                  activeColor: const Color(0xFFD32F2F),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Abrir termos e condições
                    },
                    child: const Text(
                      'Eu aceito os termos e condições',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDadosOcorrencia() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados da Ocorrência',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD32F2F),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Selecione uma opção',
                border: OutlineInputBorder(),
              ),
              items: _tiposOcorrencia
                  .map((tipo) => DropdownMenuItem(
                        value: tipo,
                        child: Text(tipo),
                      ))
                  .toList(),
              validator: (value) =>
                  value == null ? 'Selecione uma opção' : null,
              onChanged: (value) {
                setState(() {
                  _formData['tipoOcorrencia'] = value!;
                });
              },
              onSaved: (value) => _formData['tipoOcorrencia'] = value!,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Local do acontecimento',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _formData['localOcorrencia'] = value!,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição do ocorrido',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              onSaved: (value) => _formData['descricao'] = value!,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAtencaoPage() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 60,
            color: Colors.orange,
          ),
          const SizedBox(height: 20),
          const Text(
            'Atenção',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Alguns casos podem não ser atendidos de forma online.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Procure a delegacia mais próxima para realizar o atendimento presencial.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text(
                'PROSSEGUIR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boletim Online'),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          _buildDadosPessoais(),
          _buildAtencaoPage(),
          _buildDadosOcorrencia(),
        ],
      ),
      bottomNavigationBar: _currentPage != 1
          ? Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _prosseguir,
                child: Text(
                  _currentPage == 0
                      ? 'PROSSEGUIR COM A OCORRÊNCIA'
                      : 'DENUNCIAR',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
