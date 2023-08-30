// TYPES
import type { ReactElement } from 'react'
// REACT
import { useEffect, useState } from 'react'
// WAGMI
import { useAccount } from 'wagmi'
// ABI
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
import RefreshIcon from '@mui/icons-material/Refresh'
// HOOKS
import useDialog from '@/hooks/useDialog'
// COMPONENTS
import MonsterMintDialog from '@/components/dialog/MonstarMintDialog'
import StoneMintDialog from '@/components/dialog/StoneMintDialog'

export interface Nft {}

export default function Home() {
  const [nfts, setNfts] = useState<Nft[]>([])

  // WAGMI
  const { address } = useAccount()
  // DIALOG
  const {
    isOpen: isMonsterMintDialog,
    handleOpen: openMonsterMintDialog,
    handleClose: closeMonsterMintDialog,
  } = useDialog()
  const {
    isOpen: isStoneMintDialog,
    handleOpen: openStoneMintDialog,
    handleClose: closeStoneMintDialog,
  } = useDialog()

  const handleRefresh = () => {
    runApp()
  }

  const runApp = async () => {
    if (!Moralis.Core.isStarted) {
      await Moralis.start({
        apiKey: MORALIS_API_KEY,
      })
    }

    const response = await Moralis.EvmApi.nft.getNFTOwners({
      address: BLOCK_MONSTER_TOKEN_ADDRESS,
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

    console.log(nfts)
    setNfts(nfts)
  }

  useEffect(() => {
    if (!address) return
    runApp()
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
          <Button
            variant="contained"
            disableElevation
            sx={{ mr: 1 }}
            onClick={openStoneMintDialog}
          >
            STONE MINT
          </Button>
          <StoneMintDialog
            isOpen={isStoneMintDialog}
            handleClose={closeStoneMintDialog}
          />
          <Button
            variant="outlined"
            endIcon={<RefreshIcon />}
            onClick={handleRefresh}
          >
            REFRESH
          </Button>
        </Grid>
        {nfts.map((nft: any, index: any) => {
          return (
            <Grid key={index} xs={4}>
              {nft.tokenId && <NftCard nft={nft} />}
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
