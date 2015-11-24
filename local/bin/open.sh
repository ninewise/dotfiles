#!/bin/bash
rifle "$1" | grep 'cannot open' && xdg-open "$1"
