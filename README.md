# DiaSync - CGM Cloud to Nightscout Synchronization Tool

DiaSync is a Docker-based synchronization tool that automatically retrieves your continuous glucose monitoring (CGM) data from Dexcom or Abbott cloud services and uploads it directly to your Nightscout instance.

## 🩸 What Does DiaSync Do?

DiaSync bridges the gap between your CGM manufacturer's cloud service and your personal Nightscout instance by:

- **Connecting to CGM Cloud Services**: Securely authenticates with Dexcom Share or Abbott LibreView/FreeStyle cloud services
- **Retrieving Your Data**: Downloads your personal glucose readings, trends, and related data
- **Syncing to Nightscout**: Uploads the data to your Nightscout instance for personal tracking and analysis
- **Running Continuously**: Operates as a background service to keep your Nightscout data up-to-date

## 🏥 Supported CGM Systems

| CGM System | Cloud Service | Regions Supported |
|------------|---------------|-------------------|
| **Dexcom** | Dexcom Share | US, International |
| **Abbott FreeStyle Libre** | LibreView | EU, US, Global |
| **Abbott FreeStyle** | LibreView | EU, US, Global |

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose installed
- A running Nightscout instance
- Active CGM cloud account (Dexcom Share or Abbott LibreView)
- Your CGM cloud credentials

### Installation

Choose your preferred setup method:

#### **Option 1: Automated Setup (Recommended)**
```bash
# Run the interactive setup script (no chmod needed)
bash setup.sh
```

#### **Option 2: Using Makefile**
```bash
# Auto-setup and start in one command
make start

# If you get "docker-compose not found", try:
# Edit .env first, then use Docker Compose V2:
docker compose up -d
```

#### **Option 3: Direct Docker Commands**
```bash
# For Docker Compose V2 (newer installations)
cp .env.example .env
# Edit .env with your credentials, then:
docker compose up -d

# For Docker Compose V1 (older installations)
docker-compose up -d
```

#### **Option 3: Manual Template**
```bash
# Copy template and edit manually
cp .env.example .env
# Edit .env with your credentials, then:
docker-compose up -d
```

#### **Option 4: Direct Docker Commands**
```bash
# For Docker Compose V2 (newer installations)
cp .env.example .env
# Edit .env with your credentials, then:
docker compose up -d

# For Docker Compose V1 (older installations)
docker-compose up -d
```

## ⚙️ Configuration

Edit the `.env` file with your specific settings. The configuration uses environment variable substitution and includes sensible defaults:

### Complete Configuration Template
```env
# Device Selection - Choose your CGM device type
DEVICE_TYPE=Dexcom                # Options: Dexcom, Abbott, FreestyleLibre, Freestyle

# Dexcom Configuration (if using Dexcom)
DEXCOM_USERNAME=${DEXCOM_USERNAME}
DEXCOM_PASSWORD=${DEXCOM_PASSWORD}
DEXCOM_REGION=${DEXCOM_REGION:-us}    # Defaults to 'us' if not specified

# Abbott Configuration (if using Abbott or FreestyleLibre or Freestyle)
ABBOTT_USERNAME=${ABBOTT_USERNAME}
ABBOTT_PASSWORD=${ABBOTT_PASSWORD}
ABBOTT_REGION=${ABBOTT_REGION:-eu}    # Defaults to 'eu' if not specified

# Nightscout Configuration (Required for all device types)
NIGHTSCOUT_URL=${NIGHTSCOUT_URL}
NIGHTSCOUT_API_SECRET=${NIGHTSCOUT_API_SECRET}
```

### Device-Specific Setup

**For Dexcom Users:**
1. Set `DEVICE_TYPE=Dexcom`
2. Configure your Dexcom Share credentials
3. Set your region (defaults to `us`)
4. Add your Nightscout details

**For Abbott/FreeStyle Users:**
1. Set `DEVICE_TYPE` to one of: `Abbott`, `FreestyleLibre`, or `Freestyle`
2. Configure your LibreView credentials
3. Set your region (defaults to `eu`)
4. Add your Nightscout details

## 🐳 Docker Usage

### Using Docker Compose (Recommended)
```bash
# Start the service
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the service
docker-compose down
```

### Using Docker Run
```bash
docker run -d \
  --name diasync \
  --env-file .env \
  --restart unless-stopped \
  zbaize01/diasync:production
```

## 📊 Data Synchronization

DiaSync synchronizes the following data types:

- **Glucose Readings**: Current and historical blood glucose values
- **Trends**: Glucose trend arrows and direction indicators
- **Timestamps**: Accurate timing information for all readings
- **Device Information**: CGM sensor and transmitter details (when available)

### Sync Frequency
- Data is typically synchronized every 1-5 minutes
- Frequency may vary based on CGM system and cloud service availability
- Historical data backfill is performed on first run

## 🔒 Security & Privacy

- **Local Processing**: All data synchronization happens locally in your Docker container
- **Secure Storage**: Credentials are stored securely in environment variables
- **No External Dependencies**: No third-party services beyond CGM clouds and your Nightscout
- **Encrypted Communication**: All API communications use HTTPS/TLS

## 🔧 Troubleshooting

### Common Issues

**Docker Compose Command Not Found:**
```bash
# Error: docker-compose: No such file or directory
# Solution: Use Docker Compose V2 syntax instead
docker compose up -d
docker compose logs -f
docker compose down
```

**Authentication Errors:**
- Verify your CGM cloud credentials are correct
- Ensure your account has cloud sharing enabled
- Check that your region setting matches your account

**Nightscout Connection Issues:**
- Verify your Nightscout URL is accessible
- Check that your API secret or access token is correct
- Ensure Nightscout is running and responsive

**No Data Appearing:**
- Check Docker logs: `docker-compose logs -f`
- Verify your CGM is actively uploading to the cloud
- Ensure there's recent data in your CGM cloud account

### Viewing Logs
```bash
# View real-time logs
docker-compose logs -f diasync

# View recent logs
docker logs diasync --tail 100
```

## ⚠️ Important Medical Disclaimer

**THIS SOFTWARE IS NOT A MEDICAL DEVICE AND IS NOT INTENDED FOR MEDICAL USE.**

- This tool is for **informational purposes only**
- **Always consult healthcare professionals** for medical decisions
- **Never rely solely on this software** for diabetes management
- **Use approved medical devices** for critical health monitoring
- **In emergencies, contact emergency services immediately**

DiaSync is a data synchronization tool only. It does not provide medical advice, diagnosis, or treatment recommendations.

## 📄 License

This software is proprietary and confidential. See the [LICENSE](LICENSE) file for complete terms and conditions.

**Key License Points:**
- ✅ Personal, non-commercial use permitted
- ❌ Distribution, modification, or commercial use prohibited
- ❌ Reverse engineering or source code access prohibited
- 📧 Contact zane.okc@gmail.com for licensing inquiries

## 🤝 Support

For technical support, licensing questions, or feature requests:

- **Email**: zane.okc@gmail.com
- **Issues**: Review logs and common troubleshooting steps first
- **Licensing**: Contact for commercial use or distribution permissions

## 🔄 Updates

DiaSync is actively maintained. To update to the latest version:

```bash
# Pull latest image
docker-compose pull

# Restart with new version
docker-compose up -d
```

---

**Made with ❤️ for the diabetes community**

*Remember: Technology can assist with diabetes management, but it never replaces professional medical care and approved medical devices.*
