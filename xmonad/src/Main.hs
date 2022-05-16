module Main where

import qualified Data.Map as M
import           Data.Maybe (isJust)
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit (exitSuccess)
import           XMonad.Actions.CycleWS (nextScreen, shiftNextScreen)
import           XMonad.Actions.Warp (warpToWindow)
import           XMonad hiding ((|||))
import           XMonad.Hooks.EwmhDesktops (ewmh)
import           XMonad.Hooks.ManageHelpers ((-?>), ($?))
import qualified XMonad.Hooks.ManageHelpers as H
import           XMonad.Layout.IndependentScreens (countScreens, onCurrentScreen, withScreens, workspaces')
import           XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(JumpToLayout))
import           XMonad.Layout.LayoutModifier (ModifiedLayout(ModifiedLayout))
import           XMonad.Layout.NoBorders (noBorders)
import qualified XMonad.Layout.Renamed as Renamed
import           XMonad.Layout.SimplestFloat (simplestFloat)
import qualified XMonad.StackSet as W

main :: IO ()
main = countScreens >>= \n -> xmonad . ewmh $ def
    { modMask = mod4Mask
    , terminal = "st"
    , keys = myKeys
    , mouseBindings = myMouse
    , layoutHook = myLayout
    , workspaces = withScreens n ["1", "2", "3"]
    }

myKeys :: XConfig l -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig { modMask = modMask }) = M.fromList $
    [ (mod      xK_Return,    spawn $ terminal conf)
    , (mod      xK_t,         spawn $ terminal conf)
    , (mod      xK_r,         spawn "exec \"$(dmenu_path | dmenu)\"")
    , (mod      xK_p,         spawn "delegator")
    , (mod      xK_BackSpace, kill)
    , (mod      xK_j,         windows W.focusDown >> center)
    , (mod      xK_k,         windows W.focusUp >> center)
    , (modshift xK_j,         windows W.swapDown >> center)
    , (modshift xK_k,         windows W.swapUp >> center)
    , (mod      xK_n,         nextScreen >> center)
    , (modshift xK_n,         shiftNextScreen >> nextScreen >> center)
    , (mod      xK_i,         sendMessage (IncMasterN 1) >> center)
    , (mod      xK_d,         sendMessage (IncMasterN (-1)) >> center)
    , (mod      xK_h,         sendMessage Shrink >> center)
    , (mod      xK_l,         sendMessage Expand >> center)
    , (mod      xK_q,         spawn "xmonad --recompile; xmonad --restart")
    , (modshift xK_q,         io exitSuccess)
    , (mod      xK_m,         sendMessage $ JumpToLayout "Max")
    , (mod      xK_w,         sendMessage $ JumpToLayout "Wide")
    , (mod      xK_f,         sendMessage $ JumpToLayout "Floating")
    , (mediaUp,               spawn "pamixer -i 5")
    , (mediaDown,             spawn "pamixer -d 5")
    , (mediaPlay,             spawn "playerctl play-pause")
    , (mediaNext,             spawn "playerctl next")
    ] ++
    [ (m k, windows $ onCurrentScreen f i)
        | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9] ++ zip (workspaces' conf) [xK_z, xK_x, xK_c, xK_v, xK_b]
        , (f, m) <- [(W.greedyView, mod), (W.shift, modshift)]
    ]
  where
    mod k = (modMask, k)
    modshift k = (modMask .|. shiftMask, k)
    center = warpToWindow 0.5 0.5
    mediaUp = (0, xF86XK_AudioRaiseVolume)
    mediaDown = (0, xF86XK_AudioLowerVolume)
    mediaNext = (0, xF86XK_AudioNext)
    mediaPlay = (0, xF86XK_AudioPlay)

myMouse :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouse conf@(XConfig { modMask = modMask }) = M.fromList
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
    , ((modMask, button2), windows . W.sink)
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]

myLayout = rename "Wide" (Tall 1 (3/100) (1/2))
       ||| rename "Max" (noBorders Full)
       ||| rename "Floating" simplestFloat
  where rename = ModifiedLayout . Renamed.Replace
