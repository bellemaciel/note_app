import 'package:flutter/material.dart';

class telaEdit extends StatefulWidget {
  const telaEdit({super.key});

  @override
  State<telaEdit> createState() => _telaEditState();
}

class _telaEditState extends State<telaEdit> {
  TextEditingController _tituloControle = TextEditingController();
  TextEditingController _conteudoControle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nova Tarefa',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back, color: Colors.black)))
            ],
          ),
          Expanded(
              child: ListView(
            children: [
              TextField(
                controller: _tituloControle,
                style: TextStyle(color: Colors.black, fontSize: 30),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Título',
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 30)),
              ),
              TextField(
                controller: _conteudoControle,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Descrição de tarefa',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ],
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
              context, [_tituloControle.text, _conteudoControle.text]);
        },
        elevation: 10,
        backgroundColor: Colors.purple,
        child: Icon(Icons.save),
      ),
    );
  }
}
