#!/usr/bin/env bash
# 作業スペースのディレクトリの絶対パスを作って返す。
#
# 使い方: ws-path.sh <YYMMDD_PJ名> [領域]
#         ws-path.sh --domain-root [領域]   領域直下（案件を越えて効くもの）
# 出力:   ディレクトリの絶対パス（作成済み）
# 失敗時: 標準エラーに理由を出して非ゼロで終了する。既定の場所へ落とさない。
#
# 作業スペースの根は環境変数 MINUTES_WS_ROOT で指定する。未設定なら止める。
# 推測で書くと、どこに書いたか分からないまま進むため。
#
# 領域直下に置くもの:
#   formats/     相手先ごとの議事録フォーマット
#   glossary.md  分野ごとの用語集（崩れた語の確定結果）
set -euo pipefail

usage() {
  echo "usage: $(basename "$0") <YYMMDD_PJ名> [領域]" >&2
  echo "       $(basename "$0") --domain-root [領域]" >&2
  echo "  環境変数 MINUTES_WS_ROOT に作業スペースの根を設定しておく" >&2
}

WS_ROOT="${MINUTES_WS_ROOT:-}"
if [ -z "$WS_ROOT" ]; then
  echo "error: MINUTES_WS_ROOT が設定されていない" >&2
  echo "  作業スペースの根を指定する。既定の場所へは落とさない。" >&2
  usage
  exit 1
fi

if [ ! -d "$WS_ROOT" ]; then
  echo "error: 作業スペースの根が無い: $WS_ROOT" >&2
  exit 1
fi

DOMAIN="${2:-work}"

# 領域直下を返す。formats/ と glossary.md の置き場所もここだけが知っている。
if [ "${1:-}" = "--domain-root" ]; then
  ROOT="$WS_ROOT/$DOMAIN"
  mkdir -p "$ROOT/formats" || {
    echo "error: 領域ディレクトリを作れない: $ROOT" >&2
    exit 1
  }
  # 用語集は見出しだけ作っておく。無いと「調べたが記載が無い」と
  # 「まだ見ていない」が区別できない。
  if [ ! -f "$ROOT/glossary.md" ]; then
    cat > "$ROOT/glossary.md" <<'GLOSSARY'
# 用語集

崩れた語と、確定した正しい表記。確定したものだけを書く。
素材の表記が正しかった語も、「正しい表記」の欄にそう書いて残す。

| 崩れた表記 | 正しい表記 | 分野 | 確定日 | 出所 |
|---|---|---|---|---|
GLOSSARY
  fi
  printf '%s\n' "$ROOT"
  exit 0
fi

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

TARGET="$WS_ROOT/$DOMAIN/$PJ"
mkdir -p "$TARGET/source" || {
  echo "error: 案件ディレクトリを作れない: $TARGET" >&2
  exit 1
}

printf '%s\n' "$TARGET"
