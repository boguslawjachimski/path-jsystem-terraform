#!/bin/bash
# Skrypt tworzy archiwum z kodem źródłowym
rm -rf .terraform terraform.tfstate* archiwum.tar.gz
tar cvfz archiwum.tar.gz --exclude='*.auto.tfvars' *