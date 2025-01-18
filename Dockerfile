# syntax=docker/dockerfile:1

FROM ruby:3.3.0-slim

# 開発に必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# 作業ディレクトリの設定
WORKDIR /app

# Gemfileをコピーして依存関係をインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのコピー
COPY . .

# エントリーポイントスクリプトを実行可能に
COPY bin/docker-entrypoint /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint

# エントリーポイントの設定
ENTRYPOINT ["docker-entrypoint"]

# デフォルトのコマンド
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
