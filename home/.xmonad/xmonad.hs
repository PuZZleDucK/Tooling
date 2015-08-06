import XMonad
import XMonad.Hooks.DynamicLog

import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
--   =<< statusBar myBarToo myPP toggleStrutsKey myConfig

myBar = "xmobar"
myBarToo = "xmobar ~/.xmobarrc2"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "green" "" . wrap "|" "|"
                , ppTitle = xmobarColor "green" "" . shorten 150
                }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig { 
--          modMask = mod4Mask --i've gotten used to <alt>
          terminal = "gnome-terminal"
        , borderWidth = 3
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
} `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod1Mask, xK_v), spawn "amixer set Master 5%-")
        , ((mod1Mask .|. shiftMask, xK_v), spawn "amixer set Master 5%+")
        ]





--main = xmonad defaultConfig
--        { 
        -- modMask = mod4Mask -- Use Super instead of Alt
--          terminal = "gnome-terminal"
        -- more changes
--        myBorderWidth = 1
--        , borderWidth = 3
--        }


--import XMonad
--import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.ManageDocks
--import XMonad.Hooks.ManageHelpers
--import XMonad.Layout.NoBorders
--import XMonad.Layout.Gaps
--import XMonad.Util.Run(spawnPipe)
--import XMonad.Util.EZConfig(additionalKeys)
--import System.IO


--main = do
--  xmproc <- spawnPipe "/usr/bin/xmobar /home/timo/.xmonad/xmobarrc"
--  xmonad defaultConfig {
--    modMask = mod4Mask, 
--    terminal = "urxvt",
--    manageHook = manageDocks <+> manageHook defaultConfig,
--    layoutHook = avoidStruts $ layoutHook defaultConfig,
--    logHook = dynamicLogWithPP $ xmobarPP
--                        { ppOutput = hPutStrLn xmproc,
--                          ppTitle = xmobarColor "green" "" . shorten 50
--                        }
--  }

