lua << EOF
local animate = require("mini.animate")
animate.setup(
{
    -- Cursor path
    cursor = {
      enable = true,
      -- Animate for 200 milliseconds with linear easing
      timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),

      -- Animate with shortest line for any cursor move
      path = animate.gen_path.line({
        predicate = function() return true end,
      }),
    },

    -- Vertical scroll
    scroll = {
      enable = false,
      -- Animate for 200 milliseconds with linear easing
      timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),

      -- Animate equally but with at most 120 steps instead of default 60
      subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
    },

    -- Window resize
    resize = {
      enable = false,
      -- Animate for 200 milliseconds with linear easing
      timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),

      -- Animate only if there are at least 3 windows
      subresize = animate.gen_subscroll.equal({ predicate = is_many_wins }),
    },

    -- Window open
    open = {
      enable = true,
      -- Animate for 400 milliseconds with linear easing
      timing = animate.gen_timing.linear({ duration = 400, unit = 'total' }),

      -- Animate with wiping from nearest edge instead of default static one
      winconfig = animate.gen_winconfig.wipe({ direction = 'from_edge' }),

      -- Make bigger windows more transparent
      winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
    },

    close = {
      enable = true,
      -- Animate for 400 milliseconds with linear easing
      timing = animate.gen_timing.linear({ duration = 400, unit = 'total' }),

      -- Animate with wiping to nearest edge instead of default static one
      winconfig = animate.gen_winconfig.wipe({ direction = 'to_edge' }),

      -- Make bigger windows more transparent
      winblend = animate.gen_winblend.linear({ from = 100, to = 80 }),
    },
}
)
EOF
