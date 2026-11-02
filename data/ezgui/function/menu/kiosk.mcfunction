# AS player — a block kiosk is shared by everyone who opens this menu: place it once.
$execute unless block $(bx) $(by) $(bz) $(block) run setblock $(bx) $(by) $(bz) $(kiosk_state)
