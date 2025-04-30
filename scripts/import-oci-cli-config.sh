#!/bin/bash
set -e

mkdir -p config/default/private
> config/default/private/oci.env
for i in tenancy user fingerprint region; do
    grep -E "^\s*${i}=" ~/.oci/config >> config/default/private/oci.env
done
echo "useInstancePrincipal=false" >> config/default/private/oci.env

passphrase=$(grep -E "^\s*passphrase=" ~/.oci/config | cut -d = -f 2)
echo "passphrase=$passphrase" >> config/default/private/oci.env
key_file=$(grep -E "^\s*key_file=" ~/.oci/config | cut -d = -f 2)
cp -a "$key_file" config/default/private/key
