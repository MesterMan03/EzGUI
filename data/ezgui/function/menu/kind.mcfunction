# Copy the widget kind markers of ctx.w into flat keys (ctx.k_*).
#
# A macro can only test flat keys, and the kind of a widget decides which state_pick
# branch runs, so it is lifted out of the definition in ONE place and used by every
# stage (draw, detect, click). Exactly one of these is present per widget.
data remove storage ezgui:ctx k_toggle
data remove storage ezgui:ctx k_cycle
data remove storage ezgui:ctx k_radio
data remove storage ezgui:ctx k_indicator
data remove storage ezgui:ctx k_progress
data remove storage ezgui:ctx k_stateful
data modify storage ezgui:ctx k_toggle set from storage ezgui:ctx w.e[0].toggle
data modify storage ezgui:ctx k_cycle set from storage ezgui:ctx w.e[0].cycle
data modify storage ezgui:ctx k_radio set from storage ezgui:ctx w.e[0].radio
data modify storage ezgui:ctx k_indicator set from storage ezgui:ctx w.e[0].indicator
data modify storage ezgui:ctx k_progress set from storage ezgui:ctx w.e[0].progress
# "stateful" also covers a plain multi-state widget (a button with an extra look):
# anything that can change appearance has to be repainted when its score moves.
data modify storage ezgui:ctx k_stateful set from storage ezgui:ctx w.e[1]
