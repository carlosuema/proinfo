#!/bin/sh
for i in $(getent passwd | cut -d: -f1 | grep guest | grep -v guest-template)
do
    deluser --system $i
done
