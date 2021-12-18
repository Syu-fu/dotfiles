#--------------------------------------------------------------#
##          Plugins                                           ##
#--------------------------------------------------------------#

set-option -g @plugin "tmux-plugins/tpm"
set-option -g @plugin "reireias/tmux-themepack"
set -g @plugin 'sainnhe/tmux-fzf'

#--------------------------------------------------------------#
##          Disable Plugins                                   ##
#--------------------------------------------------------------#

## Disabled for customize coloring
#set-option -g @plugin "jooize/tmux-powerline-theme"
## Disabled for include my tmux.conf
#set-option -g @plugin "#tmux-plugins/tmux-sensible"


#--------------------------------------------------------------#
##          Install/Execute tpm                               ##
#--------------------------------------------------------------#

set-environment -g TMUX_PLUGIN_MANAGER_PATH "${TMUX_DATA_DIR}/plugins"
if '[ ! -d ${TMUX_PLUGIN_MANAGER_PATH}/tpm ]' \
  'run-shell "git clone --depth 1 https://github.com/tmux-plugins/tpm ${TMUX_PLUGIN_MANAGER_PATH}/tpm"'

if '[ -f ${TMUX_PLUGIN_MANAGER_PATH}/tpm/tpm ]' \
  'run-shell "${TMUX_PLUGIN_MANAGER_PATH}/tpm/tpm"'


#--------------------------------------------------------------#
##          Non tpm plugins                                   ##
#--------------------------------------------------------------#


#--------------------------------------------------------------#
##          Disable Non tpm Plugins                           ##
#--------------------------------------------------------------#

# not maintenanced -> 'tmux-plugins/tmux-cpu'
# set -g @plugin 'samoshkin/tmux-plugin-sysstat'
# Management is awkward. Also finger is not so slow
# if '[ -f ~/.tmux/conf/scripts/install-tmux-thumbs.sh ]' \
#   'run-shell "~/.tmux/conf/scripts/install-tmux-thumbs.sh"'
# if '[ -r ~/.tmux/plugins/tmux-thumbs/tmux-thumbs.tmux ]' \
#   'run-shell "~/.tmux/plugins/tmux-thumbs/tmux-thumbs.tmux"'

# Heavy processing
#set -g @plugin 'tmux-plugins/tmux-net-speed'
#set -g @plugin 'samoshkin/tmux-plugin-sysstat'


#--------------------------------------------------------------#
##          Plugins Config                                    ##
#--------------------------------------------------------------#

#set-option -g @themepack-status-right-area-middle-format "%Y-%m-%d"
#set-option -g @themepack 'powerline/double/cyan'
