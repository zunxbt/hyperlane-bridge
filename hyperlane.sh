#!/bin/bash

curl -s https://raw.githubusercontent.com/zunxbt/logo/main/logo.sh | bash
sleep 3

show() {
    echo -e "\033[1;35m$1\033[0m"
}

show "Installing NVM, Node and npm..."
source <(wget -O - https://raw.githubusercontent.com/zunxbt/installation/main/node.sh)

npm install -g yarn

show "Installing Hyperlane..."
rm -rf hyperlane-monorepo && git clone https://github.com/hyperlane-xyz/hyperlane-monorepo.git && cd hyperlane-monorepo && yarn install && yarn build && cd typescript/cli


read -p "Enter your private key: " PVT_KEY
read -p "Enter your wallet address of the above private key: " WALLET

export HYP_KEY="$PVT_KEY"

mkdir -p ./configs

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

show "Deploying using Hyperlane..."
yarn hyperlane warp deploy
