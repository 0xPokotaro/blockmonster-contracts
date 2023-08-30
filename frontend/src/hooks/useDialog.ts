import { useState, useCallback } from 'react'

interface UseDialogReturn {
  isOpen: boolean
  handleOpen: () => void
  handleClose: () => void
}

const useDialog = (): UseDialogReturn => {
  const [isOpen, setIsOpen] = useState(false)

  const handleOpen = useCallback(() => {
    setIsOpen(true)
  }, [])

  const handleClose = useCallback(() => {
    setIsOpen(false)
  }, [])

  return {
    isOpen,
    handleOpen,
    handleClose,
  }
}

export default useDialog
