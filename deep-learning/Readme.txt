ディープラーニング用Dockerコンテナ(SSH接続可能)

■バージョン■
Ubuntu 16.04
Anaconda 4.4.0(Python 3.6.1)
Keras 最新版(2017/7/17時点 2.0.6)
TensorFlow 最新版(2017/7/17時点 1.2.1)
CUDA 8.0
cuDNN 6.0

■SSHポート■
8022
(run.sh内で変更可能)

■rootユーザのパスワード■
decoy
(Dockerfile内で変更可能)

■Dockerコンテナへマウントするホストのディレクトリ■
[ホスト:Dockerコンテナ:権限]
/data/workspace:/data/workspace:rw
/data/workspace/Docker/deep-learning/.pycharm_helpers:/root/.pycharm_helpers:rw
(run.shで変更可能)
