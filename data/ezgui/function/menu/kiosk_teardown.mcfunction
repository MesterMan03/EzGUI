# AS player — take the shared kiosk down only when the last user has left.
$execute unless entity @a[scores={ezgui.timer=1..}] if block $(bx) $(by) $(bz) $(block) run setblock $(bx) $(by) $(bz) air destroy
