# One "items" test. target/slot/id/mid/page are all prepared by the caller; the id is
# substituted straight into the predicate.
$execute unless items $(target) container.$(slot) *[custom_data~{ezgui:{w:1,id:"$(id)",m:$(mid),p:$(page)}}] run function ezgui:menu/click with storage ezgui:ctx
