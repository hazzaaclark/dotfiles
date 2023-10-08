-- COPYRIGHT (C) HARRY CLARK 2023
--
-- XMONAD CONFIGURATION

{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE FlexibleContexts #-}

-- DEFINE THE MAIN MODULE AND SUBSEQUENT IMPORTS

module MAIN(main) where

import        XMonad
import        XMonad.Actions.CopyWindow                 (copyToAll, kill1, killAllOtherCopies)
import        XMonad.Actions.FlexibleResize             as Flex
import        XMonad.Actions.NoBorders                  (toggleBorder)
import        XMonad.Actions.Promote                    (promote)
import        XMonad.Actions.Submpa                     (submap)
import        XMonad.Actions.TiledWindowDragging        (dragging)
import        XMonad.Actions.WithAll                    (killAll, sinkAll)

import        XMonad.Hooks.DynamicIcons                 (IconConfig (..), appIcon,
                                                        dynamicIconsPP,
                                                        iconsFmtReplace,
                                                        iconsGetFocus,
                                                        wrapUnwords)

import        XMonad.Hooks.EwmhDesktops                 (activateLogHook, ewmh,
                                                        ewmhFullscreen)
import        XMonad.Hooks.ManageDocks                  (ToggleStruts (ToggleStruts),
                                                        avoidStruts, docks)
import        XMonad.Hooks.ManageHelpers                (composeOne, doCenterFloat,
                                                        doFullFloat, isDialog,
                                                        isFullscreen, transience,
                                                                          (-?>))
import        XMonad.Hooks.StatusBar                    (StatusBarConfig,
                                                        statusBarProp, withSB)
import        XMonad.Hooks.StatusBar.PP                 (PP (..), filterOutWsPP,
                                                        shorten', wrap,
                                                       xmobarAction,
                                                        xmobarBorder, xmobarColor,
                                                        xmobarFont, xmobarStrip)
import         XMonad.Hooks.WindowSwallowing           (swallowEventHook)
import         XMonad.Layout.Accordion                  (Accordion (Accordion))
import         XMonad.Layout.DraggingVisualizer         (draggingVisualizer)
import         XMonad.Layout.LayoutModifier             (ModifiedLayout)
import         XMonad.Layout.MultiToggle                (EOT (EOT),
                                                      Toggle (Toggle), mkToggle,
                                                        (??))
import         XMonad.Layout.MultiToggle.Instances      (StdTransformers (NBFULL, NOBORDERS))
import         XMonad.Layout.NoBorders                  (Ambiguity (OnlyScreenFloat),
                                                      lessBorders)
import         XMonad.Layout.Renamed                    (Rename (Replace), renamed)
import         XMonad.Layout.ResizableThreeColumns (ResizableThreeCol (ResizableThreeColMid))
import         XMonad.Layout.ResizableTile         (MirrorResize (MirrorExpand, MirrorShrink),
                                                      ResizableTall (ResizableTall))
import           XMonad.Layout.Simplest              (Simplest (Simplest))
import           XMonad.Layout.Spacing               (Border (Border), Spacing,
                                                      decScreenSpacing,
                                                      decScreenWindowSpacing,
                                                      decWindowSpacing,
                                                      incScreenSpacing,
                                                      incScreenWindowSpacing,
                                                      incWindowSpacing,
                                                      spacingRaw,
                                                      toggleScreenSpacingEnabled,
                                                      toggleWindowSpacingEnabled)
import           XMonad.Layout.SubLayouts            (GroupMsg (MergeAll, UnMerge),
                                                      onGroup, pullGroup,
                                                      subLayout, toSubl)
import           XMonad.Layout.Tabbed                (Direction2D (D, L, R, U),
                                                      Theme (..), addTabs,
                                                      shrinkText)
import           XMonad.Layout.WindowNavigation      (windowNavigation)
import           XMonad.Prompt                       (XPConfig (..),
                                                      XPPosition (Top),
                                                      defaultXPKeymap,
                                                      deleteAllDuplicates)
import           XMonad.Prompt.ConfirmPrompt         (confirmPrompt)
import           XMonad.Prompt.FuzzyMatch            (fuzzyMatch, fuzzySort)
import           XMonad.Prompt.Man                   (manPrompt)
import           XMonad.Prompt.Shell                 (shellPrompt)
import qualified XMonad.StackSet                     as W
import           XMonad.Util.ClickableWorkspaces     (clickablePP)
import           XMonad.Util.Cursor                  (setDefaultCursor)
import           XMonad.Util.DynamicScratchpads      (makeDynamicSP,
                                                      spawnDynamicSP)
import           XMonad.Util.NamedScratchpad         (NamedScratchpad (NS),
                                                      customFloating,
                                                      namedScratchpadAction,
                                                      namedScratchpadManageHook,
                                                      scratchpadWorkspaceTag)
import           XMonad.Util.Run                     (safeSpawn, unsafeSpawn)
import           XMonad.Util.SpawnOnce               (spawnOnce)
import           XMonad.Util.Ungrab                  (unGrab)  


import           Control.Monad                       (liftM2)
import qualified Data.Map                            as M
import           Data.Monoid                         (All)
import           System.Exit                         (exitSuccess)
import           Theme.Theme                         (base00, base01, base04,
                                                      base05, base06, base07,
                                                      base08, basebg, basefg,
                                                      myFont, myFontGTK)

-- GLOBAL DEFINES

myTerminal = "alacritty"
myBrowser = "firefox"
myLauncer = "rofi -theme ~/.config/rofi/themes/"
