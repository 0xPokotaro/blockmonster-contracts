// TYPES
import type { ReactElement } from 'react'
// REACT
import { useEffect, useState } from 'react'
// WAGMI
import { useAccount, useContractWrite } from 'wagmi'
// ABI
import { BlockMonsterAbi } from '@/config/abis/BlockMonsterAbi'
import Moralis from 'moralis'
import { EvmChain } from '@moralisweb3/common-evm-utils'
import Layout from '@/components/Layout'
import NftCard from '@/components/card/NftCard'
import {
  MORALIS_API_KEY,
  BLOCK_MONSTER_TOKEN_ADDRESS,
} from '@/config/constants'
// MUI
import {
  Breadcrumbs,
  Button,
  Typography,
  Unstable_Grid2 as Grid,
} from '@mui/material'
// HOOKS
import useDialog from '@/hooks/useDialog'
// COMPONENTS
import MonsterMintDialog from '@/components/dialog/MonstarMintDialog'

export interface Nft {}

export default function Home() {
  const [nfts, setNfts] = useState<Nft[]>([])

  // WAGMI
  const { address } = useAccount()
  const { data, isLoading, isSuccess, write } = useContractWrite({
    address: BLOCK_MONSTER_TOKEN_ADDRESS,
    abi: BlockMonsterAbi,
    functionName: 'mint',
  })
  // DIALOG
  const {
    isOpen: isMonsterMintDialog,
    handleOpen: openMonsterMintDialog,
    handleClose: closeMonsterMintDialog,
  } = useDialog()

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

    // setNfts(result)
  }

  useEffect(() => {
    if (!address) return
    // runApp()
    setNfts([1, 2, 3])
  }, [address])

  return (
    <>
      <Grid container spacing={2} sx={{ my: 2 }}>
        <Grid xs={12}>
          <Breadcrumbs aria-label="breadcrumb">
            <Typography color="text.primary">HOME</Typography>
          </Breadcrumbs>
        </Grid>
        <Grid xs={12}>
          <Button
            variant="contained"
            disableElevation
            sx={{ mr: 1 }}
            onClick={openMonsterMintDialog}
          >
            MONSTER MINT
          </Button>
          <MonsterMintDialog
            isOpen={isMonsterMintDialog}
            handleClose={closeMonsterMintDialog}
          />
          <Button variant="contained" disableElevation>
            STONE MINT
          </Button>
        </Grid>
        {nfts.map((nft: any) => {
          return (
            <Grid key={nft} xs={3}>
              <NftCard />
            </Grid>
          )
        })}
      </Grid>
    </>
  )
}

Home.getLayout = function getLayout(page: ReactElement) {
  return <Layout>{page}</Layout>
}
