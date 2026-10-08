# meeting-skills

会議の記録に関するスキルを置くフォルダ。

## 入っているスキル

| スキル | 役割 |
|---|---|
| [minutes-craft](skills/minutes-craft/) | 打合せの文字起こし・メモから議事録を作る |

## 構成

| 置くもの | 場所 | 版管理 |
|---|---|---|
| スキル本体、雛形、判断の規約 | `skills/<name>/` | このリポジトリ |
| 改訂のための記録（台帳、壊れた入力、評価の問い） | `local/` | **手元だけ。**独立したリポジトリで remote を持たない |

`local/` は改訂する側が使うもので、スキルを使う側には要らない。
**このリポジトリからは外してある。**

**議事録や素材はここに置かない。** ここは手順を置く場所で、案件の記録を置く場所ではない。
案件の成果物の置き場所は `skills/minutes-craft/scripts/ws-path.sh` が返す。

## 使う前に

作業スペースの根を指定する。どちらか一方でよい。

```bash
mkdir -p ~/.config/minutes-craft
echo "<作業スペースの根のパス>" > ~/.config/minutes-craft/ws-root
```

```bash
export MINUTES_WS_ROOT=<作業スペースの根のパス>
```

**設定ファイルの方が確実。** 環境変数は、対話していないシェルでは
読まれないことがある。どちらも無ければ `ws-path.sh` は止まり、既定の場所へは落とさない。

## スキルの登録

```bash
ln -s "$(pwd)/skills/minutes-craft" ~/.claude/skills/minutes-craft
```

## 改訂

`skill-builder` スキルを使う。このフォルダのスキルを直接書き換えない。
