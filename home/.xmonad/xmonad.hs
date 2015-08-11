import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Control.Monad (liftM2)
import qualified XMonad.StackSet as W
import System.Posix.Unistd

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition

import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.Circle
import XMonad.Layout.Column
import XMonad.Layout.Grid
import XMonad.Layout.Spiral


-- The main function.
main = do
  hostName <- fmap nodeName getSystemID
  h1 <- spawnPipe "xmobar ~/.xmobarrc -x 0"
  h2 <- spawnPipe "xmobar ~/.xmobarrc2 -x 1"
--  xmonad =<< statusBar myBar myPP toggleStrutsKey $ myConfig h2
--  xmonad =<< statusBar myBarToo myPPToo toggleStrutsKey myConfig
  xmonad $ withUrgencyHookC FocusHook urgentConfig $ myConfig h1 h2

urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont }

--myBar = "xmobar ~/.xmobarrc"
--myBarToo = "xmobar ~/.xmobarrc2"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "yellow" "" . wrap "|" "|"
                , ppTitle = xmobarColor "yellow" "" . shorten 150
                , ppSep = "<fc=#00FF00> | </fc>"
                }

myStartup :: X ()
myStartup = do
--  host <- fmap nodeName getSystemID
  spawn ("notify-send 'Warning' 'config in progress'") -- no unicode ⚠
  return ()

logHook' h1 h2 = dynamicLogWithPP myPP { ppOutput = hPutStrLn h1 }
              >> dynamicLogWithPP myPP { ppOutput = hPutStrLn h2 }

mylayoutHook = tiled ||| Mirror tiled ||| tabbed shrinkText defaultTheme ||| Full ||| Circle ||| Column 1.6 ||| Grid ||| spiral (4/3)
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100


myConfig m1 m2 = defaultConfig { 
          modMask = mod4Mask
        , workspaces = ["1_ff","2_","3_work","4_over","5_code","6_","7_","8_","9_vlc","0_","-_","=_"]
        , terminal = "gnome-terminal"
        , borderWidth = 3
        , focusedBorderColor = "#FFFF00"
        , normalBorderColor = "#444400"
        , manageHook = myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig {layoutHook = mylayoutHook }
        , startupHook = myStartup
        , logHook = logHook' m1 m2
  } `additionalKeys`
        [ ((mod4Mask .|. mod1Mask, xK_l), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod4Mask, xK_v), spawn "amixer set Master 5%-")
        , ((mod4Mask .|. shiftMask, xK_v), spawn "amixer set Master 5%+")
--        , ((mod4Mask, xK_Right), moveTo Next (WSIs notSP))
--        , ((mod4Mask, xK_Left), moveTo Prev (WSIs notSP))
        , ((mod4Mask, xK_b), sendMessage ToggleStruts)
        ]



myManageHook = composeAll
   [ className =? "Firefox" --> doShift "1_ff"
     , className =? "Vlc" --> doShift "9_vlc"
--     , className =? "Nemo" --> doShift "5_code"
     , className =? "Screenkey" --> doIgnore
     , manageDocks
   ]

-- notSP = (return $ ("SP" /=) . W.tag) :: X (WindowSpace -> Bool)



