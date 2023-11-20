class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}

List<Note> sampleNotes = [
  Note(
    id: 0,
    title: 'Estudar',
    content: 'Inglês: \nVerbo to be.',
    modifiedTime: DateTime(2022, 1, 1, 34, 5),
  ),
  Note(
    id: 1,
    title: 'Treino',
    content:
        '1. 30 Abdominais\n2. 20 flexões\n3. 40 agachamentos\n4. 20min esteira',
    modifiedTime: DateTime(2022, 1, 1, 34, 5),
  ),
  Note(
    id: 2,
    title: 'Lista de Compras',
    content: '1. Açúcar\n2. Arroz\n3. Macarrão\n4. Feijão',
    modifiedTime: DateTime(2023, 3, 1, 19, 5),
  ),
  Note(
    id: 3,
    title: 'Lembrar: ',
    content: 'Retornar livro para a biblioteca.',
    modifiedTime: DateTime(2023, 1, 4, 16, 3),
  ),
  Note(
    id: 4,
    title: 'Enviar e-mail',
    content:
        'Assunto: Aumento de salário\nEndereço: boss@email.com\nPrazo: 25/12',
    modifiedTime: DateTime(2023, 5, 1, 11, 6),
  ),
  Note(
    id: 5,
    title: 'Faxina',
    content:
        '1. Tirar o lixo\n2. Varrer o quintal\n3. Trocar os lençóis\n4. Colocar roupas na máquina\n5. Lavar as janelas',
    modifiedTime: DateTime(2023, 1, 6, 13, 9),
  ),
  Note(
    id: 6,
    title: 'Lavar o carro',
    content: "Com água.",
    modifiedTime: DateTime(2023, 3, 7, 11, 12),
  ),
  Note(
    id: 7,
    title: 'Reunião',
    content:
        'Participantes: Maria, João, Carla\nAssuntos:\n- Orçamento\n- Projetos\n- Eventos',
    modifiedTime: DateTime(2023, 2, 1, 15, 14),
  ),
  Note(
    id: 8,
    title: 'Lugares para visitar:',
    content:
        '1. Foz do Iguaçu\n2. Porto de Galinhas\n3. Monte Roraima\n4. Chapada Diamantina',
    modifiedTime: DateTime(2023, 2, 1, 12, 34),
  ),
];
