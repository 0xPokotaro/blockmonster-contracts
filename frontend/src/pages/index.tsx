import type { ReactElement } from 'react'
import { useEffect } from 'react'
import { Box, Container, Unstable_Grid2 as Grid } from '@mui/material'
import { useAccount } from 'wagmi'
import Moralis from 'moralis'
import { EvmChain } from '@moralisweb3/common-evm-utils'
import Layout from '@/components/Layout'
import { MORALIS_API_KEY, BLOCK_MONSTER_TOKEN_ADDRESS } from '@/config/constants'
import MintButton from '@/components/button/MintButton'

export default function Home() {
  const { address } = useAccount()

  const runApp = async () => {
    if (!Moralis.Core.isStarted) {
      await Moralis.start({
        apiKey: MORALIS_API_KEY,
      })
    }

    console.log('Moralis is started:', BLOCK_MONSTER_TOKEN_ADDRESS)

    const address = BLOCK_MONSTER_TOKEN_ADDRESS

    const chain = EvmChain.SEPOLIA

    const response = await Moralis.EvmApi.nft.getNFTOwners({
      address,
      chain,
    })

    console.log(response.toJSON())
  }

  useEffect(() => {
    runApp()
  }, [])

  return (
    <>
      <Box>
        <Container maxWidth="lg">
          <Grid container spacing={2} sx={{ my: 2 }}>
            <Grid xs={12}>
              <p>メッセージ</p>
              <p>NFTを保有していません。</p>
            </Grid>
            <Grid xs={12}>
              <p>アクション</p>
              <MintButton />
            </Grid>
          </Grid>
        </Container>
      </Box>
    </>
  )
}

Home.getLayout = function getLayout(page: ReactElement) {
  return <Layout>{page}</Layout>
}
