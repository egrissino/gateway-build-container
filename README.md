# Mono Gateway Yocto build container

This repository provides a containerized build environment for the Mono Gateway Yocto-based distribution. It ensures a consistent and reproducible build process by including all necessary dependencies and setup scripts.

## Features
- Preconfigured Docker container for Yocto builds
- Includes all necessary dependencies
- Automated environment setup
- Simplifies building and deploying the Mono Gateway image

## Prerequisites
Ensure you have the following installed on your host system:
- Docker
- Git

## Setup and Usage
### 1. Clone the Repository
```bash
git clone https://github.com/egrissino/gateway-build-container.git
cd gateway-build-container
```

### 2. Build and Run the Container
```bash
./build-container.sh
```
This script will:
- Build the Docker image
- Start the container
- Attach the terminal to the build environment

### 3. Start the Yocto Build
Once inside the container, run:
```bash
source ./buildyocto.sh
```
This will:
- Synchronize the Yocto layers
- Initialize the build environment
- Start the BitBake build process

## Repository Structure
- `Dockerfile` - Defines the container environment
- `build-container.sh` - Automates container creation and setup
- `buildyocto.sh` - Handles Yocto layer synchronization and build execution

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create a feature branch
3. Commit your changes with descriptive messages
4. Submit a pull request

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Support
For issues and support, please open an issue in the repository or contact `evanjgrissino@gmail.com`.
