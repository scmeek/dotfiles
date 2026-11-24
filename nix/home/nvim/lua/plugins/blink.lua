return {
  "saghen/blink.cmp",
  optional = true, -- LazyVim owns installation and version selection.
  opts = {
    completion = { list = { selection = { preselect = false } } },
    cmdline = { enabled = false },
  },
}
