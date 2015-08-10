import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Control.Monad (liftM2)

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar ~/.xmobarrc"
myBarToo = "xmobar ~/.xmobarrc2"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "green" "" . wrap "|" "|"
                , ppTitle = xmobarColor "yellow" "" . shorten 150
                }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig { 
--          modMask = mod4Mask --i've gotten used to <alt>
        workspaces = ["1_email","2_","3_","4_","5_code","6_","7_","8_","9_media","0_","-_","=_"]
        , terminal = "gnome-terminal"
        , borderWidth = 3
        , manageHook = myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
  } `additionalKeys`
        [ ((mod4Mask .|. mod1Mask, xK_l), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod1Mask, xK_v), spawn "amixer set Master 5%-")
        , ((mod1Mask .|. shiftMask, xK_v), spawn "amixer set Master 5%+")
        ]



myManageHook = composeAll
   [ className =? "Firefox" --> doShift "1_email"
     , className =? "vlc" --> doShift "9_media"
     , className =? "nemo" --> doShift "5_code"
     , manageDocks
   ]

