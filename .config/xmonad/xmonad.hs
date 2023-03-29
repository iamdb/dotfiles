{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module Main where

import Control.Monad.RWS (Endo)
import Data.List (isInfixOf)
import Data.Map qualified as M
import XMonad
import XMonad.Actions.CycleWS (WSType (Not), emptyWS, moveTo)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers
  ( doCenterFloat,
    doFullFloat,
    isDialog,
    isFullscreen,
  )
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders (hasBorder, smartBorders)
import XMonad.Layout.PerWorkspace (onWorkspaces)
import XMonad.Layout.SimplestFloat (simplestFloat)
import XMonad.Layout.Spacing (Border (Border), spacingRaw)
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeCol, ThreeColMid))
import XMonad.Prompt
import XMonad.StackSet qualified as W
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig (additionalKeysP)

myTerminal :: String
myTerminal = "kitty"

myModMask :: KeyMask
myModMask = mod4Mask

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myclickJustFocuses :: Bool
myclickJustFocuses = False

myBorderWidth :: Dimension
myBorderWidth = 1

myWorkspaces :: [String]
myWorkspaces = ["0", "1", "2", "3", "4"]

myNormalBorderColor :: String
myNormalBorderColor = "#282828"

myFocusedBorderColor :: String
myFocusedBorderColor = "#52bdff"

myBackgroundColor :: String
myBackgroundColor = "#161616"

myContentColor :: String
myContentColor = "#52bdff"

tagIcon :: String -> String
tagIcon icon = case () of
  _
    | icon == "0" -> "\62601"
    | icon == "1" -> "\61574"
    | icon == "2" -> "\61878"
    | icon == "3" -> "\61530"
    | icon == "4" -> "\61664"
    | otherwise -> ""

myPP :: PP
myPP =
  def
    { ppVisible = \name -> "(box :class \"tag\" (button :onclick \"wmctrl -s " ++ name ++ "\" :class \"" ++ "ws-visible" ++ "\" \"" ++ tagIcon name ++ "\"))",
      ppHidden = \name -> "(box :class \"tag\" (button :onclick \"wmctrl -s " ++ name ++ "\" :class \"" ++ "ws-hidden" ++ "\" \"" ++ tagIcon name ++ "\"))",
      ppHiddenNoWindows = \name -> "(box :class \"tag\" (button :onclick \"wmctrl -s " ++ name ++ "\" :class \"" ++ "ws-hidden-no-windows" ++ "\" \"" ++ tagIcon name ++ "\"))",
      ppCurrent = \name -> "(box :class \"tag\" (button :onclick \"wmctrl -s " ++ name ++ "\" :class \"" ++ "ws-current" ++ "\" \"" ++ tagIcon name ++ "\"))",
      ppUrgent = \name -> "(box :class \"tag\" (button :onclick \"wmctrl -s " ++ name ++ "\" :class \"" ++ "ws-urgent" ++ "\" \"" ++ tagIcon name ++ "\"))",
      ppOrder = \(ws : _ : _ : _) -> [ws]
    }

mySB :: StatusBarConfig
mySB = statusBarProp "eww open bar0" (pure myPP)

myStartupHook :: X ()
myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawn "xset r rate 300 50"
  spawn "xset s on"
  spawn "xset s 600 -dpms"

myManageHook :: Query (Endo WindowSet)
myManageHook =
  composeAll . concat $
    [ [isFullscreen --> doFullFloat],
      [isDialog --> doCenterFloat],
      [ fmap (c `isInfixOf`) className
          --> doCenterFloat
        | c <- myCenterFloats
      ],
      [ fmap (c `isInfixOf`) className
          --> doFloat
        | c <- myFloats
      ],
      [ fmap (c `isInfixOf`) wmName
          --> doFloat
        | c <- myFloats
      ],
      [fmap (c `isInfixOf`) className --> doShift "1" | c <- myShiftToChat],
      [fmap (c `isInfixOf`) className --> doShift "2" | c <- myShiftToGames],
      [fmap (c `isInfixOf`) className --> doShift "4" | c <- myShiftToSlackEmail],
      [fmap (c `isInfixOf`) className --> hasBorder False | c <- myRemoveBorder],
      [(className =? "firefox" <&&> fmap (c `isInfixOf`) resource) --> doFloat | c <- myFirefoxFloats],
      [(className =? "thunderbird" <&&> fmap (c `isInfixOf`) resource) --> doCenterFloat | c <- myThunderbirdCenterFloats]
    ]
  where
    wmName = stringProperty "WM_NAME"
    myCenterFloats =
      [ "Sublime_merge",
        "obsidian",
        "Pavucontrol",
        "1Password",
        "Xarchiver",
        "Yad",
        "feh",
        "zathura",
        "Picture in picture"
      ]
    myFloats =
      [ "Gimp",
        "mpv",
        "GStreamer",
        "Signal"
      ]
    myFirefoxFloats = ["Devtools", "Toolkit"]
    myThunderbirdCenterFloats = ["Calendar", "Msgcompose"]
    myShiftToSlackEmail = ["thunderbird", "Slack"]
    myShiftToGames = ["Lutris", "Steam", "heroic"]
    myShiftToChat = ["discord", "zoom", "Signal"]
    myRemoveBorder = ["Seafile Client", "Toolkit"]

myLayout :: Choose ThreeCol (Choose ThreeCol Tall) a
myLayout = threeColCenter ||| threeCol ||| tiled
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio
    threeCol = ThreeCol nmaster delta ratio
    threeColCenter = ThreeColMid nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2

    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
  xmonad
    . withSB mySB
    . ewmhFullscreen
    . ewmh
    . docks
    $ def
      { -- simple stuff
        terminal = myTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        modMask = myModMask,
        workspaces = myWorkspaces,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook =
          smartBorders
            . onWorkspaces ["1", "2"] simplestFloat
            . hiddenWindows
            . avoidStruts
            . spacingRaw False (Border 0 8 0 8) True (Border 8 0 8 0) True
            $ myLayout,
        manageHook = myManageHook <+> manageDocks <+> manageHook def,
        handleEventHook = handleEventHook def,
        startupHook = myStartupHook,
        clickJustFocuses = myclickJustFocuses
      }
      `additionalKeysP` [ ("M-p", spawn "rofi -show drun -dpi 111"),
                          ("M-z", spawn "rofi -show calc -modi calc -no-lazy-grab -no-sort"),
                          ("M-w", moveTo Next (Not emptyWS)),
                          ("M-]", moveTo Next (Not emptyWS)),
                          ("M-[", moveTo Prev (Not emptyWS)),
                          ("M-\\", withFocused hideWindow),
                          ("M-S-\\", popNewestHiddenWindow),
                          ("M-C-r", spawn "pkill -USR1 redshift-gtk"),
                          ("M-f", withFocused $ windows . flip W.float (W.RationalRect 0 0 1 1)),
                          ("M-S-q", spawn "loginctl kill-session $XDG_SESSION_ID"),
                          ("M-t", withFocused toggleFloat),
                          ("<XF86AudioNext>", spawn "playerctl next"),
                          ("<XF86AudioPlay>", spawn "playerctl play-pause"),
                          ("<XF86AudioPrev>", spawn "playerctl previous"),
                          ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
                          ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
                          ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
                        ]
  where
    toggleFloat w =
      windows
        ( \s ->
            if M.member w (W.floating s)
              then W.sink w s
              else W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 3) (3 / 5)) s
        )
