--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "tamsyn normal 5"
theme.fg   = "#dcdccc"
theme.bg   = "#1f1f1f"

-- Genaral colours
theme.success_fg = "#0f0"
theme.loaded_fg  = "#33AADD"
theme.error_fg = "#FFF"
theme.error_bg = "#F00"

-- Warning colours
theme.warning_fg = "#F00"
theme.warning_bg = "#FFF"

-- Notification colours
theme.notif_fg = "#444"
theme.notif_bg = "#FFF"

-- Menu colours
theme.menu_fg                   = "#777777"
theme.menu_bg                   = "#3f3f3f"
theme.menu_selected_fg          = "#dcdccc"
theme.menu_selected_bg          = "#506070"
theme.menu_title_bg             = "#4f4f4f"
theme.menu_primary_title_fg     = "#1f1f1f"
theme.menu_secondary_title_fg   = "#1f1f1f"

-- Proxy manager
theme.proxy_active_menu_fg      = '#000'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = "#4f4f4f"
theme.sbar_bg         = "#000"

-- Downloadbar specific
theme.dbar_fg         = "#fff"
theme.dbar_bg         = "#000"
theme.dbar_error_fg   = "#F00"

-- Input bar specific
theme.ibar_fg           = "#777777"
theme.ibar_bg           = "#2f2f2f"

-- Tab label
theme.tab_fg            = "#dcdccc"
theme.tab_bg            = "#1e2320"
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = "#fff"
theme.selected_bg       = "#506070"
theme.selected_ntheme   = "#ddd"
theme.loading_fg        = "#33AADD"
theme.loading_bg        = "#000"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#0F0"
theme.notrust_fg        = "#F00"

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
