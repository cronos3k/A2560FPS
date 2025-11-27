# Install script for directory: D:/DEV/Abuse_2025/data

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/DEV/Abuse_2025/msvc-install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/abuse.lsp"
    "D:/DEV/Abuse_2025/data/edit.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./lisp" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/lisp/ant.lsp"
    "D:/DEV/Abuse_2025/data/lisp/chat.lsp"
    "D:/DEV/Abuse_2025/data/lisp/common.lsp"
    "D:/DEV/Abuse_2025/data/lisp/doors.lsp"
    "D:/DEV/Abuse_2025/data/lisp/duong.lsp"
    "D:/DEV/Abuse_2025/data/lisp/english.lsp"
    "D:/DEV/Abuse_2025/data/lisp/explo.lsp"
    "D:/DEV/Abuse_2025/data/lisp/flyer.lsp"
    "D:/DEV/Abuse_2025/data/lisp/french.lsp"
    "D:/DEV/Abuse_2025/data/lisp/gates.lsp"
    "D:/DEV/Abuse_2025/data/lisp/general.lsp"
    "D:/DEV/Abuse_2025/data/lisp/german.lsp"
    "D:/DEV/Abuse_2025/data/lisp/guns.lsp"
    "D:/DEV/Abuse_2025/data/lisp/input.lsp"
    "D:/DEV/Abuse_2025/data/lisp/jugger.lsp"
    "D:/DEV/Abuse_2025/data/lisp/ladder.lsp"
    "D:/DEV/Abuse_2025/data/lisp/language.lsp"
    "D:/DEV/Abuse_2025/data/lisp/light.lsp"
    "D:/DEV/Abuse_2025/data/lisp/options.lsp"
    "D:/DEV/Abuse_2025/data/lisp/people.lsp"
    "D:/DEV/Abuse_2025/data/lisp/platform.lsp"
    "D:/DEV/Abuse_2025/data/lisp/playwav.lsp"
    "D:/DEV/Abuse_2025/data/lisp/powerup.lsp"
    "D:/DEV/Abuse_2025/data/lisp/sfx.lsp"
    "D:/DEV/Abuse_2025/data/lisp/share.lsp"
    "D:/DEV/Abuse_2025/data/lisp/startup.lsp"
    "D:/DEV/Abuse_2025/data/lisp/switch.lsp"
    "D:/DEV/Abuse_2025/data/lisp/teleport.lsp"
    "D:/DEV/Abuse_2025/data/lisp/userfuns.lsp"
    "D:/DEV/Abuse_2025/data/lisp/version.lsp"
    "D:/DEV/Abuse_2025/data/lisp/weapons.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/aliens" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/aliens/alichars.lsp"
    "D:/DEV/Abuse_2025/data/addon/aliens/aliens.lsp"
    "D:/DEV/Abuse_2025/data/addon/aliens/astartup.lsp"
    "D:/DEV/Abuse_2025/data/addon/aliens/objects.lsp"
    "D:/DEV/Abuse_2025/data/addon/aliens/powerold.lsp"
    "D:/DEV/Abuse_2025/data/addon/aliens/powerups.lsp"
    "D:/DEV/Abuse_2025/data/addon/aliens/sfx.lsp"
    "D:/DEV/Abuse_2025/data/addon/aliens/tiles.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/bong" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/bong/bong.lsp"
    "D:/DEV/Abuse_2025/data/addon/bong/pong01.lvl"
    "D:/DEV/Abuse_2025/data/addon/bong/bong.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/claudio" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/claudio/claudio.lsp"
    "D:/DEV/Abuse_2025/data/addon/claudio/oldclaud.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/deathmat" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/deathmat/cur_lev.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/deathmat.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/dstartup.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/gamename.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/large.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/levelset.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/medium.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/small.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/username.lsp"
    "D:/DEV/Abuse_2025/data/addon/deathmat/version.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/example" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/example/example.lsp")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/leon" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/leon/4frabsdm.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/4frabs.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/leon.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/leon/lisp" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/deco.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/grenade.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/lmisc.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/lnant.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/nextlev3.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/nguns.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/njug.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/rain.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/slavesw.lsp"
    "D:/DEV/Abuse_2025/data/addon/leon/lisp/text.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/newart" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/newart/newart.lsp")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/pong" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/pong/common.lsp"
    "D:/DEV/Abuse_2025/data/addon/pong/pong.lsp"
    "D:/DEV/Abuse_2025/data/addon/pong/userfuns.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/twist" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/twist/f2ai.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/f2chars.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/twist.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/twist/lisp" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/ai.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/chars.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/chat.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/dray.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/english.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/f2ai.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/f2chars.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/light.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/mario.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/objects.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/options.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/players.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/sfx.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/startup.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/tiles.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/tints.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/title.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/userfuns.lsp"
    "D:/DEV/Abuse_2025/data/addon/twist/lisp/weapons.lsp"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./art" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/art/ant.spe"
    "D:/DEV/Abuse_2025/data/art/ball.spe"
    "D:/DEV/Abuse_2025/data/art/blowups.spe"
    "D:/DEV/Abuse_2025/data/art/bold.spe"
    "D:/DEV/Abuse_2025/data/art/boss.spe"
    "D:/DEV/Abuse_2025/data/art/cloud.spe"
    "D:/DEV/Abuse_2025/data/art/compass.spe"
    "D:/DEV/Abuse_2025/data/art/consfnt.spe"
    "D:/DEV/Abuse_2025/data/art/cop.spe"
    "D:/DEV/Abuse_2025/data/art/coptop.spe"
    "D:/DEV/Abuse_2025/data/art/credit.spe"
    "D:/DEV/Abuse_2025/data/art/dev.spe"
    "D:/DEV/Abuse_2025/data/art/door.spe"
    "D:/DEV/Abuse_2025/data/art/exp1.spe"
    "D:/DEV/Abuse_2025/data/art/flyer.spe"
    "D:/DEV/Abuse_2025/data/art/fonts.spe"
    "D:/DEV/Abuse_2025/data/art/frame.spe"
    "D:/DEV/Abuse_2025/data/art/gun2.spe"
    "D:/DEV/Abuse_2025/data/art/help.spe"
    "D:/DEV/Abuse_2025/data/art/icons.spe"
    "D:/DEV/Abuse_2025/data/art/jug.spe"
    "D:/DEV/Abuse_2025/data/art/keys.spe"
    "D:/DEV/Abuse_2025/data/art/letters.spe"
    "D:/DEV/Abuse_2025/data/art/loading.spe"
    "D:/DEV/Abuse_2025/data/art/misc.spe"
    "D:/DEV/Abuse_2025/data/art/missle.spe"
    "D:/DEV/Abuse_2025/data/art/mon_cfg.spe"
    "D:/DEV/Abuse_2025/data/art/pform.spe"
    "D:/DEV/Abuse_2025/data/art/rob1.spe"
    "D:/DEV/Abuse_2025/data/art/rob2.spe"
    "D:/DEV/Abuse_2025/data/art/screen11.spe"
    "D:/DEV/Abuse_2025/data/art/smoke.spe"
    "D:/DEV/Abuse_2025/data/art/statbar.spe"
    "D:/DEV/Abuse_2025/data/art/status.spe"
    "D:/DEV/Abuse_2025/data/art/title.spe"
    "D:/DEV/Abuse_2025/data/art/wait.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./art/back" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/art/back/alienb.spe"
    "D:/DEV/Abuse_2025/data/art/back/backgrnd.spe"
    "D:/DEV/Abuse_2025/data/art/back/cave.spe"
    "D:/DEV/Abuse_2025/data/art/back/city.spe"
    "D:/DEV/Abuse_2025/data/art/back/galien.spe"
    "D:/DEV/Abuse_2025/data/art/back/green2.spe"
    "D:/DEV/Abuse_2025/data/art/back/intro.spe"
    "D:/DEV/Abuse_2025/data/art/back/tech.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./art/chars" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/art/chars/ammo.spe"
    "D:/DEV/Abuse_2025/data/art/chars/block.spe"
    "D:/DEV/Abuse_2025/data/art/chars/concus.spe"
    "D:/DEV/Abuse_2025/data/art/chars/door.spe"
    "D:/DEV/Abuse_2025/data/art/chars/lavap.spe"
    "D:/DEV/Abuse_2025/data/art/chars/lava.spe"
    "D:/DEV/Abuse_2025/data/art/chars/lightin.spe"
    "D:/DEV/Abuse_2025/data/art/chars/mine.spe"
    "D:/DEV/Abuse_2025/data/art/chars/platform.spe"
    "D:/DEV/Abuse_2025/data/art/chars/push.spe"
    "D:/DEV/Abuse_2025/data/art/chars/sect.spe"
    "D:/DEV/Abuse_2025/data/art/chars/step.spe"
    "D:/DEV/Abuse_2025/data/art/chars/tdoor.spe"
    "D:/DEV/Abuse_2025/data/art/chars/teleport.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./art/fore" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/art/fore/alien.spe"
    "D:/DEV/Abuse_2025/data/art/fore/cave.spe"
    "D:/DEV/Abuse_2025/data/art/fore/endgame.spe"
    "D:/DEV/Abuse_2025/data/art/fore/foregrnd.spe"
    "D:/DEV/Abuse_2025/data/art/fore/techno2.spe"
    "D:/DEV/Abuse_2025/data/art/fore/techno3.spe"
    "D:/DEV/Abuse_2025/data/art/fore/techno4.spe"
    "D:/DEV/Abuse_2025/data/art/fore/techno.spe"
    "D:/DEV/Abuse_2025/data/art/fore/trees2.spe"
    "D:/DEV/Abuse_2025/data/art/fore/trees.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./art/tints/ant" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/art/tints/ant/blue.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/brown.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/darkblue.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/egg.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/evil.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/gray.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/green.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/mustard.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/orange.spe"
    "D:/DEV/Abuse_2025/data/art/tints/ant/yellow.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./art/tints/cop" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/art/tints/cop/africa.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/blue.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/bright.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/darkblue.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/fire.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/gold.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/gray.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/land.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/olive.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/pinkish.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/purple.spe"
    "D:/DEV/Abuse_2025/data/art/tints/cop/yellow.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./art/tints/guns" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/art/tints/guns/blue.spe"
    "D:/DEV/Abuse_2025/data/art/tints/guns/green.spe"
    "D:/DEV/Abuse_2025/data/art/tints/guns/orange.spe"
    "D:/DEV/Abuse_2025/data/art/tints/guns/redish.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/aliens" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/aliens/aliens.spe"
    "D:/DEV/Abuse_2025/data/addon/aliens/bactiles.spe"
    "D:/DEV/Abuse_2025/data/addon/aliens/fortiles.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/bong" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/bong/bong.spe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/claudio" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/claudio/antship.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/bigexp.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/deepw1.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/deepw2.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/droid.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/extiles.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/fire.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/lamp.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/lava2.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/mypanels.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/nplatfor.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal21.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal2.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal5.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal81f.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal81.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal82f.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal82.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/pal90.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/rob2.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/skull.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/spaced.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/spaceh.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/spacymed.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/spacytdm.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/sswitch.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/t_lamp.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/trex1.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/t_skull.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/t_space.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/t_trex.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/t_water.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/umbrel3.spe"
    "D:/DEV/Abuse_2025/data/addon/claudio/watem.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/example" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/example/example.spe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/leon" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/leon/gray.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/level00.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/level01.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/level02.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/lmisc.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/lnant.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/lnewft2.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/lnewft.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/rain-old.spe"
    "D:/DEV/Abuse_2025/data/addon/leon/rain.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/newart" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/newart/blcave.spe"
    "D:/DEV/Abuse_2025/data/addon/newart/final.spe"
    "D:/DEV/Abuse_2025/data/addon/newart/frabs_1.spe"
    "D:/DEV/Abuse_2025/data/addon/newart/frabs_2.spe"
    "D:/DEV/Abuse_2025/data/addon/newart/frbsblue.spe"
    "D:/DEV/Abuse_2025/data/addon/newart/mtile.spe"
    "D:/DEV/Abuse_2025/data/addon/newart/space.spe"
    "D:/DEV/Abuse_2025/data/addon/newart/stones.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/pong/levels" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx01.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx02.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx03.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx04.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx05.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx06.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx07.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx08.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx09.spe"
    "D:/DEV/Abuse_2025/data/addon/pong/levels/pongx10.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/pong" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/pong/pong.spe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/bgames" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/bgames/chess.spe"
    "D:/DEV/Abuse_2025/data/addon/bgames/connect4.lsp"
    "D:/DEV/Abuse_2025/data/addon/bgames/othello.lsp"
    "D:/DEV/Abuse_2025/data/addon/bgames/chess.lsp"
    "D:/DEV/Abuse_2025/data/addon/bgames/bgames.lsp"
    "D:/DEV/Abuse_2025/data/addon/bgames/checkers.lvl"
    "D:/DEV/Abuse_2025/data/addon/bgames/othello.lvl"
    "D:/DEV/Abuse_2025/data/addon/bgames/connect4.lvl"
    "D:/DEV/Abuse_2025/data/addon/bgames/chess.lvl"
    "D:/DEV/Abuse_2025/data/addon/bgames/checkers.lsp"
    "D:/DEV/Abuse_2025/data/addon/bgames/pong.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/quest" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/quest/quest.lsp"
    "D:/DEV/Abuse_2025/data/addon/quest/quest.spe"
    "D:/DEV/Abuse_2025/data/addon/quest/main_map.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/diffsens" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/diffsens/diffsens.lsp"
    "D:/DEV/Abuse_2025/data/addon/diffsens/diffsens.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/nextlev2" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/nextlev2/nextlev2.lsp")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/twist/art" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/twist/art/cgc.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/dray.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/fire.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/lavap.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/legs.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/mario.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/mtile.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/obj.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/palette.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/robs.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/title.spe"
    "D:/DEV/Abuse_2025/data/addon/twist/art/weapons.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./levels" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/levels/level00.spe"
    "D:/DEV/Abuse_2025/data/levels/level01.spe"
    "D:/DEV/Abuse_2025/data/levels/level02.spe"
    "D:/DEV/Abuse_2025/data/levels/level03.spe"
    "D:/DEV/Abuse_2025/data/levels/level04.spe"
    "D:/DEV/Abuse_2025/data/levels/level05.spe"
    "D:/DEV/Abuse_2025/data/levels/level06.spe"
    "D:/DEV/Abuse_2025/data/levels/level07.spe"
    "D:/DEV/Abuse_2025/data/levels/level08.spe"
    "D:/DEV/Abuse_2025/data/levels/level09.spe"
    "D:/DEV/Abuse_2025/data/levels/level10.spe"
    "D:/DEV/Abuse_2025/data/levels/level11.spe"
    "D:/DEV/Abuse_2025/data/levels/level12.spe"
    "D:/DEV/Abuse_2025/data/levels/level13.spe"
    "D:/DEV/Abuse_2025/data/levels/level14.spe"
    "D:/DEV/Abuse_2025/data/levels/level15.spe"
    "D:/DEV/Abuse_2025/data/levels/level16.spe"
    "D:/DEV/Abuse_2025/data/levels/level17.spe"
    "D:/DEV/Abuse_2025/data/levels/level18.spe"
    "D:/DEV/Abuse_2025/data/levels/level19.spe"
    "D:/DEV/Abuse_2025/data/levels/level20.spe"
    "D:/DEV/Abuse_2025/data/levels/level21.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./levels" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/levels/frabs00.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs01.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs02.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs03.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs04.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs05.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs06.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs07.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs08.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs09.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs10.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs11.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs12.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs13.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs14.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs15.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs17.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs18.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs19.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs20.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs21.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs30.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs70.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs71.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs72.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs73.spe"
    "D:/DEV/Abuse_2025/data/levels/frabs74.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./levels/mac" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/levels/mac/demo1.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/demo2.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/demo4.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/demo5.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/end.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/flevel12.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level00.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level01.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level02.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level05.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level07.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level08.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level09.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level12.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level13.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level15.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level18.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level19.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/level20.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/levels.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/netreg1.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/netshar1.spe"
    "D:/DEV/Abuse_2025/data/levels/mac/netshar2.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./netlevel" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/netlevel/00dm.spe"
    "D:/DEV/Abuse_2025/data/netlevel/2play1.spe"
    "D:/DEV/Abuse_2025/data/netlevel/2play2.spe"
    "D:/DEV/Abuse_2025/data/netlevel/2play3.spe"
    "D:/DEV/Abuse_2025/data/netlevel/2play4.spe"
    "D:/DEV/Abuse_2025/data/netlevel/4play1.spe"
    "D:/DEV/Abuse_2025/data/netlevel/4play2.spe"
    "D:/DEV/Abuse_2025/data/netlevel/4play3.spe"
    "D:/DEV/Abuse_2025/data/netlevel/4play4.spe"
    "D:/DEV/Abuse_2025/data/netlevel/8play1.spe"
    "D:/DEV/Abuse_2025/data/netlevel/8play2.spe"
    "D:/DEV/Abuse_2025/data/netlevel/8play3.spe"
    "D:/DEV/Abuse_2025/data/netlevel/8play4.spe"
    "D:/DEV/Abuse_2025/data/netlevel/alitlhot.spe"
    "D:/DEV/Abuse_2025/data/netlevel/aquarius.spe"
    "D:/DEV/Abuse_2025/data/netlevel/bugsmed.spe"
    "D:/DEV/Abuse_2025/data/netlevel/bugssml.spe"
    "D:/DEV/Abuse_2025/data/netlevel/bugs.spe"
    "D:/DEV/Abuse_2025/data/netlevel/cistern.spe"
    "D:/DEV/Abuse_2025/data/netlevel/getcross.spe"
    "D:/DEV/Abuse_2025/data/netlevel/jdm3.spe"
    "D:/DEV/Abuse_2025/data/netlevel/kotcross.spe"
    "D:/DEV/Abuse_2025/data/netlevel/laazrckt.spe"
    "D:/DEV/Abuse_2025/data/netlevel/limeston.spe"
    "D:/DEV/Abuse_2025/data/netlevel/madrace.spe"
    "D:/DEV/Abuse_2025/data/netlevel/occult.spe"
    "D:/DEV/Abuse_2025/data/netlevel/redgrndm.spe"
    "D:/DEV/Abuse_2025/data/netlevel/ruins.spe"
    "D:/DEV/Abuse_2025/data/netlevel/spacymed.spe"
    "D:/DEV/Abuse_2025/data/netlevel/spacytdm.spe"
    "D:/DEV/Abuse_2025/data/netlevel/teardrop.spe"
    "D:/DEV/Abuse_2025/data/netlevel/treesmal.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./levels/mac" TYPE FILE FILES "D:/DEV/Abuse_2025/data/levels/mac/pong.lvl")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/bong" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/bong/bong.lsp"
    "D:/DEV/Abuse_2025/data/addon/bong/pong01.lvl"
    "D:/DEV/Abuse_2025/data/addon/bong/bong.spe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/example" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/example/example.lvl")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/pong" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/pong/pong01.lvl")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/twist/levels" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/twist/levels/l01s01.lvl"
    "D:/DEV/Abuse_2025/data/addon/twist/levels/l01s02.lvl"
    "D:/DEV/Abuse_2025/data/addon/twist/levels/l01s03.lvl"
    "D:/DEV/Abuse_2025/data/addon/twist/levels/l01s04.lvl"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./levels" TYPE FILE FILES "D:/DEV/Abuse_2025/data/levels/demo1.dat")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./levels/mac" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/levels/mac/demo1.dat"
    "D:/DEV/Abuse_2025/data/levels/mac/demo2.dat"
    "D:/DEV/Abuse_2025/data/levels/mac/demo3.dat"
    "D:/DEV/Abuse_2025/data/levels/mac/demo4.dat"
    "D:/DEV/Abuse_2025/data/levels/mac/demo5.dat"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/aliens" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/aliens/aliens.txt"
    "D:/DEV/Abuse_2025/data/addon/aliens/readme.txt"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/claudio" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/claudio/palettes.txt")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/leon" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/leon/leon.txt")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/newart" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/newart/tiledoc.txt")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/pong" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/pong/pong.txt")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/twist" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/twist/readme.txt")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./soundfonts" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/soundfonts/AWE64 Gold Presets.sf2"
    "D:/DEV/Abuse_2025/data/soundfonts/Roland SC-55 Presets.sf2"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./music" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/music/intro.hmi"
    "D:/DEV/Abuse_2025/data/music/victory.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse00.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse01.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse02.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse03.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse04.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse06.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse08.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse09.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse11.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse13.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse15.hmi"
    "D:/DEV/Abuse_2025/data/music/abuse17.hmi"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./sfx" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/sfx/adie02.wav"
    "D:/DEV/Abuse_2025/data/sfx/adie03.wav"
    "D:/DEV/Abuse_2025/data/sfx/adie05.wav"
    "D:/DEV/Abuse_2025/data/sfx/ahit01.wav"
    "D:/DEV/Abuse_2025/data/sfx/aland01.wav"
    "D:/DEV/Abuse_2025/data/sfx/alien01.wav"
    "D:/DEV/Abuse_2025/data/sfx/amb07.wav"
    "D:/DEV/Abuse_2025/data/sfx/amb10.wav"
    "D:/DEV/Abuse_2025/data/sfx/amb11.wav"
    "D:/DEV/Abuse_2025/data/sfx/amb13.wav"
    "D:/DEV/Abuse_2025/data/sfx/amb15.wav"
    "D:/DEV/Abuse_2025/data/sfx/amb16.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambcave1.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambcave2.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambcave3.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambcave4.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambfrst2.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambtech1.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambtech2.wav"
    "D:/DEV/Abuse_2025/data/sfx/ambtech3.wav"
    "D:/DEV/Abuse_2025/data/sfx/ammo01.wav"
    "D:/DEV/Abuse_2025/data/sfx/ammo02.wav"
    "D:/DEV/Abuse_2025/data/sfx/apain01.wav"
    "D:/DEV/Abuse_2025/data/sfx/aslash01.wav"
    "D:/DEV/Abuse_2025/data/sfx/ball01.wav"
    "D:/DEV/Abuse_2025/data/sfx/blkfoot4.wav"
    "D:/DEV/Abuse_2025/data/sfx/button02.wav"
    "D:/DEV/Abuse_2025/data/sfx/cleaner.wav"
    "D:/DEV/Abuse_2025/data/sfx/crmble01.wav"
    "D:/DEV/Abuse_2025/data/sfx/delobj01.wav"
    "D:/DEV/Abuse_2025/data/sfx/doorup01.wav"
    "D:/DEV/Abuse_2025/data/sfx/doorup02.wav"
    "D:/DEV/Abuse_2025/data/sfx/eleacc01.wav"
    "D:/DEV/Abuse_2025/data/sfx/elect02.wav"
    "D:/DEV/Abuse_2025/data/sfx/eledec01.wav"
    "D:/DEV/Abuse_2025/data/sfx/endlvl02.wav"
    "D:/DEV/Abuse_2025/data/sfx/explod02.wav"
    "D:/DEV/Abuse_2025/data/sfx/fadeon01.wav"
    "D:/DEV/Abuse_2025/data/sfx/firebmb1.wav"
    "D:/DEV/Abuse_2025/data/sfx/flamloop.wav"
    "D:/DEV/Abuse_2025/data/sfx/fly03.wav"
    "D:/DEV/Abuse_2025/data/sfx/force01.wav"
    "D:/DEV/Abuse_2025/data/sfx/grenad01.wav"
    "D:/DEV/Abuse_2025/data/sfx/health01.wav"
    "D:/DEV/Abuse_2025/data/sfx/lasrmis2.wav"
    "D:/DEV/Abuse_2025/data/sfx/lava01.wav"
    "D:/DEV/Abuse_2025/data/sfx/link01.wav"
    "D:/DEV/Abuse_2025/data/sfx/logo09.wav"
    "D:/DEV/Abuse_2025/data/sfx/metal.wav"
    "D:/DEV/Abuse_2025/data/sfx/mghit01.wav"
    "D:/DEV/Abuse_2025/data/sfx/mghit02.wav"
    "D:/DEV/Abuse_2025/data/sfx/pland01.wav"
    "D:/DEV/Abuse_2025/data/sfx/plasma02.wav"
    "D:/DEV/Abuse_2025/data/sfx/plasma03.wav"
    "D:/DEV/Abuse_2025/data/sfx/pldeth02.wav"
    "D:/DEV/Abuse_2025/data/sfx/pldeth04.wav"
    "D:/DEV/Abuse_2025/data/sfx/pldeth05.wav"
    "D:/DEV/Abuse_2025/data/sfx/pldeth07.wav"
    "D:/DEV/Abuse_2025/data/sfx/plpain01.wav"
    "D:/DEV/Abuse_2025/data/sfx/plpain02.wav"
    "D:/DEV/Abuse_2025/data/sfx/plpain04.wav"
    "D:/DEV/Abuse_2025/data/sfx/plpain10.wav"
    "D:/DEV/Abuse_2025/data/sfx/poof05.wav"
    "D:/DEV/Abuse_2025/data/sfx/poof06.wav"
    "D:/DEV/Abuse_2025/data/sfx/robot02.wav"
    "D:/DEV/Abuse_2025/data/sfx/rocket02.wav"
    "D:/DEV/Abuse_2025/data/sfx/save01.wav"
    "D:/DEV/Abuse_2025/data/sfx/save05.wav"
    "D:/DEV/Abuse_2025/data/sfx/scream02.wav"
    "D:/DEV/Abuse_2025/data/sfx/scream03.wav"
    "D:/DEV/Abuse_2025/data/sfx/scream08.wav"
    "D:/DEV/Abuse_2025/data/sfx/shotgn31.wav"
    "D:/DEV/Abuse_2025/data/sfx/speed02.wav"
    "D:/DEV/Abuse_2025/data/sfx/spring03.wav"
    "D:/DEV/Abuse_2025/data/sfx/swish01.wav"
    "D:/DEV/Abuse_2025/data/sfx/switch01.wav"
    "D:/DEV/Abuse_2025/data/sfx/telept01.wav"
    "D:/DEV/Abuse_2025/data/sfx/throw01.wav"
    "D:/DEV/Abuse_2025/data/sfx/timerfst.wav"
    "D:/DEV/Abuse_2025/data/sfx/zap2.wav"
    "D:/DEV/Abuse_2025/data/sfx/zap3.wav"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./sfx/voice" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/sfx/voice/aimsave.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/ammosave.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/ladder_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/ownsave.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/platfo_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/poweru_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/savesave.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/spaceb_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/spcbr1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/spcbr2.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/starts_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/statio_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/switch_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/switch_2.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/telepo_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/wallss_1.wav"
    "D:/DEV/Abuse_2025/data/sfx/voice/weapon_1.wav"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/aliens" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/aliens/adie01.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/adie02.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/adie03.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/adie05.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/ahit01.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/alien01.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/altaunt.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/aslash01.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/egghatch.wav"
    "D:/DEV/Abuse_2025/data/addon/aliens/jarbreak.wav"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/claudio" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/claudio/aship.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/drill.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/fire.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/glass1.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/sewers.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/skull.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/spaceo.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/trex1.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/trex2.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/unhealth.wav"
    "D:/DEV/Abuse_2025/data/addon/claudio/wfall.wav"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/leon/sfx" TYPE FILE FILES
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/ambship1.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/ambship2.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/gren5.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/gren6.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/rain2.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/rain3.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/rain4.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/rain.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/thunder2.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/thunder3.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/thunder4.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/thunder5.wav"
    "D:/DEV/Abuse_2025/data/addon/leon/sfx/thunder.wav"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/./addon/twist/sfx" TYPE FILE FILES "D:/DEV/Abuse_2025/data/addon/twist/sfx/dray.wav")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "D:/DEV/Abuse_2025/msvc-build/data/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
