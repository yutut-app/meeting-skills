# meeting-skills

会議の記録に関するスキルを置くフォルダ。

## 入っているスキル

| スキル | 役割 |
|---|---|
| [minutes-craft](skills/minutes-craft/) | 打合せの文字起こし・メモから議事録を作る |

## 中身

| 置くもの | 場所 |
|---|---|
| スキル本体、雛形、判断の規約 | `skills/<name>/` |
| 原因の台帳 | `docs/feedback.md` |
| 壊れた入力の記録 | `data/regressions/` |
| 発火試験の問い | `evals/` |

**議事録や素材はここに置かない。** ここは手順を置く場所で、案件の記録を置く場所ではない。
案件の成果物の置き場所は `skills/minutes-craft/scripts/ws-path.sh` が返す。

## 使う前に

作業スペースの根を環境変数で指定する。

```bash
export MINUTES_WS_ROOT=<作業スペースの根のパス>
```

未設定なら `ws-path.sh` は止まる。既定の場所へは落とさない。

## スキルの登録

```bash
ln -s "$(pwd)/skills/minutes-craft" ~/.claude/skills/minutes-craft
```

## 改訂

`skill-builder` スキルを使う。このフォルダのスキルを直接書き換えない。
