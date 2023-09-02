// TYPES
import type { TransitionProps } from '@mui/material/transitions'
// REACT
import { ReactElement, Ref, forwardRef, useEffect, useState } from 'react'
// WAGMI
import { useAccount, useContractWrite } from 'wagmi'
// CONFIG
import { BlockMonsterAbi } from '@/config/abis/BlockMonsterAbi'
import { EXPLORER_URL, BLOCK_MONSTER_TOKEN_ADDRESS } from '@/config/constants'
// MUI
import {
  Alert,
  Box,
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
  FormControl,
  FormHelperText,
  InputLabel,
  MenuItem,
  Select,
  Slide,
} from '@mui/material'
// REACT HOOK FORM
import { Controller, useForm } from 'react-hook-form'
import { ethers } from 'ethers'
import { Network, Alchemy, Wallet, ContractFactory } from 'alchemy-sdk'

interface MonstarMintDialogProps {
  isOpen: boolean
  handleClose: () => void
}

interface Form {
  monsterType: number
}

const Transition = forwardRef(function Transition(
  props: TransitionProps & {
    children: ReactElement<any, any>
  },
  ref: Ref<unknown>
) {
  return <Slide direction="up" ref={ref} {...props} />
})

const MonstarMintDialog = (props: MonstarMintDialogProps) => {
  const { isOpen, handleClose } = props

  const [hash, setHash] = useState<string>('')

  const { control, handleSubmit, reset } = useForm<Form>({})
  const { address } = useAccount()
  const {
    data: tx,
    isLoading,
    isSuccess,
    write,
  } = useContractWrite({
    address: BLOCK_MONSTER_TOKEN_ADDRESS,
    abi: BlockMonsterAbi,
    functionName: 'mint',
  })

  const submit = async (data: any) => {
    try {
      const quantity = 1
      // write({ args: [data.monsterType, quantity] })

      const provider = new ethers.providers.AlchemyProvider('maticmum', 'SU5ApLPB1TrjGPzjJChmsL0XVXVykZqC')
      const wallet = new ethers.Wallet('488ad0afad7573facfd7f98c4601bb6deadaadfeeac8ac0ab5784dca71dcb393')
      const signer = wallet.connect(provider);
      const contract = new ethers.Contract(BLOCK_MONSTER_TOKEN_ADDRESS, BlockMonsterAbi, signer);

      const tx = await contract.mint(data.monsterType, quantity);
      console.log(tx);
      /*
      const network = 'mumbai';
      const provider = new ethers.providers.AlchemyProvider(network, 'SU5ApLPB1TrjGPzjJChmsL0XVXVykZqC')
      console.log('provider: ', provider)
      const signer = provider.getSigner();

      const contract = new ethers.Contract(BLOCK_MONSTER_TOKEN_ADDRESS, BlockMonsterAbi, signer);
      const tx = await contract.mint(data.monsterType, quantity);
      console.log(tx);
      */
    } catch (error) {
      console.log(error)
    }
  }

  const popup = () => {
    window.open(`${EXPLORER_URL}${hash}`)
  }

  const handleCloseDialog = () => {
    reset()
    setHash('')
    handleClose()
  }

  useEffect(() => {
    if (isSuccess) {
      setHash(tx?.hash || '')
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isSuccess])

  return (
    <Dialog
      open={isOpen}
      onClose={handleClose}
      TransitionComponent={Transition}
      fullWidth
      maxWidth="sm"
    >
      <DialogTitle>Monstar mint</DialogTitle>
      {hash && (
        <DialogContent sx={{ pb: 0 }}>
          <Alert
            severity="success"
            sx={{ cursor: 'pointer' }}
            onClick={() => popup()}
          >
            Please click to confirm the transaction.!!
          </Alert>
        </DialogContent>
      )}
      <Box component="form" onSubmit={handleSubmit(submit)}>
        <DialogContent>
          <DialogContentText sx={{ mb: 2 }}>
            Please select a monster type and press the mint button.
          </DialogContentText>
          <Box>
            <Controller
              name="monsterType"
              control={control}
              rules={{
                validate: (form) => {
                  if (!form) {
                    return 'Not selected.'
                  }
                },
              }}
              defaultValue={0}
              render={({ field, formState: { errors } }) => (
                <FormControl
                  fullWidth
                  error={errors.monsterType ? true : false}
                >
                  <InputLabel id="select-label">select</InputLabel>
                  <Select
                    labelId="select-label"
                    id="select"
                    label="Select"
                    {...field}
                  >
                    <MenuItem value={0}>未選択</MenuItem>
                    <MenuItem value={1}>Grass</MenuItem>
                    <MenuItem value={2}>Fire</MenuItem>
                    <MenuItem value={3}>Earth</MenuItem>
                    <MenuItem value={4}>Water</MenuItem>
                    <MenuItem value={5}>Wind</MenuItem>
                    <MenuItem value={6}>Electric</MenuItem>
                    <MenuItem value={7}>Ice</MenuItem>
                    <MenuItem value={8}>Metal</MenuItem>
                    <MenuItem value={9}>Dark</MenuItem>
                    <MenuItem value={12}>Light</MenuItem>
                  </Select>
                  <FormHelperText>
                    {errors.monsterType?.message || ''}
                  </FormHelperText>
                </FormControl>
              )}
            />
          </Box>
        </DialogContent>
        <DialogActions>
          <Button
            onClick={handleCloseDialog}
            disabled={isLoading}
            variant="outlined"
            disableElevation
          >
            CANCEL
          </Button>
          <Button
            onClick={handleSubmit(submit)}
            variant="contained"
            disabled={isLoading}
            disableElevation
          >
            MINT
          </Button>
        </DialogActions>
      </Box>
    </Dialog>
  )
}

export default MonstarMintDialog
