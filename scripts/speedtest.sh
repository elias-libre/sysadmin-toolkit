#! /bin/bash

echo "speedtest script"
echo "1. python3"
echo "2. python"
read -p "input " py
case $py in
1)
curl -s https://raw.githubusercontent.com/PeterLinuxOSS/speedtest-cli/master/speedtest.py | python3 - ;;
2)
curl -s https://raw.githubusercontent.com/PeterLinuxOSS/speedtest-cli/master/speedtest.py | python - ;;
esac