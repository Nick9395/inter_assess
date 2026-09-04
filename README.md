# Inter_Assess

## アプリの目的

就活の質疑応答を練習し、自分の経歴や考えを言語化するためのアプリです。

AI 面接官（1人）と音声＋テキストで面談し、終了後にフィードバックを受けます。フィードバックでは、質問意図との一致、説明の仕方、課題と改善点、想定される深掘り質問、模範解答例を返します。結果は Word（`.docx`）で保存します。

当面は自分用のローカル利用です。ログイン必須です。

## 開発環境

全部 Docker で動かします。ホストに Ruby / Node.js / PostgreSQL を入れる必要はありません。Node.js と Redis は使いません。

| 項目 | 内容 |
|---|---|
| OS | macOS（Docker Desktop） |
| コンテナ | `web`（Puma） / `worker`（Solid Queue） / `db`（PostgreSQL 16） |
| ポート | アプリ `3000` / PostgreSQL `5432` |
| 永続化 | Docker volume（`postgres_data`, `bundle`） |
| 秘密情報 | `.env`（任意。未作成時は Compose のデフォルト） |
| メール | 開発は letter_opener_web（`/letter_opener`）。Resend は未接続 |
| ブラウザ | 音声機能は Chrome / Edge を想定 |

`.env` と `config/master.key` は Git にコミットしません。

## 使用技術

| 分類 | 技術 |
|---|---|
| 言語 | Ruby 3.4 |
| フレームワーク | Rails 8.1 |
| データベース | PostgreSQL 16 |
| フロント | Importmap, Hotwire（Turbo / Stimulus）, Tailwind CSS |
| ジョブ / キャッシュ / Cable | Solid Queue, Solid Cache, Solid Cable |
| 認証 | Devise（登録・ログイン・ログアウト・パスワードリセット） |
| AI | gpt-4o-mini（これから接続） |
| 音声 | ブラウザ標準の Speech Synthesis / Speech Recognition（これから） |
| テスト | Minitest |
| インフラ | Docker Compose, GitHub |

## コマンド

ビルドして起動します。

```bash
docker compose up --build
```

バックグラウンドで起動する場合:

```bash
docker compose up --build -d
```

停止します。

```bash
docker compose down
```

データベースを準備します（初回、または schema を変えたあと）。

```bash
docker compose exec web bin/rails db:prepare
```

マイグレーションだけ実行します。

```bash
docker compose exec web bin/rails db:migrate
```

アプリは [http://localhost:3000](http://localhost:3000) です。

Tailwind のクラスを追加したあとに CSS をビルドします。

```bash
docker compose exec web bin/rails tailwindcss:build
```

テスト用 DB を用意してテストを実行します。

```bash
docker compose exec -e RAILS_ENV=test -e DATABASE_URL=postgres://inter_assess:password@db:5432/app_test web bin/rails db:prepare
docker compose exec web bin/rails test
```

Rails コンソールを開きます。

```bash
docker compose exec web bin/rails console
```

コンテナ内のシェルに入ります。

```bash
docker compose exec web bash
```

web を再起動します。

```bash
docker compose restart web
```

ログを見ます。

```bash
docker compose logs -f web
```
