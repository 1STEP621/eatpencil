import 'package:misskey_dart/misskey_dart.dart';

String? getNoteSummary(Note? note) {
  if (note == null) {
    return null;
  }

  String summary = '';
  // 本文
  if (note.cw != null) {
    summary += note.cw!;
  } else {
    summary += (note.text ?? '');
  }
  // ファイルが添付されているとき
  if (note.files.isNotEmpty) {
    summary += "(${note.files.length}ファイル)";
  }
  // 投票が添付されているとき
  if (note.poll != null) {
    summary += "(アンケート)";
  }
  // 返信のとき
  if (note.replyId != null) {
    if (note.reply != null) {
      summary += "\n\nRE: ${getNoteSummary(note.reply!)}";
    } else {
      summary += '\n\nRE: ...';
    }
  }
  // Renoteのとき
  if (note.renoteId != null) {
    if (note.renote != null) {
      summary += "\n\nRN: ${getNoteSummary(note.renote!)}";
    } else {
      summary += '\n\nRN: ...';
    }
  }
  return summary.trim();
}
