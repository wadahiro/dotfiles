#!/bin/bash

options=(

    # mode
    -modi              'clipboard:~/bin/greenclip print'
    -show              'clipboard'

    # Font
    -font              'Source Han Code JP 24'

    # Window
    -width             '100'
    -padding           '80'
    -lines             '8'
    -color-enabled     'true'
    -color-window      '#111111,#111111,#268bd2'
    -color-normal      '#111111,#ffffff,#111111,#268bd2,#ffffff'
    -color-active      '#111111,#268bd2,#111111,#268bd2,#000022'
    -color-urgent      '#111111,#f3843d,#111111,#268bd2,#ffc39c'

    -separator-style   'none'
    -opacity           '80'
    -hide-scrollbar

    # Keybindings
    -kb-cancel         'Escape,Control+g,Control+bracketleft,Control+c'
    -kb-mode-next      'Shift+Right,Control+Tab,Control+i'

)

rofi "${@}" "${options[@]}"
