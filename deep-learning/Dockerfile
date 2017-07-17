FROM nvidia/cuda:8.0-cudnn6-runtime-ubuntu16.04

MAINTAINER decoy

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1

# Anaconda, TensorFlow, Kerasをインストール
ENV PATH /opt/conda/bin:$PATH
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    pip install tensorflow-gpu keras

# sshをインストール
# sshサービスを起動させ、tail -fでコンテナを動かし続けるための起動スクリプトを作成
# rootでsshにログインできるようsshの設定を変更。さらにsshでコマンド実行しても環境変数を追加できるようオプションを変更
# sshでコマンド実行しても、sshに入ってもGPUが使えるようにするため、環境変数の設定の追加
RUN apt-get install -y openssh-server && \
    ( echo "#!/bin/bash"; \
      echo ""; \
      echo "service ssh start"; \
      echo "tail -f /dev/null"; ) > /root/entrypoint.sh && \
    chmod +x /root/entrypoint.sh && \
    sed -i.origin 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config && \
    ( echo ""; \
      echo "export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:$PATH"; \
      echo "export LIBRARY_PATH=/usr/local/cuda/lib64/stubs:"; \
      echo "export LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64"; \
    ) >> /root/.bashrc && \
    mkdir /root/.ssh && chmod 700 /root/.ssh && \
    ( echo "PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:$PATH"; \
      echo "LIBRARY_PATH=/usr/local/cuda/lib64/stubs:"; \
      echo "LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64"; \
    ) >> /root/.ssh/environment

# SSHポートを公開
EXPOSE 22

# パスワードの設定
RUN echo 'root:decoy' | chpasswd 

CMD ["/root/entrypoint.sh"]

