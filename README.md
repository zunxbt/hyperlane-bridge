<h2 align=center>Hyperlane Token Bridge </h2>

![GYEWO8Yb0AY_2W_](https://github.com/user-attachments/assets/10af7aab-526e-4003-b91c-968416ca783c)

## Prerequisites
- You need to have 0.0035 $ETH on Base Mainnet and 0.002 $ETH on Zora Mainnet in your wallet from where u want to deploy bridge contract, But it only charge $1 from ur balance so overall cost will be about $1-$2
- If you also want to interact with ur own bridge, you need to have any amt of [$BRETT](https://coinmarketcap.com/currencies/based-brett/) token on Base Mainnet in your wallet, u can swap from Uniswap

## Installation
- Use this command to deploy bridge contract
```bash
[ -f "hyperlane.sh" ] && rm hyperlane.sh; wget -q https://raw.githubusercontent.com/zunxbt/hyperlane-bridge/main/hyperlane.sh && chmod +x hyperlane.sh && ./hyperlane.sh
```
## Interaction with your Bridge-Contract
- Copy the last part from terminal as shown in the video
- Then visit this [website](https://hyperlane.superbridge.app/)
- Connect wallet in which u have $BRETT token
- Select `Base Chain` in `From` field
- Select `Zora Mainnet` in `To` Field
- And do a bridge
