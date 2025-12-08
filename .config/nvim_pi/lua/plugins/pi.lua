-- disable UI heavy elements for pi
return {
  -- Disable animations (huge CPU saver on Pi)
  { "folke/snacks.nvim", opts = { animate = { enabled = false }, scroll = { enabled = false } } },
  -- Disable the fancy command line UI (saves rendering resources)
  { "folke/noice.nvim", enabled = false },
  -- Disable notifications (optional, but saves popups)
  { "rcarriga/nvim-notify", enabled = false },
  -- Optional: Disable bufferline if you want to save more rendering cycles
  { "akinsho/bufferline.nvim", enabled = false },
}
