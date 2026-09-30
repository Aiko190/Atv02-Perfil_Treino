import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Treino(),
  ));
}

class Treino extends StatefulWidget {
  const Treino({super.key});

  @override
  State<Treino> createState() => _TreinoState();
}

class _TreinoState extends State<Treino> {
  String objetivo = 'Emagrecimento';
  String nivel = 'Iniciante';
  String frequencia = '2 dias por semana';

  List<String> restricoes = [];
  List<String> alergias = [];

  double tempo = 60;
  bool agua = false;
  bool termos = false;

  final alergia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Montador de Perfil de Treino'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Objetivo do treino',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Emagrecimento', label: Text('Emagrecimento')),
                ButtonSegment(value: 'Hipertrofia', label: Text('Hipertrofia')),
                ButtonSegment(value: 'Condicionamento', label: Text('Condicionamento')),
              ],
              selected: {objetivo},
              onSelectionChanged: (v) {
                setState(() => objetivo = v.first);
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Nível de experiência',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Wrap(
              spacing: 8,
              children: ['Iniciante', 'Intermediário', 'Avançado'].map((item) {
                return ChoiceChip(
                  label: Text(item),
                  selected: nivel == item,
                  onSelected: (_) {
                    setState(() => nivel = item);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              'Restrições alimentares',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Wrap(
              spacing: 8,
              children: ['Vegetariano', 'Vegano', 'Sem lactose', 'Sem glúten', 'Low Carb']
                  .map((item) {
                return FilterChip(
                  label: Text(item),
                  selected: restricoes.contains(item),
                  onSelected: (v) {
                    setState(() {
                      v ? restricoes.add(item) : restricoes.remove(item);
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              'Alergias',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: alergia,
                    decoration: const InputDecoration(
                      labelText: 'Digite uma alergia',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (alergia.text.isNotEmpty) {
                      setState(() {
                        alergias.add(alergia.text);
                        alergia.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            Wrap(
              children: alergias.map((item) {
                return InputChip(
                  label: Text(item),
                  onDeleted: () {
                    setState(() => alergias.remove(item));
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              'Tempo diário de treino',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text('${tempo.toInt()} minutos'),

            Slider(
              min: 15,
              max: 120,
              divisions: 21,
              value: tempo,
              onChanged: (v) {
                setState(() => tempo = v);
              },
            ),

            const Text(
              'Frequência semanal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            ...['2 dias por semana', '3 dias por semana', '4 dias por semana',
                '5 dias por semana', '6 dias por semana'].map((item) {
              return RadioListTile(
                title: Text(item),
                value: item,
                groupValue: frequencia,
                onChanged: (v) {
                  setState(() => frequencia = v!);
                },
              );
            }),

            SwitchListTile(
              title: const Text('Receber notificações para beber água'),
              value: agua,
              onChanged: (v) {
                setState(() => agua = v);
              },
            ),

            CheckboxListTile(
              title: const Text('Aceito os termos e condições'),
              value: termos,
              onChanged: (v) {
                setState(() => termos = v!);
              },
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: termos
                    ? () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Objetivo: $objetivo\n'
                                'Nível: $nivel\n'
                                'Restrições: ${restricoes.join(', ')}\n'
                                'Alergias: ${alergias.join(', ')}\n'
                                'Tempo: ${tempo.toInt()} minutos\n'
                                'Frequência: $frequencia\n'
                                'Água: ${agua ? 'Ativada' : 'Desativada'}\n'
                                'Termos: Aceitos',
                              ),
                            );
                          },
                        );
                      }
                    : null,
                child: const Text('Gerar Plano'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}