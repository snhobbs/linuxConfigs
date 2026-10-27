#!/usr/bin/env zsh
# WWI dogfight splash screen for zsh.
#   Add to the end of ~/.zshrc:   source ~/splash.zsh
#
# Options (set them in ~/.zshrc *before* the source line):
#   SPLASH_ART=~/.splash_art.txt    ASCII art shown left of the planes
#                                   (default ~/.splash_art.txt; missing file = no art)
#   SPLASH_ART_COLORS=(1-6:255 20-:9)
#                                   colour rows of the art: <from>-<to>:<256-colour>,
#                                   open-ended ranges allowed ("20-" = row 20 to end).
#                                   ANSI colour codes inside the file also work.
#   SPLASH_PAD=3                    gap between the art and the planes
#   SPLASH_ANIMATE=0                static screen, no animation
# Any key skips the animation.

[[ -o interactive ]] || return
(( COLUMNS >= 78 && LINES >= 24 )) || return

() {
  emulate -L zsh
  setopt extendedglob

  local N=$'\e[0m' W=$'\e[38;5;255m' R=$'\e[38;5;196m'
  local O=$'\e[38;5;208m' G=$'\e[38;5;244m' D=$'\e[38;5;238m'
  local -a FIRE=($'\e[38;5;196m' $'\e[38;5;202m' $'\e[38;5;208m' $'\e[38;5;214m' $'\e[38;5;220m')
  local -a SMOKE=($'\e[38;5;240m' $'\e[38;5;244m' $'\e[38;5;248m')
  local flames='<<<<(' smoke='~~~~-'

  # Two wing positions so the planes bob as they fly.
  local -a planeA=(
    '       ___   '
    '      ||| |  '
    ' _    |||+|  '
    '\_`----;| |/ '
    '/_,----:| |  '
    '      |||+|  '
    '      |||_|  '
  )
  local -a planeB=(
    '       ___   '
    '      ||| |  '
    ' _    |||+|  '
    '\_`----;| |  '
    '/_,----:| |\ '
    '      |||+|  '
    '      |||_|  '
  )
  # S = smoke, F = flame, = = streak; re-rolled every frame so it flickers.
  local -a burning=(
    '                                  ___'
    '                          SSSSFFF||| |'
    '=== === = == = = = = =  = SSSSSFF|||+|'
    '                      SSSSS\_`----;| |/'
    '                      SSSSS/_,----:| |'
    '                          SSSSSFF|||+|'
    '                          SSSSFFF|||_|'
  )
  local -a cloud=(
    '    .--.'
    ' .-(    ).'
    '(___.__)__)'
  )

  # ---- Optional art on the left -------------------------------------------
  local artfile=${SPLASH_ART:-$HOME/.splash_art.txt}
  local -a art
  local x=0 artw=0 line plain
  if [[ -r $artfile ]]; then
    art=( "${(@f)$(<$artfile)}" )
    for line in "${art[@]}"; do
      plain=${line//$'\e'\[[0-9;]#m/}          # ignore colour codes when measuring
      (( ${(m)#plain} > artw )) && artw=${(m)#plain}
    done
    x=$(( artw + ${SPLASH_PAD:-3} ))
    # Not enough room for art + planes: show the planes only.
    if (( COLUMNS < x + 75 || LINES < $#art + 3 )); then
      art=(); x=0
    fi
  fi

  # Colour for art row $1, from SPLASH_ART_COLORS.
  _splash_artcolor() {
    local spec range lo hi
    for spec in $SPLASH_ART_COLORS; do
      range=${spec%%:*}
      lo=${range%%-*}; hi=${range#*-}
      [[ $range == *-* ]] || hi=$lo
      (( $1 >= ${lo:-1} && $1 <= ${hi:-999999} )) && { print -n $'\e[38;5;'${spec##*:}m; return; }
    done
  }

  # _splash_paint <row> <col> <base color> <lines...>
  _splash_paint() {
    local r=$1 c=$2 base=$3; shift 3
    local line out ch k i=0
    for line in "$@"; do
      out=$base
      for (( k = 1; k <= $#line; k++ )); do
        ch=$line[k]
        case $ch in
          '+') out+="$R$ch$N$base" ;;
          S) out+="${SMOKE[RANDOM % 3 + 1]}${smoke[RANDOM % 5 + 1]}$N$base" ;;
          F) out+="${FIRE[RANDOM % 5 + 1]}${flames[RANDOM % 5 + 1]}$N$base" ;;
          '=') out+="$D=$N$base" ;;
          *) out+=$ch ;;
        esac
      done
      printf '\e[%d;%dH%s%s' $(( r + i )) $c "$out" "$N"
      (( i++ ))
    done
  }

  printf '\e[?25l'
  clear

  # Art (drawn as-is, so codes inside the file are kept)
  local i
  for (( i = 1; i <= $#art; i++ )); do
    printf '\e[%d;1H%s%s%s' $i "$(_splash_artcolor $i)" "$art[i]" "$N"
  done

  # Scenery
  local srow=$(( $#art + 2 > 22 ? $#art + 2 : 22 ))
  _splash_paint  3 $(( x + 22 )) "$W" "${cloud[@]}"
  _splash_paint 15 $(( x + 60 )) "$W" "${cloud[@]}"
  printf '\e[2;%dH%s*%s'    $(( x + 46 )) "$O" "$N"
  printf '\e[11;%dH%s( )%s' $(( x + 30 )) "$O" "$N"
  printf '\e[20;%dH%s*%s'   $(( x + 66 )) "$O" "$N"
  printf '\e[%d;4H%sSQUADRON READY%s  %s%s@%s  ·  %s%s' $srow \
    "$R" "$N" "$G" "$USERNAME" "${HOST%%.*}" "$(date '+%a %d %b %Y, %H:%M')" "$N"

  # Planes
  local f frames=18 key
  [[ ${SPLASH_ANIMATE:-1} == 0 ]] && frames=1
  for (( f = 0; f < frames; f++ )); do
    if (( (f / 2) % 2 )); then
      _splash_paint 2 $(( x + 62 )) "" "${planeB[@]}"
      _splash_paint 7 $(( x + 46 )) "" "${planeA[@]}"
    else
      _splash_paint 2 $(( x + 62 )) "" "${planeA[@]}"
      _splash_paint 7 $(( x + 46 )) "" "${planeB[@]}"
    fi
    _splash_paint 14 $(( x + 2 )) "" "${burning[@]}"
    (( f < frames - 1 )) || break
    read -s -k 1 -t 0.08 key && break
  done

  printf '\e[?25h\e[%d;1H' $(( srow + 2 ))
  unfunction _splash_paint _splash_artcolor
}

