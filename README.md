# BlockMonster

## 🪐 Features

## 👾 Contracts

|Name|Network|Contract address|
|:---|:---|:---|
|BlockMonster|Polygon Mumbai|[0x8bA23B4cC9c6A9F36E8692832dE72839b44AFFf1](https://mumbai.polygonscan.com/address/0x8bA23B4cC9c6A9F36E8692832dE72839b44AFFf1#code)|
|ERC6551Registry|Polygon Mumbai|[0x42735056E2173C1f4eA24d8753169724FC1685Ab](https://mumbai.polygonscan.com/address/0x42735056E2173C1f4eA24d8753169724FC1685Ab#code)|
|ERC6551Implementation|Polygon Mumbai|[0xC1Af53a83Af5feB946F1C7ca4a90d2C16D0D9c8c](https://mumbai.polygonscan.com/address/0xC1Af53a83Af5feB946F1C7ca4a90d2C16D0D9c8c#code)|
|EvolutionStone|Polygon Mumbai|[0x1a3006a3DD49B914dF8668EE061e3Ee88A643d6D](https://mumbai.polygonscan.com/address/0x1a3006a3DD49B914dF8668EE061e3Ee88A643d6D#code)|

## 🛰️ Getting Started

### Deploy command

```bash
# BlockMonster
forge script \
  script/blockMonster/BlockMonster.s.sol:BlockMonsterScript \
  --rpc-url HTTPS_ENDPOINT \
  --broadcast \
  --legacy \
  --verify \
  -vvvv

# EvolutionStone
forge script \
  script/EvolutionStone.s.sol:EvolutionStoneScript \
  --rpc-url HTTPS_ENDPOINT \
  --broadcast \
  --legacy \
  --verify \
  -vvvv

# ERC6551Registry
forge script \
  script/blockMonster/ERC6551Registry.s.sol:ERC6551RegistryScript \
  --rpc-url HTTPS_ENDPOINT \
  --broadcast \
  --legacy \
  --verify \
  -vvvv

# ERC6551Implementation
forge script \
  script/blockMonster/ERC6551Implementation.s.sol:ERC6551ImplementationScript \
  --rpc-url HTTPS_ENDPOINT \
  --broadcast \
  --legacy \
  --verify \
  -vvvv
```
