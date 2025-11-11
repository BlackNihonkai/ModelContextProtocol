FROM debian:stable-slim

RUN apt update && apt install -y \
    curl \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*
    
#RUN python3 -m pip install --no-cache-dir --upgrade pip
#RUN pip install --no-cache-dir --upgrade pip

# 仮想環境を作成し、PATHに追加
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# requirements.txt をコピー
COPY requirements.txt .
# 仮想環境内のpipでインストール
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir /app

WORKDIR /app

# ポート公開
EXPOSE 8000

# Uvicornでサーバ起動
CMD [ "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000" ]
