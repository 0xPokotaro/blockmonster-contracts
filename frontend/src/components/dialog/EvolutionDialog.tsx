// TYPES
import type { TransitionProps } from '@mui/material/transitions'
// REACT
import { ReactElement, Ref, forwardRef, useEffect, useState } from 'react'
// WAGMI
import { useContractWrite } from 'wagmi'
// CONFIG
import { EvolutionStoneAbi } from '@/config/abis/EvolutionStoneAbi'
import {
  EXPLORER_URL,
  EVOLUTION_MONSTER_TOKEN_ADDRESS,
} from '@/config/constants'
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
  Slide,
} from '@mui/material'
// REACT HOOK FORM
import { Controller, useForm } from 'react-hook-form'

interface StoneMintDialogProps {
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

const StoneMintDialog = (props: StoneMintDialogProps) => {
  const { isOpen, handleClose } = props

  const [hash, setHash] = useState<string>('')

  const { handleSubmit, reset } = useForm<Form>({})
  const {
    data: tx,
    isLoading,
    isSuccess,
    write,
  } = useContractWrite({
    address: EVOLUTION_MONSTER_TOKEN_ADDRESS,
    abi: EvolutionStoneAbi,
    functionName: 'mint',
  })

  const submit = async (data: any) => {
    try {
      const quantity = 1
      write({ args: [quantity] })
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
      <DialogTitle>Evolution stone mint</DialogTitle>
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
            Please press the mint button.
          </DialogContentText>
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

export default StoneMintDialog
