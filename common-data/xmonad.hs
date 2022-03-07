import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Run (spawnPipe)

import System.Taffybar.Support.PagerHints (pagerHints)
-- import XMonad.Actions.WindowBringer
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
-- import qualified XMonad.Layout.LayoutCombinators as LC
import XMonad.Layout.MouseResizableTile (mouseResizableTile)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Tabbed (simpleTabbed)

-- rewrite the start progs
startProgs prgs = mapM_ (\(cmd,args) -> safeSpawn cmd args) prgs

initProgs = [ ("feh", ["--bg-fill", "/home/dj/Pictures/desk"])
            , ("arbtt-capture", [])]


customLayout = smartBorders $ avoidStruts ( tiled ||| Mirror tiled ||| Full ||| mouseResizableTile ||| simpleTabbed ) ||| Full
            where
                tiled = Tall nmaster delta ratio
                nmaster = 1
                delta = 3/100
                ratio = 1/2

main = do
     -- xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.config"
     xmonad $ docks $ ewmh $ pagerHints $ desktopConfig
       { terminal    = "kitty"
       , modMask     = mod4Mask
       , focusFollowsMouse = True
       , borderWidth = 1
       , layoutHook = customLayout
       {-, logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
       -}
       --, logHook = dbusLog client defaultPP
       , handleEventHook = docksEventHook <+> handleEventHook desktopConfig
       , manageHook = manageDocks <+> manageHook desktopConfig
       , startupHook = do
           startupHook desktopConfig
           startProgs initProgs
       } `additionalKeysP`
       	 [ ("M-x b", safeSpawn "chrome" [])
	 , ("M-x e", safeSpawn "emacsclient" ["-c"])
	 , ("M-o", safeSpawn "rofi" ["-show", "run"])
	 -- window bringer actions
	 , ("M-S-g", safeSpawn "rofi" ["-show", "window"])
         , ("M-S-e", safeSpawn "rofi" ["-show", "emoji", "-modi", "emoji"])
--	 , ("M-S-k", bringMenu)

	 , ("C-M1-l", spawn "slock")

	 -- multimedia keys
	 -- , ("<XF86AudioMute>", safeSpawn "") -- already handled
         , ("<XF86AudioPlay>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
         , ("<XF86Forward>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
         , ("<XF86Back>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
         , ("<XF86AudioNext>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
         , ("<XF86AudioPrev>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
	 , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
	 , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
	 ] `additionalMouseBindings` []
         -- [ ((0, 7), const $ spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
	 -- , ((0, 6), const $ spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
         -- ]

