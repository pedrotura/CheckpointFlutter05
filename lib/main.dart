import 'package:flutter/material.dart';

void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Alunos')
        ),
        body: const AlunoCadastroForm(),
      )
    );
  }
}

class AlunoCadastroForm extends StatefulWidget {
  const AlunoCadastroForm({super.key});

  @override
  State<AlunoCadastroForm> createState() => _AlunoCadastroFormState();
}

class _AlunoCadastroFormState extends State<AlunoCadastroForm> {
  
  final nomeController = TextEditingController();
  final matriculaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String nome = '';
  int matricula = 0;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(12.0),
        children: <Widget>[
          buildNome(),
          const SizedBox(
            height: 24,
          ),
          buildMatricula(),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  nome = nomeController.text;
                  matricula = int.parse(matriculaController.text);
                });

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GreetingScreen(nome: nome)
                  )
                );

              }
            },
            child: const Text('Cadastrar')
            )
        ],
      )
    );
  }

  Widget buildNome() => TextFormField(
    controller: nomeController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'O nome é um campo obrigatório.';
      }

      if (value.length < 6) {
        return 'O nome deve conter ao menos 6 caracteres.';
      }
      return null;

    },
    decoration: const InputDecoration(
      hintText: 'Nome',
      labelText: 'Digite o nome do aluno: ',
      border: OutlineInputBorder()
    ),
    keyboardType: TextInputType.name,
  );

  Widget buildMatricula() => TextFormField(
    controller: matriculaController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'O número da matrícula é um campo obrigatório.';
      }

      if (value.length < 10 || value.length > 12) {
        return 'O número da matrícula deve ter entre 10 e 12 caracteres.';
      }

      if (value.contains(RegExp(r'\D'))) {
        return 'O número da matrícula não pode conter letras ou símbolos.';
      }
      return null;

    },
    decoration: const InputDecoration(
      hintText: 'Matrícula',
      labelText: 'Digite o número da matrícula: ',
      border: OutlineInputBorder()
    ),
    keyboardType: TextInputType.number,
  );

}

class GreetingScreen extends StatelessWidget {
  
  final String nome;
  
  const GreetingScreen({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boas-vindas'),
      ),
      body: Center(
        child: Text(
          'Bem-vindo(a), $nome!',
          style: const TextStyle(
            fontSize: 30.0
          ),
          ),
      ),
    );
  }
}