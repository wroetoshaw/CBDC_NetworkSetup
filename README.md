<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
<p align="center">
  <a href="https://github.com/wroetoshaw/CBDC_NetworkSetup">
  </a>

  <h3 align="center">CBDC Network Setup</h3>

  <p align="center">
    Detailed instructions for setting up a Central Bank Digital Currency (CBDC) network using Hyperledger Fabric.
    <br />
    <a href="https://hyperledger-fabric.readthedocs.io/en/latest/index.html"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/wroetoshaw/CBDC_NetworkSetup">View Demo</a>
    ·
    <a href="https://github.com/wroetoshaw/CBDC_NetworkSetup/issues">Report Bug</a>
    ·
    <a href="https://github.com/wroetoshaw/CBDC_NetworkSetup/issues">Request Feature</a>
  </p>
</p>

<p align="center">
  <a href="#about-the-project">About The Project</a> •
  <a href="#certificate-authorities-ca">Certificate Authorities (CA)</a> •
  <a href="#cryptographic-material-generation">Cryptographic Material Generation</a> •
  <a href="#peers">Peers</a> •
  <a href="#orderers">Orderers</a> •
  <a href="#chaincode">Chaincode</a> •
  <a href="#channels">Channels</a> •
  <a href="#network-scripts">Network Scripts</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#license">License</a>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

- [About The Project](#about-the-project)
- [Certificate Authorities (CA)](#certificate-authorities-ca)
- [Cryptographic Material Generation](#cryptographic-material-generation)
- [Peers](#peers)
- [Orderers](#orderers)
- [Chaincode](#chaincode)
- [Channels](#channels)
- [Network Scripts](#network-scripts)
- [Contributing](#contributing)
- [License](#license)

<!-- ABOUT THE PROJECT -->
## About The Project

The CBDC Network Setup repository provides detailed instructions for setting up a Central Bank Digital Currency (CBDC) network using Hyperledger Fabric. This guide aims to assist users in establishing a fully functional CBDC network by providing clear step-by-step instructions and scripts.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CERTIFICATE AUTHORITIES (CA) -->
## Certificate Authorities (CA)

The Certificate Authorities (CAs) are responsible for issuing and managing digital certificates within the CBDC network. They ensure secure identification and authentication of network participants. The CA component in this repository includes necessary configuration files and scripts for setting up and running the CAs.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CRYPTOGRAPHIC MATERIAL GENERATION -->
## Cryptographic Material Generation

The cryptographic material generation component provides scripts and utilities to generate the necessary cryptographic artifacts required for setting up the CBDC network. These artifacts include TLS certificates, private keys, and other cryptographic files, ensuring secure communication and identity management within the network.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PEERS -->
## Peers

Peers are the nodes that maintain the distributed ledger and execute chaincode within the CBDC network. They validate transactions, endorse proposals, and participate in the consensus process. The peers component includes scripts and configuration files for setting up and managing peers in the CBDC network.

### channel/create.sh

The `create.sh` script is used to create a new channel within the CBDC network. It accepts parameters such as the channel name and configuration file, facilitating the creation and initialization of the channel.

### channel/join.sh

The `join.sh` script is used to join a peer to an existing channel within the CBDC network. It requires parameters like the channel name and peer information to join the specified peer to the channel.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ORDERERS -->
## Orderers

Orderers play a critical role in the CBDC network by ordering and validating transactions. They ensure consistency across the network by establishing a total order of transactions. The orderers component provides scripts and configuration files for setting up and managing orderer nodes in the CBDC network.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CHAINCODE -->
## Chaincode

Chaincode represents the smart contracts deployed on the CBDC network. It encapsulates the business logic and rules governing the interactions and transactions within the network. The chaincode component includes scripts for installing, invoking, and querying chaincode on the network.

### chaincode/install.sh

The `install.sh` script is used to install chaincode onto a peer within the CBDC network. It requires parameters such as the chaincode name and version to install the specified chaincode onto the targeted peer.

### chaincode/invoke.sh

The `invoke.sh` script is used to invoke a transaction on the CBDC network using the installed chaincode. It takes parameters like the chaincode name, function name, and transaction arguments to invoke the specified transaction on the network.

### chaincode/query.sh

The `query.sh` script is used to query the state of the CBDC network using the installed chaincode. It accepts parameters like the chaincode name, function name, and query arguments to retrieve specific information from the network.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CHANNELS -->
## Channels

Channels in the CBDC network provide a way to isolate and restrict access to specific participants and transactions. They allow for private and secure communication within designated groups of network participants. The channels component includes scripts for creating and joining channels in the CBDC network.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- NETWORK SCRIPTS -->
## Network Scripts

The network directory contains various utility scripts for managing and operating the CBDC network. These scripts automate common tasks such as network initialization, clean-up, starting, stopping, and other administrative operations.

### network/all.sh

The `all.sh` script combines multiple operations to perform a complete setup of the CBDC network. It includes tasks such as generating cryptographic material, creating channels, joining peers to channels, installing chaincode, and starting the network.

### network/clean.sh

The `clean.sh` script is used to

 clean up the CBDC network by removing all network artifacts, containers, and generated files. It ensures a clean state for reinitializing or tearing down the network.

### network/down.sh

The `down.sh` script is used to stop and shut down the CBDC network by stopping all containers and network services.

### network/generate.sh

The `generate.sh` script is used to generate the necessary cryptographic material for the CBDC network, including TLS certificates, private keys, and other cryptographic artifacts.

### network/up.sh

The `up.sh` script is used to start and bring up the CBDC network by starting the required containers, services, and network components.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions to the CBDC Network Setup repository are welcome! If you have any improvements, suggestions, or bug fixes, feel free to open a pull request. Your contributions will help enhance the CBDC network setup experience for others.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

This project is licensed under the [MIT License](LICENSE).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-url]: https://github.com/wroetoshaw/CBDC_NetworkSetup/graphs/contributors
[forks-url]: https://github.com/wroetoshaw/CBDC_NetworkSetup/network/members
[stars-url]: https://github.com/wroetoshaw/CBDC_NetworkSetup/stargazers
[issues-url]: https://github.com/wroetoshaw/CBDC_NetworkSetup/issues
[license-url]: https://github.com/wroetoshaw/CBDC_NetworkSetup/blob/master/LICENSE
[product-screenshot]: images/screenshot.png
