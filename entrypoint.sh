#!/bin/sh

# Machine ID
ID_PATH="/var/lib/dbus/machine-id"

echo "Using Hostname: $HOSTNAME"
if [ -n "$MACHINE_ID" ]; then
    echo "Using MACHINE_ID: $MACHINE_ID"
    echo "$MACHINE_ID" > "$ID_PATH"
else
    echo "No MACHINE_ID provided, generating one..."
    id=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 32 | head -n 1)
    echo "Using generated MACHINE_ID: $id"
    echo "$id" > "$ID_PATH"
fi

# Test for ~/.duplicacy-web/settings.json
if [ ! -f ~/.duplicacy-web/settings.json ]; then
    echo "No settings.json found, creating default..."
    touch ~/.duplicacy-web/settings.json
    echo "Created settings.json, using it..."
    echo "{
    \"listening_address\": \":3875\"
}" > ~/.duplicacy-web/settings.json
else
    echo "Found settings.json, using it..."
fi

# Start Duplicacy Web
echo "Starting Duplicacy..."
exec /usr/local/bin/duplicacy_web
