--
-- xmonad config - opt1mus - ~/.xmonad/xmonad.hs
--

import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- terminal
myTerminal = "/usr/bin/urxvtc"

-- workspaces
myWorkspaces = ["1:prime","2:web","3:code","4:media"] ++ map show [5..9]

-- window rules
myManageHook = composeAll
    [ className =? "luakit"         --> doShift "2:web"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "sxiv"           --> doFloat
    , className =? "SpiderOak"      --> doShift "4:media"
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

-- re: layouts --> when changing binds do; mod+Shift+space
-- following a mod+q restart, to reset layoutState
myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    tabbed shrinkText tabConfig |||
    Full |||
    spiral (6/7)) |||
    noBorders (fullscreenFull Full)

-- general theme
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#dfaf8f"
myBorderWidth = 1

tabConfig = defaultTheme {
    activeBorderColor = "#000000",
    activeTextColor = "#dcdccc",
    activeColor = "#000000",
    fontName = "-misc-tamsyn-medium-r-normal--9-65-100-100-c-50-iso8859-1",
    inactiveBorderColor = "#000000",
    inactiveTextColor = "#1e2320",
    inactiveColor = "#000000",
		decoHeight = 13
}

-- xmobar theme
xmobarTitleColor = "#dca3a3"
xmobarCurrentWorkspaceColor = "#dcdccc"

-- bindings
-- mod1Mask is left alt
-- mod3Mask is right alt
-- mod4Mask is winkey
myModMask = mod4Mask
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

------------------
-- custom binds
------------------
  -- start terminal
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- lock the screen
  , ((modMask .|. shiftMask, xK_o),
     spawn "i3lock --dpms --color='000000'")

  -- dmenu
  , ((modMask, xK_d),
     spawn "dmenu_run -b -fn -misc-tamsyn-medium-r-normal--12-87-100-100-c-60-iso8859-1")

  -- weechat
	, ((modMask, xK_i),
	   spawn "urxvtc -e weechat-curses")

  -- elinks
	, ((modMask, xK_b),
	   spawn "urxvtc -e elinks")

  -- luakit
	, ((modMask .|. shiftMask, xK_b),
	   spawn "luakit")

	-- cmus
	, ((modMask, xK_c),
		 spawn "urxvtc -e cmus")

------------------
------------------
------------------

-- sane xmonad key bindings
  -- close focused window
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- cycle available layouts
  , ((modMask, xK_space),
     sendMessage NextLayout)

  -- reset layouts on current workspace
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- resize viewed windows to correct size
  , ((modMask, xK_n),
     refresh)

  -- focus next window
  , ((modMask, xK_Tab),
     windows W.focusDown)

  -- focus next window
  , ((modMask, xK_j),
     windows W.focusDown)

  -- focus previous window
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- focus master window
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- swap focused <> master windows
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- swap focused <> next windows
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- swap focused <> previous windows
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- shrink master
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- expand master
  , ((modMask, xK_l),
     sendMessage Expand)

  -- push window into tiling
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- increment # of windows in master area
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- decrement # of windows in master area
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- quit xmonad
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- restart xmonad
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++
 
  -- mod-[1..9], switch to workspace #
  -- mod-shift-[1..9], move active window to workspace #
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod+{w,e,r}, switch to physical/Xinerama screen 1,2,3
	-- mod+Shift+{w,e,r}, move active window to screen 1,2,3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
-- mouse settings & focus rules
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, set active window to float-mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, raise active window to master/top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, set the window to float-mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

  ]
 
-- startuphook > mod-q
-- do bugger all
myStartupHook = return ()

-- start xmonad w/ xmobar et al
main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/.xmobarrc"
  xmonad $ defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 80
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = "   "}
      , manageHook = manageDocks <+> myManageHook
      , startupHook = setWMName "LG3D"
  }
 
-- else use defaults in xmonad/XMonad/Config.hs
defaults = defaultConfig {
    -- theme
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
 
    -- bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,
 
    -- hooks
    layoutHook         = smartBorders $ myLayout,
    manageHook         = myManageHook,
    startupHook        = myStartupHook
}
