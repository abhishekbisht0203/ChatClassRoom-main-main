#!/bin/bash

echo "BUILD START"


# Ensure Python is available
if command -v python3 &>/dev/null; then
    echo "Python3 found"
    PYTHON=python3
elif command -v python &>/dev/null; then
    echo "Python found"
    PYTHON=python
else
    echo "Python is not installed. Exiting..."
    exit 1
fi

# Ensure pip is available
if ! command -v pip &>/dev/null; then
    echo "pip not found. Attempting to install..."
    $PYTHON -m ensurepip --upgrade
fi

# Install dependencies
$PYTHON -m pip install --upgrade pip
$PYTHON -m pip install -r requirements.txt

# Run migrations
$PYTHON manage.py migrate

# Collect static files
$PYTHON manage.py collectstatic --noinput

# pip install --upgrade pip
# pip3 install -r requirements.txt
# python3.9 manage.py makemigrations
# python3.9 manage.py migrate
echo "BUILD DONE"