#!/bin/bash

# Пингование доменов из файла /domains.txt и запись результатов в /ping.log
for domain in $(cat /domains.txt); do
  echo "Pinging $domain..."
  ping -c 4 $domain | tee -a /ping.log
  echo ""
done

echo "All pings completed."
