import { useState } from 'react'
import Moralis from 'moralis'
import { EvmChain } from '@moralisweb3/common-evm-utils'
import {
  MORALIS_API_KEY,
  BLOCK_MONSTER_TOKEN_ADDRESS,
} from '@/config/constants'

const useMoralis = (tokenAddress: `0x${string}`) => {
  const [loading, setLoading] = useState<boolean>(false)
  const [nfts, setNfts] = useState<any[]>([])

  const initMoralis = async () => {
    if (!Moralis.Core.isStarted) {
      await Moralis.start({
        apiKey: MORALIS_API_KEY,
      })
    }
  }

  const getNFTOwners = async () => {
    try {
      setLoading(true)
      await initMoralis()
      const response = await Moralis.EvmApi.nft.getNFTOwners({
        address: tokenAddress,
        chain: EvmChain.SEPOLIA,
      })

      const json = response.toJSON()
      const result = json.result

      if (!result || result.length === 0) return

      const nfts = result
      .filter((nft: any) => {
        const metadata = JSON.parse(nft.metadata)
        return !!metadata
      })
      .map((nft: any): any => {
        const metadata = JSON.parse(nft.metadata)

        return {
          name: metadata.name,
          image: metadata.image,
          tokenId: nft.token_id,
          tokenAddress: nft.token_address,
          ownerOf: nft.owner_of,
        }
      })

      setNfts(nfts)
    } catch (error) {
      console.log(error)
    } finally {
      setLoading(false)
    }
  }


  return {
    nfts,
    loading,
    initMoralis,
    getNFTOwners,
  }
}

export default useMoralis
