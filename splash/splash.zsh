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
#   SPLASH_SCARF=12-13              art rows whose first word is a scarf tail:
#                                   it flutters in the breeze (unset = static)
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
    '=== === = == = = = = =  = SS_SSFF|||+|'
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
  local -a moon=(
    '  .-.  '
    ' (   ) '
    "  '-'  "
  )
  # A distant ridge along the bottom: the planes are high over enemy lines.
  local -a ridge=(
    '    .--.            .-.               .--.              .-.             .--.            .-.'
    "_.-'    '-.______.-'   '-._________.-'    '-.________.-'   '-._______.-'    '-.______.-'   '-.__"
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

  # ---- Optional fluttering scarf ------------------------------------------
  # SPLASH_SCARF=12-13 (or "12 13"): rows whose first word is the scarf tail.
  local -a scarfrows
  local spec lo hi nr
  for spec in ${=SPLASH_SCARF}; do
    if [[ $spec == *-* ]]; then
      lo=${spec%%-*}; hi=${spec#*-}
      for (( nr = lo; nr <= hi; nr++ )); do
        (( nr >= 1 && nr <= $#art )) && scarfrows+=($nr)
      done
    else
      (( spec >= 1 && spec <= $#art )) && scarfrows+=($spec)
    fi
  done

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

  # _splash_prop <frame> <row> <col> -- the nose blade flips between '/' (upper)
  # and '\' (lower), so the '/' really does go away on the other beat.
  _splash_prop() {
    if (( ($1 / 2) % 2 )); then
      printf '\e[%d;%dH \e[%d;%dH\\' $2 $3 $(( $2 + 1 )) $3
    else
      printf '\e[%d;%dH/\e[%d;%dH ' $2 $3 $(( $2 + 1 )) $3
    fi
  }

  # _splash_scarf <frame> -- ripple the scarf: the tail's leading edge licks
  # out and back while its other end stays anchored.
  _splash_scarf() {
    local n=$(( $1 % 4 )) row line rest first after padstr d k rep i=0
    local -a wave=( 0 -1 0 1 )
    for row in $scarfrows; do
      line=$art[row]
      [[ -n $line ]] || { (( i++ )); continue; }
      local lead=${line%%[^ ]*}      # leading spaces
      local pad=$#lead
      rest=${line#$lead}
      first=${rest%% *}              # the scarf tail
      after=${rest#$first}
      d=${wave[n+1]}
      (( i % 2 )) && d=$(( -d ))     # rows ripple in opposite directions
      if (( d > 0 )); then
        first=${first[d+1,-1]}       # tip retracts, the rest stays put
        (( pad += d ))
      elif (( d < 0 )); then
        rep=''
        for (( k = 0; k < -d; k++ )); do rep+=$first[1]; done
        first=$rep$first             # tip billows out to the left
        (( pad += d ))
      fi
      (( pad < 0 )) && pad=0
      printf -v padstr '%*s' $pad ''
      printf '\e[%d;1H%s%s%s%s%s' $row "$(_splash_artcolor $row)" \
        "$padstr" "$first" "$after" "$N"
      (( i++ ))
    done
  }

  # _splash_cloud <frame> -- the two clouds drift upwind, against the planes.
  # Each keeps to its own lane so it never crosses an aircraft.
  _splash_cloud() {
    local n=$1 i cx rr
    for (( i = 1; i <= $#cloudrow; i++ )); do
      cx=$(( cloudhi[i] - (n / 8) % (cloudhi[i] - cloudlo[i] + 1) ))
      if (( ${cloudprev[i]:-0} )); then
        for (( rr = cloudrow[i]; rr < cloudrow[i] + $#cloud; rr++ )); do
          printf '\e[%d;%dH%*s' $rr ${cloudprev[i]} 12 ''
        done
      fi
      cloudprev[i]=$cx
      _splash_paint $cloudrow[i] $cx "$W" "${cloud[@]}"
    done
  }

  # _splash_flak <frame> -- anti-aircraft fire: each burst blooms from a
  # spark into a ring of fragments, then fades. The sky is restored behind it
  # first so the fragments don't smear.
  _splash_flak() {
    local n=$1 i r c rr dx dy rad col ch
    local -a fcol=( $'\e[38;5;220m' $'\e[38;5;214m' $'\e[38;5;208m' $'\e[38;5;240m' )
    for (( i = 1; i <= $#flakrow; i++ )); do
      r=${flakrow[i]} c=${flakcol[i]}
      for (( rr = r - 3; rr <= r + 3; rr++ )); do
        printf '\e[%d;%dH%*s' $rr $(( c - 3 )) 7 ''
      done
      rad=$(( ((n + i * 4) % 10 - 2) / 2 ))
      (( rad < 0 || rad > 2 )) && continue
      col=${fcol[rad+1]}
      ch=.
      (( rad == 0 )) && ch='*'
      for (( dy = -rad; dy <= rad; dy++ )); do
        for (( dx = -rad; dx <= rad; dx++ )); do
          (( dy == -rad || dy == rad || dx == -rad || dx == rad )) || continue
          printf '\e[%d;%dH%s%s%s' $(( r + dy )) $(( c + dx )) "$col" "$ch" "$N"
        done
      done
    done
  }

  # _splash_planes <frame> -- the escorts bob, the burning plane's prop turns.
  _splash_planes() {
    local n=$1
    if (( (n / 2) % 2 )); then
      _splash_paint 2 $(( x + 62 )) "" "${planeB[@]}"
      _splash_paint 7 $(( x + 46 )) "" "${planeA[@]}"
    else
      _splash_paint 2 $(( x + 62 )) "" "${planeA[@]}"
      _splash_paint 7 $(( x + 46 )) "" "${planeB[@]}"
    fi
    _splash_paint 14 $(( x + 2 )) "" "${burning[@]}"
    _splash_prop $n 17 $(( x + 40 ))   # burning plane: nose blade
  }

  printf '\e[?25l'
  _splash_stop=0
  trap '_splash_stop=1' INT        # unwind at the next loop check
  clear

  # Art (drawn as-is, so codes inside the file are kept)
  local i
  for (( i = 1; i <= $#art; i++ )); do
    printf '\e[%d;1H%s%s%s' $i "$(_splash_artcolor $i)" "$art[i]" "$N"
  done

  # Scenery
  local srow=$(( $#art + 2 > 24 ? $#art + 2 : 24 ))
  local -a flakrow=( 4 11 )
  local -a flakcol=( $(( x + 50 )) $(( x + 66 )) )
  # Cloud lanes, between the aircraft.
  local -a cloudrow=( 3 15 )
  local -a cloudlo=( $(( x + 16 )) $(( x + 44 )) )
  local -a cloudhi=( $(( x + 30 )) $(( COLUMNS - 13 )) )
  local -a cloudprev
  _splash_paint  1 $(( x + 6 )) $'\e[38;5;253m' "${moon[@]}"
  _splash_cloud 0

  # The ridge is trimmed to whatever width is left of the right margin.
  local rw=$(( COLUMNS - x - 3 ))
  local -a ridgefit
  local rline
  for rline in "${ridge[@]}"; do ridgefit+=("${rline[1,rw]}"); done
  _splash_paint 22 $(( x + 2 )) $'\e[38;5;239m' "${ridgefit[@]}"

  # A scatter of stars in the upper sky, dim on purpose. Positions are random
  # but stay out of the moon and the flak bursts, which repaint their own patch.
  local -a dot=( '.' '·' '+' '*' )
  local -a dim=( $'\e[38;5;59m' $'\e[38;5;102m' $'\e[38;5;145m' $'\e[38;5;188m' )
  local k j sr sc ok seed=$(( RANDOM * 32768 + RANDOM ))
  for (( k = 0; k < 24; k++ )); do
    seed=$(( (seed * 1103515245 + 12345) % 2147483648 ))
    sr=$(( seed % 12 + 1 ))
    seed=$(( (seed * 1103515245 + 12345) % 2147483648 ))
    sc=$(( seed % ( COLUMNS - x - 10 ) + x + 5 ))
    ok=1
    (( sr >= 1 && sr <= 4 && sc >= x + 5 && sc <= x + 14 )) && ok=0
    (( sr >= cloudrow[1] && sr < cloudrow[1] + $#cloud &&
       sc >= cloudlo[1] && sc <= cloudhi[1] + 11 )) && ok=0
    for (( j = 1; j <= $#flakrow; j++ )); do
      (( sr >= flakrow[j] - 3 && sr <= flakrow[j] + 3 &&
         sc >= flakcol[j] - 3 && sc <= flakcol[j] + 3 )) && ok=0
    done
    (( ok )) || continue
    printf '\e[%d;%dH%s%s%s' $sr $sc "${dim[RANDOM % 4 + 1]}" "${dot[RANDOM % 4 + 1]}" "$N"
  done
  printf '\e[%d;4H%sSQUADRON READY%s  %s%s@%s  ·  %s%s' $srow \
    "$R" "$N" "$G" "${USER:-$USERNAME}" "${HOST%%.*}" "$(date '+%a %d %b %Y, %H:%M')" "$N"

  # Planes
  local f key
  if [[ ${SPLASH_ANIMATE:-1} == 0 ]]; then
    _splash_planes 0
    _splash_scarf 0
  else
    for (( f = 0; ; f++ )); do
      (( _splash_stop )) && break
      _splash_flak $f
      _splash_planes $f
      _splash_cloud $f
      _splash_scarf $f
      read -s -k 1 -t 0.08 key && break
    done
  fi

  trap - INT
  unset _splash_stop
  printf '\e[?25h\e[%d;1H' $(( srow + 2 ))
  unfunction _splash_paint _splash_artcolor _splash_prop _splash_planes \
    _splash_scarf _splash_flak _splash_cloud
}

