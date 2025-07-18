#!/bin/bash
# DiaSync Setup Script - No chmod needed, runs automatically

set -e

echo "🩸 DiaSync Configuration Setup"
echo "=============================="
echo ""
echo "🚨 CRITICAL MEDICAL DISCLAIMER 🚨"
echo "=================================="
echo "THIS SOFTWARE IS NOT A MEDICAL DEVICE"
echo "- NOT FDA APPROVED for medical use"
echo "- NOT intended for medical decision-making"
echo "- ALWAYS consult healthcare professionals"
echo "- Use approved medical devices for diabetes management"
echo "- In emergencies, contact emergency services immediately"
echo ""
read -p "Do you understand this is NOT a medical device? (yes/no): " medical_consent
if [[ ! "$medical_consent" =~ ^[Yy][Ee][Ss]$ ]]; then
    echo "❌ You must acknowledge the medical disclaimer to continue."
    echo "📋 Please read MEDICAL_COMPLIANCE.md for full details."
    exit 1
fi
echo ""

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
echo "2) Abbott (FreeStyle)"
echo ""
read -p "Enter choice (1-2): " device_choice

case $device_choice in
    1) DEVICE_TYPE="Dexcom" ;;
    2) DEVICE_TYPE="Abbott" ;;
    *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

echo ""
echo "🌐 Enter your Nightscout details:"
while [[ -z "$NIGHTSCOUT_URL" ]]; do
    read -p "Nightscout URL (e.g., https://yoursite.us.nightscoutpro.com): " NIGHTSCOUT_URL
    if [[ -z "$NIGHTSCOUT_URL" ]]; then
        echo "❌ Nightscout URL is required!"
    fi
done

while [[ -z "$NIGHTSCOUT_API_SECRET" ]]; do
    read -p "Nightscout API Secret: " NIGHTSCOUT_API_SECRET
    if [[ -z "$NIGHTSCOUT_API_SECRET" ]]; then
        echo "❌ Nightscout API Secret is required!"
    fi
done

# Initialize empty credentials for unused device type
DEXCOM_USERNAME=""
DEXCOM_PASSWORD=""
DEXCOM_REGION="us"
ABBOTT_USERNAME=""
ABBOTT_PASSWORD=""
ABBOTT_REGION="eu"

echo ""
if [[ "$DEVICE_TYPE" == "Dexcom" ]]; then
    echo "🔵 Enter your Dexcom Share credentials:"
    while [[ -z "$DEXCOM_USERNAME" ]]; do
        read -p "Dexcom Username: " DEXCOM_USERNAME
        if [[ -z "$DEXCOM_USERNAME" ]]; then
            echo "❌ Dexcom username is required!"
        fi
    done
    
    while [[ -z "$DEXCOM_PASSWORD" ]]; do
        read -s -p "Dexcom Password: " DEXCOM_PASSWORD
        echo ""
        if [[ -z "$DEXCOM_PASSWORD" ]]; then
            echo "❌ Dexcom password is required!"
        fi
    done
    
    read -p "Dexcom Region (us/international) [us]: " DEXCOM_REGION_INPUT
    DEXCOM_REGION=${DEXCOM_REGION_INPUT:-us}
else
    echo "🟠 Enter your Abbott/LibreView credentials:"
    while [[ -z "$ABBOTT_USERNAME" ]]; do
        read -p "Abbott Username: " ABBOTT_USERNAME
        if [[ -z "$ABBOTT_USERNAME" ]]; then
            echo "❌ Abbott username is required!"
        fi
    done
    
    while [[ -z "$ABBOTT_PASSWORD" ]]; do
        read -s -p "Abbott Password: " ABBOTT_PASSWORD
        echo ""
        if [[ -z "$ABBOTT_PASSWORD" ]]; then
            echo "❌ Abbott password is required!"
        fi
    done
    
    read -p "Abbott Region (eu/us/global) [eu]: " ABBOTT_REGION_INPUT
    ABBOTT_REGION=${ABBOTT_REGION_INPUT:-eu}
fi

# Create .env file
cat > .env << EOF
# DiaSync Configuration - Generated $(date)

# Device Configuration
DEVICE_TYPE=$DEVICE_TYPE

# Dexcom Configuration
DEXCOM_USERNAME=$DEXCOM_USERNAME
DEXCOM_PASSWORD=$DEXCOM_PASSWORD
DEXCOM_REGION=$DEXCOM_REGION

# Abbott Configuration  
ABBOTT_USERNAME=$ABBOTT_USERNAME
ABBOTT_PASSWORD=$ABBOTT_PASSWORD
ABBOTT_REGION=$ABBOTT_REGION

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
