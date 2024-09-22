#!/bin/bash

curl -s https://raw.githubusercontent.com/zunxbt/logo/main/logo.sh | bash
sleep 3

show() {
    echo -e "\033[1;35m$1\033[0m"
}

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    show "Loading NVM..."
    source "$NVM_DIR/nvm.sh"
else
    show "NVM not found, installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    source "$NVM_DIR/nvm.sh"
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    show "Node.js not found. Installing Node.js..."
    nvm install node
else
    show "Node.js is already installed."
fi

# Check if Hyperlane CLI is installed globally
if ! command -v hyperlane &> /dev/null; then
    show "Hyperlane CLI not found. Installing..."
    npm install -g @hyperlane-xyz/cli
else
    show "Hyperlane CLI is already installed."
fi
echo


read -p "Enter your private key: " PVT_KEY
read -p "Enter your wallet address of the above private key: " WALLET

# Export the private key
export HYP_KEY="$PVT_KEY"

# Create the configs directory if it doesn't exist
mkdir -p ./configs

# Create the warp-route-deployment.yaml configuration file
cat <<EOF > ./configs/warp-route-deployment.yaml
base:
  interchainSecurityModule:
    modules:
      - relayer: "$WALLET"
        type: trustedRelayerIsm
      - domains: {}
        owner: "$WALLET"
        type: defaultFallbackRoutingIsm
    threshold: 1
    type: staticAggregationIsm
  isNft: false
  mailbox: "0xeA87ae93Fa0019a82A727bfd3eBd1cFCa8f64f1D"
  owner: "$WALLET"
  token: "0x532f27101965dd16442e59d40670faf5ebb142e4"
  type: collateral
zoramainnet:
  interchainSecurityModule:
    modules:
      - relayer: "$WALLET"
        type: trustedRelayerIsm
      - domains: {}
        owner: "$WALLET"
        type: defaultFallbackRoutingIsm
    threshold: 1
    type: staticAggregationIsm
  isNft: false
  mailbox: "0xF5da68b2577EF5C0A0D98aA2a58483a68C2f232a"
  owner: "$WALLET"
  type: synthetic
EOF

# Deploy using Hyperlane
show "Deploying using Hyperlane..."
hyperlane warp deploy
