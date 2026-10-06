return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    damping = 0.95,
    damping_insert_mode = 0.95,
    distance_stop_animating = 0.5,
    legacy_computing_symbols_support = true,
    matrix_pixel_threshold = 0.5,
    never_draw_over_target = false,
    smear_between_buffers = false,
    stiffness = 0.8,
    stiffness_insert_mode = 0.7,
    time_interval = 7,
    trailing_stiffness = 0.6,
    trailing_stiffness_insert_mode = 0.7,
  },
}
