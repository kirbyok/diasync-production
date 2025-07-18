#!/bin/bash
# DiaSync Setup Script - No chmod needed, runs automatically

set -e

echo "🩸 DiaSync Configuration Setup"
echo "=============================="

# Check if .env already exists
if [ -f ".env" ]; then
    echo "⚠️  .env file already exists!"
    read -p "Do you want to overwrite it? (y/N): " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 0
    fi
fi

echo ""
echo "📱 Select your CGM device type:"
echo "1) Dexcom"
echo "2) Abbott"
echo "3) FreestyleLibre" 
echo "4) Freestyle"
echo ""
read -p "Enter choice (1-4): " device_choice

case $device_choice in
    1) DEVICE_TYPE="Dexcom" ;;
    2) DEVICE_TYPE="Abbott" ;;
    3) DEVICE_TYPE="FreestyleLibre" ;;
    4) DEVICE_TYPE="Freestyle" ;;
    *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

echo ""
echo "🌐 Enter your Nightscout details:"
read -p "Nightscout URL (e.g., https://yoursite.herokuapp.com): " NIGHTSCOUT_URL
read -p "Nightscout API Secret: " NIGHTSCOUT_API_SECRET

echo ""
if [[ "$DEVICE_TYPE" == "Dexcom" ]]; then
    echo "🔵 Enter your Dexcom Share credentials:"
    read -p "Dexcom Username: " DEXCOM_USERNAME
    read -s -p "Dexcom Password: " DEXCOM_PASSWORD
    echo ""
    read -p "Dexcom Region (us/international) [us]: " DEXCOM_REGION
    DEXCOM_REGION=${DEXCOM_REGION:-us}
else
    echo "🟠 Enter your Abbott/LibreView credentials:"
    read -p "Abbott Username: " ABBOTT_USERNAME
    read -s -p "Abbott Password: " ABBOTT_PASSWORD
    echo ""
    read -p "Abbott Region (eu/us/global) [eu]: " ABBOTT_REGION
    ABBOTT_REGION=${ABBOTT_REGION:-eu}
fi

# Create .env file
cat > .env << EOF
# DiaSync Configuration - Generated $(date)

# Device Configuration
DEVICE_TYPE=$DEVICE_TYPE

# Dexcom Configuration
DEXCOM_USERNAME=${DEXCOM_USERNAME:-}
DEXCOM_PASSWORD=${DEXCOM_PASSWORD:-}
DEXCOM_REGION=${DEXCOM_REGION:-us}

# Abbott Configuration  
ABBOTT_USERNAME=${ABBOTT_USERNAME:-}
ABBOTT_PASSWORD=${ABBOTT_PASSWORD:-}
ABBOTT_REGION=${ABBOTT_REGION:-eu}

# Nightscout Configuration
NIGHTSCOUT_URL=$NIGHTSCOUT_URL
NIGHTSCOUT_API_SECRET=$NIGHTSCOUT_API_SECRET
EOF

echo ""
echo "✅ Configuration saved to .env"
echo ""
echo "🚀 Ready to start DiaSync! Run:"
echo "   docker-compose up -d"
echo ""
echo "📋 View logs with:"
echo "   docker-compose logs -f"
