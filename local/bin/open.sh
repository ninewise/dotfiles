#!/bin/bash
curl -IL $1 \
    | grep Content-Type \
    | tail -n 1 \
    | grep image && feh $1 || firefox $1
