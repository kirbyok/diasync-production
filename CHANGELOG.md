# Changelog

All notable changes to DiaSync will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Updated Docker image references to use production tag
- Simplified CGM device selection from 4 options to 2 (Dexcom, Abbott FreeStyle)

### Fixed
- Docker Compose V2 compatibility in Makefile
- Cross-platform command detection for docker-compose vs docker compose

## [1.1.0] - 2025-07-17

### Added
- **MEDICAL_COMPLIANCE.md** - Comprehensive regulatory standards documentation
- Interactive medical disclaimer consent requirement in setup script
- Medical disclaimers in all configuration files (.env.example, docker-compose.yml)
- Enhanced Makefile with medical disclaimer enforcement and new commands
- CONTRIBUTING.md with medical safety guidelines for contributors
- Multiple automated setup options (Makefile, interactive script, templates)
- Visual Studio Code workspace file exclusion in ignore files
- Repository cleanup and professional project structure
- Comprehensive troubleshooting documentation

### Enhanced
- **LICENSE** - Strengthened medical disclaimers and regulatory compliance
- **README.md** - Added prominent FDA/CE/regulatory warnings and compliance information  
- **Setup Script** - Interactive prompts with validation and medical consent requirements
- **Medical Disclaimers** - Enhanced diabetes-specific warnings and emergency protocols
- **Legal Protections** - Expanded liability limitations for medical complications

### Security
- Enhanced environment variable protection for sensitive credentials
- Strengthened proprietary license with medical device restrictions
- Added medical safety requirements for contributors
- Comprehensive privacy and data protection disclaimers

### Compliance
- **FDA Compliance** - Explicit "NOT FDA APPROVED" disclaimers
- **CE Marking** - Clear "NOT CE MARKED" statements  
- **Health Canada** - "NOT APPROVED" regulatory notices
- **International Standards** - ISO 13485, IEC 62304, ISO 14971 disclaimers
- **Clinical Validation** - "NO CLINICAL TRIALS" statements
- **HIPAA/GDPR** - Data protection responsibility clauses

### Documentation
- Repository structure cleanup (removed redundant files)
- Added CHANGELOG.md for version tracking
- Enhanced README with multiple setup options
- Comprehensive medical compliance documentation
- Professional contribution guidelines

## [1.0.0] - 2025-07-17

### Added
- Core synchronization functionality between CGM clouds and Nightscout
- Support for Dexcom Share and Abbott LibreView cloud services
- Docker-based deployment for easy installation
- Interactive setup process with credential validation
- Cross-platform compatibility (macOS, Linux, Windows)
- Basic medical disclaimers and legal framework
- Environment-based configuration system
- Automated Docker Compose deployment

### Features
- **CGM Support**: Dexcom (US/International), Abbott FreeStyle (EU/US/Global)
- **Nightscout Integration**: Direct API synchronization
- **Data Types**: Glucose readings, trends, timestamps, device information
- **Sync Frequency**: 1-5 minute intervals with historical backfill
- **Security**: Encrypted HTTPS communication, local credential storage

### Initial Release
- Docker image: zbaize01/diasync:production
- Proprietary license with usage restrictions
- Basic documentation and setup instructions

---

**Note**: This is proprietary software. All changes are subject to the terms in the LICENSE file.

**Medical Disclaimer**: DiaSync is NOT a medical device and has NOT been approved by the FDA, CE, or any regulatory authority for medical use. Always consult healthcare professionals for diabetes management.
