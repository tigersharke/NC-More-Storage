-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local function temper(name, desc, sound, glow, dmg)

local form = "nc_lode_"..name..".png^[mask:nc_api_storebox_frame.png"

local side = "(nc_lode_"..name..".png^[mask:nc_lode_shelf_base.png)^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_toolrack_" ..name, {
		description = desc.. " Lode Tool Rack",
		tiles = {form, side, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			metallic = 1,
			lode_toolrack = 1,
			damage_touch = dmg
		},
		paramtype = "light",
		sunlight_propagates = true,
		sounds = nodecore.sounds(sound),
		storebox_access = function(pt) return pt.above.y >= pt.under.y end,
	})

end

temper("annealed",	"Annealed",	"nc_lode_annealed",	false,	0)
temper("tempered",	"Tempered",	"nc_lode_tempered",	false,	0)
temper("hot",		"Glowing",	"nc_lode_annealed",	true,	0)

nodecore.register_craft({
	label = "heat lode toolrack",
	action = "cook",
	touchgroups = {flame = 3},
	duration = 30,
	cookfx = true,
	indexkeys = {"group:lode_toolrack"},
	nodes = {
		{
			match = {groups = {lode_toolrack = true}},
			replace = modname .. ":shelf_toolrack_hot"
		}
	}
})


nodecore.register_craft({
	label = "assemble toolrack",
	action = "stackapply",
	indexkeys = {"nc_lode:form"},
	wield = {name = "nc_lode:prill_annealed"},
	consumewield = 1,
	nodes = {
		{
			match = {name = "nc_lode:form", empty = true},
			replace = modname .. ":shelf_toolrack_annealed"
		},
	}
})
	
nodecore.register_craft({
	label = "assemble tempered toolrack",
	action = "stackapply",
	indexkeys = {"nc_lode:form"},
	wield = {name = "nc_lode:prill_tempered"},
	consumewield = 1,
	nodes = {
		{
			match = {name = "nc_lode:form", empty = true},
			replace = modname .. ":shelf_toolrack_tempered"
		},
	}
})

nodecore.register_craft({
	label = "disassemble toolrack",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 5},
	indexkeys = {modname..":shelf_toolrack_hot"},
	nodes = {{match = {name = modname..":shelf_toolrack_hot", empty = true}, replace = "nc_lode:form"}},
	items = {{name = "nc_lode:prill_hot", count = 1, scatter = 2}}
})

nodecore.register_craft({
	label = "disassemble toolrack",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 5},
	indexkeys = {modname..":shelf_toolrack_annealed"},
	nodes = {{match = {name = modname..":shelf_toolrack_annealed", empty = true}, replace = "nc_lode:form"}},
	items = {{name = "nc_lode:prill_annealed", count = 1, scatter = 2}}
})
