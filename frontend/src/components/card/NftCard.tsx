import { Button, Card, CardActions, CardMedia } from '@mui/material'

const NftCard = () => {
  return (
    <Card>
      <CardMedia
        component="img"
        height="250"
        image="https://i.seadn.io/gcs/files/40bb59080f4367839b104372e80fecfd.png?auto=format&dpr=1&w=1000"
        alt="nft"
      />
      <CardActions disableSpacing>
        <Button variant="outlined" disableElevation>
          EVOLUTION
        </Button>
      </CardActions>
    </Card>
  )
}

export default NftCard
