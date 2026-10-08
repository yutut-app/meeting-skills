#!/usr/bin/env bash
# 作業スペースの案件ディレクトリの絶対パスを作って返す。
# 議事録の実物はこのリポジトリに置かない。リポジトリは公開されており、
# 一度 push すると履歴から取り除けない。
#
# 使い方: ws-path.sh <YYMMDD_PJ名> [領域]
# 出力:   案件ディレクトリの絶対パス（作成済み）
# 失敗時: 標準エラーに理由を出して非ゼロで終了する。既定の場所へ落とさない。
set -euo pipefail

WS_ROOT="${MINUTES_WS_ROOT:-$HOME/Documents/my_work_spaces}"
DOMAIN="${2:-work}"

usage() {
  echo "usage: $(basename "$0") <YYMMDD_PJ名> [領域]" >&2
  echo "  例: $(basename "$0") 261008_アルファ精機-上期打合せ" >&2
}

PJ="${1:-}"
if [ -z "$PJ" ]; then
  echo "error: PJ名が指定されていない" >&2
  usage
  exit 2
fi

# YYMMDD_ の形を確かめる。崩れた名前で作ると、案件が日付順に並ばなくなる。
if ! printf '%s' "$PJ" | grep -Eq '^[0-9]{6}_.+'; then
  echo "error: PJ名が YYMMDD_名前 の形になっていない: $PJ" >&2
  usage
  exit 2
fi

if [ ! -d "$WS_ROOT" ]; then
  echo "error: 作業スペースの根が無い: $WS_ROOT" >&2
  echo "  MINUTES_WS_ROOT で場所を指定できる。推測で別の場所に書かない。" >&2
  exit 1
fi

TARGET="$WS_ROOT/$DOMAIN/$PJ"
mkdir -p "$TARGET/source" || {
  echo "error: 案件ディレクトリを作れない: $TARGET" >&2
  exit 1
}

printf '%s\n' "$TARGET"
