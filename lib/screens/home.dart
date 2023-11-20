import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notasFiltradas = [];
  bool organizada = false;

  @override
  void initState() {
    super.initState();
    notasFiltradas = sampleNotes;
  }

  List<Note> organizarTarefas(List<Note> tarefas) {
    if (organizada) {
      tarefas.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      tarefas.sort((b, a) => b.modifiedTime.compareTo(a.modifiedTime));
    }

    organizada = !organizada;

    return tarefas;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void pesquisaTexto(String pesqText) {
    setState(() {
      notasFiltradas = sampleNotes
          .where((note) =>
              note.content.toLowerCase().contains(pesqText.toLowerCase()) ||
              note.title.toLowerCase().contains(pesqText.toLowerCase()))
          .toList();
    });
  }

  void deletaTarefa(int index) {
    setState(() {
      Note tarefas = notasFiltradas[index];
      sampleNotes.remove(tarefas);

      notasFiltradas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tarefas',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        notasFiltradas = organizarTarefas(notasFiltradas);
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.sort, color: Colors.black)))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: pesquisaTexto,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  hintText: "Pesquise tarefas...",
                  hintStyle: const TextStyle(color: Colors.pink),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  fillColor: Colors.white54,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent))),
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.only(top: 30),
              itemCount: notasFiltradas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 20),
                  color: Colors.white30,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () async {
                        final resultado = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                telaEdit(note: notasFiltradas[index]),
                          ),
                        );
                        if (resultado != null) {
                          setState(() {
                            int inoriginal =
                                sampleNotes.indexOf(notasFiltradas[index]);
                            sampleNotes[inoriginal] = Note(
                                id: sampleNotes[inoriginal].id,
                                title: resultado[0],
                                content: resultado[1],
                                modifiedTime: DateTime.now());
                            notasFiltradas[index] = Note(
                                id: notasFiltradas[index].id,
                                title: resultado[0],
                                content: resultado[1],
                                modifiedTime: DateTime.now());
                          });
                        }
                      },
                      title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          text: TextSpan(
                            text: '${sampleNotes[index].title} \n',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.5),
                            children: [
                              TextSpan(
                                  text: sampleNotes[index].content,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.3))
                            ],
                          )),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Editado: ' +
                              DateFormat('d MMMM yyyy, h:mm a')
                                  .format(sampleNotes[index].modifiedTime),
                          style: TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final resultado = await dialogoConfirmacao(context);
                          if (resultado != null && resultado) {
                            deletaTarefa(index);
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const telaEdit(),
            ),
          );

          if (resultado != null) {
            setState(() {
              sampleNotes.add(Note(
                  id: sampleNotes.length,
                  title: resultado[0],
                  content: resultado[1],
                  modifiedTime: DateTime.now()));
              notasFiltradas = sampleNotes;
            });
          }
        },
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  Future<dynamic> dialogoConfirmacao(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black38,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              "Quer mesmo deletar essa tarefa?",
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          "Sim",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          "Não",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ]),
          );
        });
  }
}
