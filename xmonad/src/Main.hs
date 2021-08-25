module Main where

import qualified Data.Map as M
import           System.Exit (exitSuccess)
import           XMonad.Actions.CycleWS (nextScreen, shiftNextScreen)
import           XMonad.Actions.Warp (warpToWindow)
import           XMonad hiding ((|||))
import           XMonad.Hooks.EwmhDesktops (ewmh)
import           XMonad.Hooks.ManageHelpers ((-?>), composeOne)
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
    [ (mod      xK_Return, spawn $ terminal conf)
    , (mod      xK_t,      spawn $ terminal conf)
    , (mod      xK_r,      spawn "exec \"$(dmenu_path | dmenu)\"")
    , (mod      xK_p,      spawn "delegator")
    , (modshift xK_c,      kill)
    , (mod      xK_j,      windows W.focusDown >> center)
    , (mod      xK_k,      windows W.focusUp >> center)
    , (modshift xK_j,      windows W.swapDown >> center)
    , (modshift xK_k,      windows W.swapUp >> center)
    , (mod      xK_n,      nextScreen >> center)
    , (modshift xK_n,      shiftNextScreen >> nextScreen >> center)
    , (mod      xK_i,      sendMessage (IncMasterN 1) >> center)
    , (mod      xK_d,      sendMessage (IncMasterN (-1)) >> center)
    , (mod      xK_h,      sendMessage Shrink >> center)
    , (mod      xK_l,      sendMessage Expand >> center)
    , (mod      xK_q,      spawn "cd ~/.xmonad; stack install; xmonad --restart")
    , (modshift xK_q,      io exitSuccess)
    , (mod      xK_m,      sendMessage $ JumpToLayout "Max")
    , (mod      xK_w,      sendMessage $ JumpToLayout "Wide")
    , (mod      xK_f,      sendMessage $ JumpToLayout "Floating")
    ] ++
    [ (m k, windows $ onCurrentScreen f i)
        | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, mod), (W.shift, modshift)]
    ]
  where
    mod k = (modMask, k)
    modshift k = (modMask .|. shiftMask, k)
    center = warpToWindow 0.5 0.5

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

myManageHook = composeOne
    [ ("dialog" `isSuffixOf`) <$> role -?> doFloat
    ]
  where role = stringProperty "WM_WINDOW_ROLE"
        isSuffixOf suf str = suf == drop (length str - length suf) str
