#!/bin/bash
set -e

echo {\"ip\":\""`dig +short myip.opendns.com @resolver1.opendns.com`"\"}