import type { ReactElement } from 'react'
import { useEffect, useState } from 'react'
import { useAccount } from 'wagmi'
import Moralis from 'moralis'
import { EvmChain } from '@moralisweb3/common-evm-utils'
import Layout from '@/components/Layout'
import {
  MORALIS_API_KEY,
  BLOCK_MONSTER_TOKEN_ADDRESS,
} from '@/config/constants'
// MUI
import { Breadcrumbs, Typography, Unstable_Grid2 as Grid } from '@mui/material'

export default function Home() {
  const [nfts, setNfts] = useState<any>()

  const { address } = useAccount()

  const runApp = async () => {
    if (!Moralis.Core.isStarted) {
      await Moralis.start({
        apiKey: MORALIS_API_KEY,
      })
    }

    const address = BLOCK_MONSTER_TOKEN_ADDRESS

    const chain = EvmChain.SEPOLIA

    const response = await Moralis.EvmApi.nft.getNFTOwners({
      address,
      chain,
    })

    const json = response.toJSON()
    const result = json.result

    console.log(result)

    setNfts(result)
  }

  useEffect(() => {
    if (!address) return
    runApp()
  }, [address])

  return (
    <>
      <Grid container spacing={2} sx={{ my: 2 }}>
        <Grid xs={12}>
          <Breadcrumbs aria-label="breadcrumb">
            <Typography color="text.primary">HOME</Typography>
          </Breadcrumbs>
        </Grid>
        {!address && (
          <Grid container spacing={2} sx={{ my: 2 }}>
            <Grid xs={12}>
              <p>ウォレットを接続してください。</p>
            </Grid>
          </Grid>
        )}
      </Grid>
    </>
  )
}

Home.getLayout = function getLayout(page: ReactElement) {
  return <Layout>{page}</Layout>
}
