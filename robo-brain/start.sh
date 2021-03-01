# wait for roscore to be running
./wait-for-it.sh 127.0.0.1:11311

python ./publisher.py