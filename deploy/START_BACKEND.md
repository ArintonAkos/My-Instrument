## If it's the first time

Install npm
Install npx
Install iisexpress-proxy
Install git-bash

Start git-bash

Run this command:
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout example-home.key -out example-home.crt -subj "//CN=localhost" \
  -addext "subjectAltName=DNS:localhost,DNS:localhost,IP:192.168.0.136"

Run this command: 
iisexpress-proxy https://localhost:44308 to https://*:3000 --key=./example.key --cert=./example.crt

Check the Proxying Wi-Fi network ip address: https://192.168.10.3:3000 // Ez csak egy pelda, a 192.168.10.3

Replace the ip address in the command above with the ip address of your Wi-Fi network: 
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout example.key -out example.crt -subj "//CN=localhost" \
  -addext "subjectAltName=DNS:localhost,DNS:localhost,IP:192.168.10.3"

Stop running iisepress-proxy

Run the command above(openssl)

Run the proxy command

done

### If it's not the first time

open git bash

run iisexpress-proxy command

done