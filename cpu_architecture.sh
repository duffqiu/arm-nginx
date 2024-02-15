#!/bin/bash
echo "Content-type: text/plain"
echo ""
echo "CPU Architecture: $(uname -m)"
echo "Server IP: $(hostname -I | cut -d' ' -f1)"

