import { useEffect, useState } from 'react'
import { useContractRead } from 'wagmi'
import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardMedia,
  Typography,
} from '@mui/material'
// CONFIG
import { BlockMonsterAbi } from '@/config/abis/BlockMonsterAbi'
import { BLOCK_MONSTER_TOKEN_ADDRESS } from '@/config/constants'

interface NftCardProps {
  nft: any
}

const NftCard = (props: NftCardProps) => {
  const { nft } = props

  const [image, setImage] = useState<string>('')

  const { data, isSuccess } = useContractRead({
    address: BLOCK_MONSTER_TOKEN_ADDRESS,
    abi: BlockMonsterAbi,
    functionName: 'tokenURI',
    args: [nft.tokenId],
  })

  useEffect(() => {
    if (isSuccess) {
      // @ts-ignore
      const base64Content = data.split(',')[1]
      const decodedString = atob(base64Content)
      const jsonObject = JSON.parse(decodedString)

      setImage(jsonObject.image)
    }
  }, [data, isSuccess])

  return (
    <Card>
      <CardMedia component="img" height={380} image={image} alt="nft" />
      <CardContent>
        <Typography gutterBottom variant="body2" component="div">
          {nft.name}
        </Typography>
      </CardContent>
      <CardActions disableSpacing>
        <Button variant="outlined" disableElevation>
          EVOLUTION
        </Button>
      </CardActions>
    </Card>
  )
}

export default NftCard
